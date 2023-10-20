part of 'active_symbols_bloc.dart';

/// ActiveSymbolsEvent
abstract class ActiveSymbolsEvent {}

/// FetchActiveSymbols
class FetchActiveSymbols extends ActiveSymbolsEvent {
  /// Initializes
  FetchActiveSymbols();

  @override
  String toString() => 'FetchActiveSymbols';
}

/// SelectActiveSymbol
class SelectMarketSymbol extends ActiveSymbolsEvent {
  /// Initializes
  SelectMarketSymbol(this.index);

  /// Index of selected symbol
  final int index;

  @override
  String toString() => 'SelectMarketSymbol index: $index';
}

class SelectMarketName extends ActiveSymbolsEvent {
  /// Initializes
  SelectMarketName(this.index);

  /// Index of selected symbol
  final int index;

  @override
  String toString() => 'SelectMarketName index: $index';
}
