import 'package:flutter/material.dart';
import 'package:procura/Components/custom_icons.dart';
import 'package:procura/Screens/Home_Admin/BottomNavBar/sampscreen4.dart';

class notifwidgets extends StatelessWidget {
  final notiftexts;
  final w1;
  final date;
  final conwidth;

  const notifwidgets(
      {Key key,
        this.notiftexts,
        this.w1,
        this.date,
        this.conwidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => sampscreen4()),
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
                child: Icon(
                  CustomIcons.like_2,
                  size: 25.0,
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
                  height: 30.0,
                  width: conwidth,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Row(
                      children: <Widget>[
                        notiftexts
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        date,
                        style: new TextStyle(fontSize: 11.0),
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

class HomeNotifs extends StatelessWidget {
  final String host;
  final List list;
  const HomeNotifs({Key key, this.host, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var w1 = MediaQuery.of(context).size.width;
    var w2 = MediaQuery.of(context).size.width / 1.25;

    Widget notifDetails() {
      return new Expanded(
        child: RichText(
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          text: new TextSpan(
            style: new TextStyle(
              fontSize: 12,
              fontFamily: 'Montserrat',
              color: Theme.of(context).brightness == Brightness.light? Colors.black:Colors.white,
            ),
            children: <TextSpan>[
              TextSpan(
                  text: 'Madz Amador'+' ',
                  style: new TextStyle(fontWeight: FontWeight.w500)),
              TextSpan(
                text:
                "Approved your PPMP aahhhvacaadooooo long etc etc etc etc etc etc etc etccccccccccccc",
                style: new TextStyle(fontWeight: FontWeight.w300),
              )
            ],
          ),
        ),
      );
    }

    List<Widget> notifs = new List.generate(
        15,
            (i) => new notifwidgets(
          w1: w1,
          notiftexts: notifDetails(),
          date: "Dec 31, 2018",
          conwidth: w2,
        ));

    return Container(
      alignment: Alignment.topLeft,
      child: new SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: Column(
              children: notifs,
            ),
          )),
    );
  }
}