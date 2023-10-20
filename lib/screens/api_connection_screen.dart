import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_deriv_api/services/connection/api_manager/connection_information.dart';
import 'package:flutter_deriv_api/state/connection/connection_cubit.dart'
    as api_connection;
import './main_screen.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  HomeScreen({required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late api_connection.ConnectionCubit _connectionCubit;

  @override
  void initState() {
    super.initState();

    _connectionCubit = api_connection.ConnectionCubit(
      ConnectionInformation(
        appId: '1089',
        brand: 'binary',
        endpoint: 'frontend.binaryws.com',
      ),
    );
  }

  @override
  void dispose() {
    _connectionCubit.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<api_connection.ConnectionCubit>.value(
      value: _connectionCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: BlocBuilder<api_connection.ConnectionCubit,
            api_connection.ConnectionState>(
          builder: (
            _,
            state,
          ) {
            if (state is api_connection.ConnectionConnectedState) {
              return MainScreen();
            } else if (state is api_connection.ConnectionInitialState ||
                state is api_connection.ConnectionConnectingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is api_connection.ConnectionErrorState) {
              return _buildCenterText('Connection Error\n${state.error}');
            } else if (state is api_connection.ConnectionDisconnectedState) {
              return _buildCenterText(
                'Connection is down, trying to reconnect...',
              );
            }

            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildCenterText(String text) => Center(
        child: Text(text),
      );
}
