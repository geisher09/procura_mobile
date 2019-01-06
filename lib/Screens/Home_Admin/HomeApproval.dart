import 'package:flutter/material.dart';
import 'package:procura/Screens/Home_Admin/ApprovalScreen2.dart';

class approvalwidgets extends StatelessWidget {
  final text1;
  final text2;
  final text3;
  final w1;
  final date;
  final time;
  final conwidth;

  const approvalwidgets(
      {Key key,
      this.text1,
      this.text2,
      this.text3,
      this.w1,
      this.date,
      this.time,
      this.conwidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ApprovalScreen2(text2,text1,date,time)),
        );
      },
      child: Container(
        decoration: new BoxDecoration(
            border: Border(
          bottom: BorderSide(
              color: Colors.grey, width: 0.5, style: BorderStyle.solid),
        )),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
              child: Container(
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/user2.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                width: 35.0,
                height: 35.0,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  height: 15.0,
                  width: MediaQuery.of(context).orientation == Orientation.portrait ?
                  conwidth : MediaQuery.of(context).size.width / 1.15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          text1,
                          style: new TextStyle(
                              fontSize: 13.5,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        date,
                        style: new TextStyle(
                            fontSize: 10,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            color: Colors.blue[700]),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          text2,
                          style: new TextStyle(
                              fontSize: 12,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        text3,
                        style: new TextStyle(fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        width: w1,
        height: 70.0,
      ),
    );
  }
}

class HomeApproval extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var w1 = MediaQuery.of(context).size.width;
    var w2 = MediaQuery.of(context).size.width / 1.25;

    List<Widget> approvals = new List.generate(
        15,
        (i) => new approvalwidgets(
              w1: w1,
              text1: "Audrey Noelle Waje",
              text2: "SUBJECT TITLE",
              text3: "Laman na Docu",
              date: "30/12/2018",
              time: "3:55 PM",
              conwidth: w2,
            ));

    return Container(
      alignment: Alignment.topLeft,
      child: new SingleChildScrollView(
          child: ConstrainedBox(
        constraints: BoxConstraints(),
        child: Column(
          children: approvals,
        ),
      )),
    );
  }
}
