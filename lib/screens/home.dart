import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text('Vecindapp'),
//      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          HomeImage(),
        ],
      ),
    );

  }

}

class HomeImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
//      onTap: () {Navigator.pushNamed(context, '/list');},
      child: Image.asset(
        'assets/images/home_logo.png',
        fit: BoxFit.cover,
      ),
    );
  }

}