import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:intl/intl.dart';

class HorizontalBarChartWithLevels extends StatefulWidget {
  final List<double> values;
  final Map<String, dynamic> answers; // Prijímame odpovede ako parameter

  const HorizontalBarChartWithLevels({
    super.key,
    required this.values,
    required this.answers, // Odovzdáme odpovede
  });

  @override
  State<HorizontalBarChartWithLevels> createState() =>
      _HorizontalBarChartWithLevelsState();
}

class _HorizontalBarChartWithLevelsState
    extends State<HorizontalBarChartWithLevels> {
  int touchedIndex = -1;

  List<Color> barColors = [
    Colors.orange,
    Colors.lime,
    Colors.green,
    Colors.pink,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const MyHomePage(title: 'M.A.S.S.'),
            ),
            (route) => false,
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.home),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              // Container s informáciami o používateľovi (odpovede)
              Container(
                color: const Color.fromRGBO(33, 150, 243, 1),
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'VÝSLEDKY TESTU',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    // Zobrazenie odpovedí o používateľovi
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.answers.entries.map((entry) {
                        String displayValue = entry.value.toString();
                        if (entry.value is DateTime) {
                          displayValue = DateFormat('dd. MMMM yyyy', 'sk')
                              .format(entry.value as DateTime);
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            displayValue,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 800,
                width: 1000,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceBetween,
                      maxY: 40,
                      minY: -40,
                      barTouchData: BarTouchData(
                        touchCallback: (FlTouchEvent event, barTouchResponse) {
                          if (!event.isInterestedForInteractions ||
                              barTouchResponse == null ||
                              barTouchResponse.spot == null) {
                            setState(() {
                              touchedIndex = -1;
                            });
                            return;
                          }
                          setState(() {
                            touchedIndex =
                                barTouchResponse.spot!.touchedBarGroupIndex;
                          });
                        },
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 110,
                            getTitlesWidget: (value, meta) {
                              if (value == 20) {
                                return const Text(
                                  'VYSOKÁ ŠANCA',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor: Colors.red),
                                );
                              } else if (value == 0) {
                                return const Text(
                                  'STREDNÁ ŠANCA',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor: Colors.yellow),
                                );
                              } else if (value == -20) {
                                return const Text(
                                  'NÍZKA ŠANCA',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor: Colors.blue),
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          ),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 25,
                            getTitlesWidget: (value, meta) {
                              if (value == 0) {
                                return const Text(
                                  'SEX',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              } else if (value == 1) {
                                return const Text(
                                  'FYZ',
                                  style: TextStyle(
                                    color: Colors.lime,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              } else if (value == 2) {
                                return const Text(
                                  'PSY',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              } else if (value == 3) {
                                return const Text(
                                  ' ZAN ',
                                  style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              } else {
                                return const Text(' ');
                              }
                            },
                          ),
                        ),
                        rightTitles: const AxisTitles(
                            sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 100,
                        )),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              if (value == 0) {
                                return const Text(
                                  'SEX',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              } else if (value == 1) {
                                return const Text(
                                  'FYZ',
                                  style: TextStyle(
                                    color: Colors.lime,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              } else if (value == 2) {
                                return const Text(
                                  'PSY',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              } else if (value == 3) {
                                return const Text(
                                  ' ZAN ',
                                  style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              } else {
                                return const Text(' ');
                              }
                            },
                          ),
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        getDrawingHorizontalLine: (value) {
                          Color bgColor = Colors.transparent;
                          if (value == 20) {
                            bgColor = Colors.red; // Farba pre VYSOKÁ ŠANCA
                          } else if (value == -20) {
                            bgColor = Colors.blue;
                          } else if (value == 0) {
                            bgColor = Colors.yellow;
                          }
                          return FlLine(
                            color: bgColor,
                            strokeWidth:
                                1, // Zvýšená hrúbka čiary pre vytvorenie farebného pozadia
                          );
                        },
                      ),
                      barGroups: widget.values.asMap().entries.map((entry) {
                        int index = entry.key;
                        double value = entry.value;
                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: value,
                              color: barColors[index % barColors.length],
                              width: 25,
                              borderRadius: value > 0
                                  ? const BorderRadius.only(
                                      topRight: Radius.circular(4),
                                      bottomRight: Radius.circular(0))
                                  : const BorderRadius.only(
                                      topRight: Radius.circular(0),
                                      bottomRight: Radius.circular(4)),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
