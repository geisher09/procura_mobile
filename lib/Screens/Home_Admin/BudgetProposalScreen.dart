import 'package:flutter/material.dart';

class BudgetProposalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.light? Colors.black:Colors.white,//change your color here
        ),
        title: Text("Screen for Budget Proposal",
          style: new TextStyle(
              color: Theme.of(context).brightness == Brightness.light? Colors.black:Colors.white,
              fontSize: 13.0,
              fontWeight: FontWeight.w400
          ),
        ),
        elevation: 0.0,
        backgroundColor:Colors.transparent,
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}