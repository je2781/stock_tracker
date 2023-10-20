import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/ticks/ticks_bloc.dart';

class SymbolPriceWidget extends StatefulWidget {
  final TicksBloc ticksBloc;
  const SymbolPriceWidget(this.ticksBloc);

  @override
  State<SymbolPriceWidget> createState() => _SymbolPriceWidgetState();
}

class _SymbolPriceWidgetState extends State<SymbolPriceWidget> {
  double? _lastTickValue = 0;

  @override
  void dispose() {
    widget.ticksBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(
          child: BlocBuilder<TicksBloc, TicksState>(
              bloc: widget.ticksBloc,
              builder: (_, state) {
                if (state is TicksLoaded) {
                  final Color tickColor = state.tick!.ask! > _lastTickValue!
                      ? Colors.green
                      : state.tick!.ask == _lastTickValue
                          ? Colors.grey
                          : state.tick!.ask! < _lastTickValue!
                              ? Colors.red
                              : Colors.black;

                  _lastTickValue = state.tick!.ask;

                  return Padding(
                    padding: const EdgeInsets.all(2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Price: ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${state.tick?.ask?.toStringAsFixed(5)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: tickColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                if (state is TicksError) {
                  return const Text(
                    '----',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  );
                }
                if (state is TicksLoading) {
                  return const CircularProgressIndicator();
                }
                return const Text(
                  '----',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                );
              }),
        ),
      ],
    );
  }
}
