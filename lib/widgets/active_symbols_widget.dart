import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';

import '../blocs/active_symbols/active_symbols_bloc.dart';
import '../blocs/ticks/ticks_bloc.dart';

import './market_names_list_dialog.dart';
import './market_symbols_list_dialog.dart';
import './symbol_price_widget.dart';

/// ActiveSymbolsWidget
class ActiveSymbolsWidget extends StatefulWidget {
  @override
  _ActiveSymbolsWidgetState createState() => _ActiveSymbolsWidgetState();
}

class _ActiveSymbolsWidgetState extends State<ActiveSymbolsWidget> {
  ActiveSymbolsBloc? _activeSymbolsBloc;
  TicksBloc? _ticksBloc;

  @override
  void initState() {
    super.initState();

    _activeSymbolsBloc = BlocProvider.of<ActiveSymbolsBloc>(context)
      ..add(FetchActiveSymbols());
    _ticksBloc = TicksBloc(_activeSymbolsBloc!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(50),
          child: BlocBuilder<ActiveSymbolsBloc, ActiveSymbolsState>(
            bloc: _activeSymbolsBloc,
            builder: (_, state) {
              if (state is ActiveSymbolsLoaded) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 6,
                              ),
                              child: Text(
                                state.selectedMarket!,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) =>
                                    BlocProvider<ActiveSymbolsBloc>.value(
                                  value: _activeSymbolsBloc!,
                                  child: MarketNamesListDialog(),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 6,
                              ),
                              child: Text(
                                state.selectedMarketSymbol!,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) =>
                                    BlocProvider<ActiveSymbolsBloc>.value(
                                  value: _activeSymbolsBloc!,
                                  child: MarketSymbolsListDialog(),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              if (state is ActiveSymbolsError) {
                return Text(state.message ?? 'An error occurred');
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2),
          child: SymbolPriceWidget(_ticksBloc!),
        ),
      ],
    );
  }
}
