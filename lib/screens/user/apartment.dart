import 'package:flutter/material.dart';
import 'package:vecinapp/core/navigators/lobbyNavigator.dart';

class ApartmentScreen extends StatelessWidget with NavigationStates  {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Apartment",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );
  }
}