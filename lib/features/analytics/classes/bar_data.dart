import 'individual_bar.dart';

class BarData {
  final double electronics;
  final double fashion;
  final double books;
  final double health;
  final double furniture;
  final double entertainment;
  final double other;

  BarData({
    required this.electronics,
    required this.fashion,
    required this.books,
    required this.health,
    required this.furniture,
    required this.entertainment,
    required this.other,
  });

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: electronics),
      IndividualBar(x: 1, y: fashion),
      IndividualBar(x: 2, y: books),
      IndividualBar(x: 3, y: health),
      IndividualBar(x: 4, y: furniture),
      IndividualBar(x: 5, y: entertainment),
      IndividualBar(x: 6, y: other),
    ];
  }
}
