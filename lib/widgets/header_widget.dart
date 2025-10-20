import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeaderItem extends StatelessWidget {
  HeaderItem({super.key});
  final String formattedData = DateFormat('MMM dd, y').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidht = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.purple,
        image: DecorationImage(
          image: AssetImage("lib/assets/images/header.png"),
          fit: BoxFit.fill,
        ),
      ),
      width: deviceWidht,
      height: deviceHeight / 3,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              formattedData,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              "My Tasks",
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
