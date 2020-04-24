import 'package:flutter/material.dart';
import 'package:vecinapp/core/navigators/lobbyNavigator.dart';

class DashboardScreen extends StatelessWidget with NavigationStates  {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Dashboard",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );
  }
}