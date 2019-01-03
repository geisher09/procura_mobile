import 'package:flutter/material.dart';
import 'package:procura/Screens/Login/LoginInputFields.dart';

class FormContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (new Container(
      margin: new EdgeInsets.symmetric(horizontal: 25.0,
          vertical: 1.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Form(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new InputFieldArea(
                    hint: "Username",
                    obscure: false,
                    icon: Icons.account_circle,
                  ),
                  new Container(
                    height: 8.0,
                  ),
                  new InputFieldArea(
                    hint: "Password",
                    obscure: true,
                    icon: Icons.lock,
                  ),
                ],
              )),
        ],
      ),
    ));
  }
}
