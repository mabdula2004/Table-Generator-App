class CalculateBrain {
  final int number;
  final int startLimit;
  final int endLimit;

  CalculateBrain({required this.number, required this.startLimit, required this.endLimit});

  List<String> generateTable() {
    List<String> table = [];
    for (int i = startLimit; i <= endLimit; i++) {
      table.add('$number x $i = ${number * i}');
    }
    return table;
  }
}
