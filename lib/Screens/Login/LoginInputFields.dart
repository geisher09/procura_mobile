import 'package:flutter/material.dart';

class InputFieldArea extends StatelessWidget {
  final String hint;
  final bool obscure;
  final IconData icon;
  InputFieldArea({this.hint, this.obscure, this.icon});
  @override
  Widget build(BuildContext context) {
    return (new Container(
      decoration: new BoxDecoration(
        border: new Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: new TextFormField(
        obscureText: obscure,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: new InputDecoration(
          icon: new Icon(
            icon,
            color: Colors.black,
          ),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w500),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        ),
      ),
    ));
  }
}
