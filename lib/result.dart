import 'package:flutter/material.dart';
import 'package:table_generator_app/tStyle.dart';
import 'container.dart';
import 'calculateData.dart';
import 'Quiz.dart';

class Result extends StatefulWidget {
  final int number;
  final int startLimit;
  final int endLimit;

  Result({
    required this.number,
    required this.startLimit,
    required this.endLimit,
  });

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  int currentPage = 0;
  final int itemsPerPage = 3 * 6; // 3 rows with 6 columns each

  @override
  Widget build(BuildContext context) {
    final CalculateBrain calcBrain = CalculateBrain(
      number: widget.number,
      startLimit: widget.startLimit,
      endLimit: widget.endLimit,
    );
    final List<String> table = calcBrain.generateTable();

    // Calculate the total number of pages
    int totalPages = (table.length / itemsPerPage).ceil();

    // Calculate the text size based on the endLimit
    double textSize = 20.0;
    if (widget.endLimit > 10) {
      textSize = 20.0 - (widget.endLimit - 10) * 0.3; // Reduce text size further
      if (textSize < 8.0) { // Allow smaller text size
        textSize = 8.0;
      }
    }

    // Calculate the start and end index for the current page
    int startIndex = currentPage * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    if (endIndex > table.length) {
      endIndex = table.length;
    }

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
                  'Table of ${widget.number}',
                  style: titleStyle,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: RepeatContainer(
              color: activeColor,
              cardWidget: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 6 columns
                  childAspectRatio: 2.0, // Adjust aspect ratio if needed
                  mainAxisSpacing: 20.0, // Space between rows
                  crossAxisSpacing: 20.0, // Space between columns
                ),
                itemCount: endIndex - startIndex,
                itemBuilder: (context, index) {
                  return Center(
                    child: Text(
                      table[startIndex + index],
                      style: TextStyle(fontSize: 14),
                    ),
                  );
                },
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Quiz(
                number: widget.number,
                startLimit: widget.startLimit,
                endLimit: widget.endLimit,
              )));
            },
            child: Container(
              child: Center(child: Text("Generate Quiz", style: cStyle)),
              color: Color(0xFFEB1555),
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              height: 97.0,
            ),
          ),
          if (totalPages > 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (currentPage > 0)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentPage--;
                      });
                    },
                    child: Text('Previous',
                      style:TextStyle(
                        fontSize: 25,
                      ) ,
                    ),
                  ),
                if (currentPage < totalPages - 1)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentPage++;
                      });
                    },
                    child: Text('Next',
                    style:TextStyle(
                      fontSize: 25,
                    ) ,
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
