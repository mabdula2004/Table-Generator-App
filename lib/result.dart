import 'package:flutter/material.dart';
import 'package:table_generator_app/tStyle.dart';
import 'container.dart';
import 'calculateData.dart';
import 'Quiz.dart';

class Result extends StatelessWidget {
  final int number;
  final int startLimit;
  final int endLimit;

  Result({
    required this.number,
    required this.startLimit,
    required this.endLimit,
  });

  @override
  Widget build(BuildContext context) {
    // Create an instance of CalculateBrain
    final CalculateBrain calcBrain = CalculateBrain(number: number, startLimit: startLimit, endLimit: endLimit);
    final List<String> table = calcBrain.generateTable();

    // Determine the text size based on the endLimit
    double textSize = 20.0;
    if (endLimit > 10) {
      textSize = 20.0 - (endLimit - 10) * 0.5;
      if (textSize < 10.0) {
        textSize = 10.0;
      }
    }

    // Determine the number of columns based on the endLimit
    int columns = (endLimit / 10).ceil();

    return Scaffold(
      appBar: AppBar(
        title: Text('Table'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              child: Center(
                child: Text(
                  'Table of $number',
                  style: titleStyle,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: RepaeatContainer(
              color: activeColor,
              cardWidget: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  childAspectRatio: 3.0,
                ),
                itemCount: table.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Text(
                      table[index],
                      style: TextStyle(fontSize: textSize),
                    ),
                  );
                },
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Quiz(
                number: number,
                startLimit: startLimit,
                endLimit: endLimit,
              )));
            },
            child: Container(
              child: Center(child: Text("Generate Quiz", style: cStyle)),
              color: Color(0xFFEB1555),
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
