library event_crew;

import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {

  const IntroScreen({super.key});

  @override
  IntroScreenState createState() {
    return IntroScreenState();
  }
}

class IntroScreenState extends State<IntroScreen> {

  final PageController controller = PageController();
  int currentPage = 0;
  bool lastPage = false;

  // void _onPageChanged(int page) {
  //   setState(() {
  //     currentPage = page;
  //     if (currentPage == 3) {
  //       lastPage = true;
  //     } else {
  //       lastPage = false;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEEEEEE),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  onPressed: null,
                  child: Text(lastPage ? "" : "SKIP",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0)
                        )
                  // () =>
                  //     lastPage ? null : MyNavigator.goToHome(context),
                ),
                ElevatedButton(
                  onPressed: null,
                  child: Text(lastPage ? "GOT IT" : "NEXT",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0))
                  // () => lastPage
                  //     ? MyNavigator.goToHome(context)
                  //     : controller.nextPage(
                  //         duration: Duration(milliseconds: 300),
                  //         curve: Curves.easeIn),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
