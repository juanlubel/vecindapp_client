import 'package:flutter/material.dart';

class ApartmentForm extends StatefulWidget {
  ApartmentForm(this.pk);
  final int pk;

  @override
  _ApartmentFormState createState() => _ApartmentFormState();
}

class _ApartmentFormState extends State<ApartmentForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('_ApartmentFormState' + widget.pk.toString()),
    );
  }
}