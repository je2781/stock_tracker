part of 'active_symbols_bloc.dart';

/// ActiveSymbolsState
abstract class ActiveSymbolsState {
  /// Initializes
  ActiveSymbolsState();
}

/// ActiveSymbolsLoading
class ActiveSymbolsLoading extends ActiveSymbolsState {
  @override
  String toString() => 'ActiveSymbolsLoading...';
}

/// ActiveSymbolsError
class ActiveSymbolsError extends ActiveSymbolsState {
  /// Initializes
  ActiveSymbolsError(this.message);

  /// Error message
  final String? message;

  @override
  String toString() => 'ActiveSymbolsError';
}

/// ActiveSymbolsLoaded
class ActiveSymbolsLoaded extends ActiveSymbolsState {
  /// Initializes
  ActiveSymbolsLoaded(
      {this.activeSymbols,
      String? marketSymbolDisplayName,
      ActiveSymbol? selectedSymbol,
      this.marketNames,
      String? selectedMarket})
      : _selectedMarket = selectedMarket ?? 'Select a Market',
        _selectedMarketSymbol = marketSymbolDisplayName ?? 'Select an Asset',
        _selectedSymbol = selectedSymbol ?? ActiveSymbol(symbol: '');

  /// List of symbols
  final List<ActiveSymbol>? activeSymbols;

  final List<String?>? marketNames;

  final String? _selectedMarket;

  final String? _selectedMarketSymbol;

  final ActiveSymbol? _selectedSymbol;

  /// Selected market
  String? get selectedMarket => _selectedMarket;

  /// Selected market symbol
  String? get selectedMarketSymbol => _selectedMarketSymbol;

  /// Selected market symbol
  ActiveSymbol? get selectedSymbol => _selectedSymbol;

  List<String?> get marketSymbolDisplayNames => activeSymbols!
      .where(
          (activeSymbol) => activeSymbol.marketDisplayName == _selectedMarket)
      .toList()
      .map((updatedActiveSymbol) => updatedActiveSymbol.displayName)
      .toList();

  List<ActiveSymbol?> get marketSymbols => activeSymbols!
      .where(
          (activeSymbol) => activeSymbol.marketDisplayName == _selectedMarket)
      .toList();

  @override
  String toString() => 'ActiveSymbolsLoaded ${activeSymbols!.length} symbols';
}
