import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class StopwatchHome extends StatefulWidget {
  const StopwatchHome({
    Key? key,
  }) : super(key: key);

  @override
  _StopwatchHomeState createState() => _StopwatchHomeState();
}

class _StopwatchHomeState extends State<StopwatchHome> {
  bool isDarkMode = false;
  bool isStopwatchStart = false;

  final lightBgColor = Color(0xFFEBECF0);
  final lightTextColor = Color(0xFF0A364F);
  final lightDarkColor = Color(0xFF1C1F29);
  final darkBgColor = Color(0xFF1C1F29);
  final darkTextColor = Color(0xFF22A0E7);

  StopWatchTimer _timer = StopWatchTimer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? lightDarkColor : lightBgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Tooltip(
              message: isDarkMode ? 'Light Mode' : 'Dark Mode',
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      isDarkMode = !isDarkMode;
                    });
                  },
                  icon: Icon(
                    isDarkMode
                        ? Icons.brightness_4_rounded
                        : Icons.brightness_7_rounded,
                    color: isDarkMode ? darkTextColor : lightTextColor,
                    size: 30.0,
                  )),
            ),
          )
        ],
      ),
      body: StreamBuilder<int>(
          stream: _timer.rawTime,
          initialData: _timer.rawTime.value,
          builder: (context, snapshot) {
            final value = snapshot.data;
            final displayTime = StopWatchTimer.getDisplayTime(
              value!,
              hours: true,
            );
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: isDarkMode ? Color(0xFF000000) : Colors.grey,
                          offset: const Offset(
                            10,
                            09,
                          ),
                          blurRadius: 19,
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: isDarkMode ? darkTextColor : Colors.white,
                          offset: const Offset(
                            -5,
                            -4,
                          ),
                          blurRadius: 5,
                          spreadRadius: 0,
                        ),
                      ],
                      color: isDarkMode ? Color(0xFF1C1F29) : lightBgColor,
                    ),
                    child: Center(
                      child: Text(
                        displayTime,
                        style: TextStyle(
                            fontSize: 50,
                            letterSpacing: 7,
                            color: isDarkMode ? darkTextColor : lightTextColor),
                      ),
                    ),
                  ),
                  Tooltip(
                    message: isStopwatchStart ? 'STOP' : 'START',
                    child: InkWell(
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        setState(() {
                          isStopwatchStart = !isStopwatchStart;
                        });
                        if (isStopwatchStart) {
                          _timer.onExecute.add(StopWatchExecute.start);
                        } else {
                          _timer.onExecute.add(StopWatchExecute.stop);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  isDarkMode ? Color(0xFF000000) : Colors.grey,
                              offset: const Offset(
                                7,
                                7,
                              ),
                              blurRadius: 13,
                              spreadRadius: -4,
                            ),
                            BoxShadow(
                              color: isDarkMode ? darkTextColor : Colors.white,
                              offset: const Offset(
                                -3,
                                -3,
                              ),
                              blurRadius: 4,
                              spreadRadius: 0,
                            ),
                          ],
                          color: isDarkMode ? Color(0xFF1C1F29) : lightBgColor,
                        ),
                        child: Center(
                          child: Text(
                            isStopwatchStart ? 'STOP' : 'START',
                            style: TextStyle(
                                fontSize: 35.0,
                                color:
                                    isDarkMode ? darkTextColor : lightTextColor,
                                letterSpacing: 5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Tooltip(
                    message: 'Reset',
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isStopwatchStart = false;
                        });
                        _timer.onExecute.add(StopWatchExecute.reset);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  isDarkMode ? Color(0xFF1C1F29) : lightBgColor,
                              boxShadow: [
                                BoxShadow(
                                  color: isDarkMode
                                      ? Color(0xFF000000)
                                      : Colors.grey,
                                  offset: const Offset(
                                    7,
                                    7,
                                  ),
                                  blurRadius: 13,
                                  spreadRadius: -4,
                                ),
                                BoxShadow(
                                  color:
                                      isDarkMode ? darkTextColor : Colors.white,
                                  offset: const Offset(
                                    -3,
                                    -3,
                                  ),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.refresh,
                              size: 30.0,
                              color:
                                  isDarkMode ? darkTextColor : lightTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
