import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';
import '../blocs/active_symbols/active_symbols_bloc.dart';

/// ActiveSymbolsListDialog
class MarketSymbolsListDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ActiveSymbolsBloc, ActiveSymbolsState>(
        builder: (_, state) {
          if (state is ActiveSymbolsLoaded) {
            return Material(
              child: ListView.builder(
                itemCount: state.marketSymbols.length,
                itemBuilder: (_, index) {
                  final String? displayName =
                      state.marketSymbolDisplayNames[index];

                  return ListTile(
                    title: Text(displayName!),
                    onTap: () {
                      BlocProvider.of<ActiveSymbolsBloc>(context)
                          .add(SelectMarketSymbol(index));
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
}
