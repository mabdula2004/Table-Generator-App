import 'package:flutter/material.dart';
import 'package:table_generator_app/result.dart';
import 'package:table_generator_app/tStyle.dart';
import 'container.dart';

enum Number { number, startLimit, endLimit }

class Input extends StatefulWidget {
  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  Number? selectnum;
  int number = 10;
  int startLimit = 10; // Adjusted initial value
  int endLimit = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table Calculator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: RepeatContainer(
              color: Color(0xFF1D1E33),
              cardWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Table Number',
                    style: tStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        number.toString(),
                        style: nStyle,
                      ),
                    ],
                  ),
                  Slider(
                    value: number.toDouble(),
                    min: 1,
                    max: 100,
                    activeColor: Color(0XFFEB1555),
                    inactiveColor: Color(0xFF8D8E98),
                    onChanged: (double newValue) {
                      setState(() {
                        number = newValue.round();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: RepeatContainer(
              color: Color(0xFF1D1E33),
              cardWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Table Starting Point',
                    style: tStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        startLimit.toString(),
                        style: nStyle,
                      ),
                    ],
                  ),
                  Slider(
                    value: startLimit.toDouble(),
                    min: 1,
                    max: 100,
                    activeColor: Color(0XFFEB1555),
                    inactiveColor: Color(0xFF8D8E98),
                    onChanged: (double newValue) {
                      setState(() {
                        startLimit = newValue.round();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: RepeatContainer(
              color: Color(0xFF1D1E33),
              cardWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Table Ending Limit',
                    style: tStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        endLimit.toString(),
                        style: nStyle,
                      ),
                    ],
                  ),
                  Slider(
                    value: endLimit.toDouble(),
                    min: 1,
                    max: 100,
                    activeColor: Color(0XFFEB1555),
                    inactiveColor: Color(0xFF8D8E98),
                    onChanged: (double newValue) {
                      setState(() {
                        endLimit = newValue.round();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Result(
                    number: number,
                    startLimit: startLimit,
                    endLimit: endLimit,
                  ),
                ),
              );
            },
            child: Container(
              child: Center(
                child: Text(
                  "Generate Table",
                  style: cStyle,
                ),
              ),
              color: Color(0xFFEB1555),
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              height: 80,
            ),
          ),
        ],
      ),
    );
  }
}
