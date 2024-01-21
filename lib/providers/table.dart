import 'package:flutter_riverpod/flutter_riverpod.dart';

final tableProvider =
    StateNotifierProvider<_TableNotifier, int?>((ref) => _TableNotifier());

class _TableNotifier extends StateNotifier<int?> {
  _TableNotifier() : super(null);

  void changeSelectedTable(int? selectedTable) {
    state = selectedTable;
  }
}
