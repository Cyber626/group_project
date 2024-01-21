class Order {
  const Order({
    required this.id,
    required this.restaurant,
    required this.selectedBranch,
    required this.numberOfGuests,
    required this.table,
    required this.phoneNumber,
    required this.date,
  });

  final String id;
  final String restaurant;
  final int selectedBranch;
  final int numberOfGuests;
  final int table;
  final String phoneNumber;
  final DateTime date;
}
