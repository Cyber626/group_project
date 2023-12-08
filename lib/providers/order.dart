import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_project/models/order.dart';

final orderProvider = StateNotifierProvider<_OrderNotifier, List<Order>>(
    (ref) => _OrderNotifier());

class _OrderNotifier extends StateNotifier<List<Order>> {
  _OrderNotifier() : super([]);

  void addOrder(Order order) {
    state = [...state, order];
  }

  void removeOrder(Order order) {
    state = state.where((element) => element != order).toList();
  }
}
