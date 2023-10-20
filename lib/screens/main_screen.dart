import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/active_symbols/active_symbols_bloc.dart';
import '../widgets/active_symbols_widget.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  dynamic _activeSymbolsBloc;

  @override
  void initState() {
    super.initState();

    _activeSymbolsBloc = ActiveSymbolsBloc();
  }

  @override
  void dispose() {
    _activeSymbolsBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ActiveSymbolsBloc>.value(
      value: _activeSymbolsBloc,
      child: ActiveSymbolsWidget(),
    );
  }
}
