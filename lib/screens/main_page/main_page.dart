import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: Colors.accents.length,
          itemBuilder: (context, i) => Container(
                width: 350,
                height: 350,
                color: Colors.accents[i],
              )),
    );
  }
}
