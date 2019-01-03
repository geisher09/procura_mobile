import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class updatewidgets extends StatelessWidget {
  final text1;
  final text2;
  final text3;
  final w1;

  const updatewidgets({Key key, this.text1, this.text2, this.text3, this.w1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          border: Border(
        top: BorderSide(
            color: Colors.grey, width: 1.0, style: BorderStyle.solid),
      )),
      child: Row(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFF0b1925), Color(0xFF17354f)]),
            ),
            width: 7.0,
            height: 70.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          text1,
                          style: new TextStyle(
                            fontSize: 12.5,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        text2,
                        style: new TextStyle(
                            fontSize: 13.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600),
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
                      style: new TextStyle(
                          fontSize: 13.0, fontStyle: FontStyle.italic),
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
    );
  }
}

class LinearSales {
  final int year;
  final int sales;
  final charts.Color color;

  LinearSales(this.year, this.sales, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

class OrdinalSales2 {
  final int year;
  final int sales;

  OrdinalSales2(this.year, this.sales);
}

Widget legend(color, text, width) {
  return new Container(
    decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(7.0), color: Color(0xFFa1dcd8)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          color: color,
          width: 30.0,
          height: 30.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: Text(
            text,
            style: new TextStyle(
                color: Colors.black,
                fontSize: 12.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
    width: width,
  );
}

Widget recentUpdate(w1, text1, text2, text3) {
  return new Container(
    decoration: new BoxDecoration(
        border: Border(
      left: BorderSide(
          color: Color(0xFF19b3b1), width: 7.0, style: BorderStyle.solid),
      top: BorderSide(color: Colors.grey, width: 1.0, style: BorderStyle.solid),
    )
//      gradient: new LinearGradient(
//          begin: Alignment.topLeft,
//          end: Alignment.bottomRight,
//          colors: [
//          Color(0xFF0b1925),
//          Color(0xFF2f6a9d)
//          ]),
        //borderRadius: new BorderRadius.only(topLeft: Radius.zero, topRight: Radius.circular(20.0), bottomLeft: Radius.zero, bottomRight: Radius.circular(20.0) ),
        ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                text1,
                style: new TextStyle(
                  fontSize: 12.5,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  text2,
                  style: new TextStyle(
                      fontSize: 13.0,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600),
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
                style:
                    new TextStyle(fontSize: 13.0, fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ],
    ),
    width: w1,
    height: 70.0,
  );
}

class HomeDashboard2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width / 2.19;
    var w1 = MediaQuery.of(context).size.width / 1.1;
    var wchart = MediaQuery.of(context).size.width / 1.06;
    var w3 = MediaQuery.of(context).size.width / 3.2;

    List<Widget> updates = new List.generate(
        5,
        (i) => new updatewidgets(
              w1: w1,
              text1: "Your PPMP 'Sample Title(max 35 chars)'",
              text2: "Has been approved!",
              text3: "December 25, 2018 | 12:30pm",
            ));

    var Piedata = [
      new LinearSales(0, 35, Color(0xFF0b1925)),
      new LinearSales(1, 25, Color(0xFF19b3b1)),
      new LinearSales(2, 15, Color(0xFF093b5e)),
    ];

    var HBardata = [
      new OrdinalSales('2019', 500),
      new OrdinalSales('2018', 750),
      new OrdinalSales('2017', 600),
      new OrdinalSales('2016', 900),
    ];

    var PointLinedata = [
      new OrdinalSales2(0, 35000),
      new OrdinalSales2(1, 20000),
      new OrdinalSales2(2, 56000),
      new OrdinalSales2(3, 48000),
    ];

    var Pieseries = [
      new charts.Series(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        colorFn: (LinearSales sales, _) => sales.color,
        data: Piedata,
      ),
    ];

    var HBarseries = [
      new charts.Series(
          id: 'Sales',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: HBardata,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (OrdinalSales sales, _) =>
              '${sales.year}: \Php${sales.sales.toString()}k')
    ];

    var PointLineseries = [
      new charts.Series(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales2 sales, _) => sales.year,
        measureFn: (OrdinalSales2 sales, _) => sales.sales,
        data: PointLinedata,
      )
    ];

    var Piechart = new charts.PieChart(
      Pieseries,
      animate: false,
      defaultRenderer: new charts.ArcRendererConfig(arcLength: 3 / 2 * 3.14),
    );

    var HBarchart = new charts.BarChart(
      HBarseries,
      animate: false,
      vertical: false,
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      domainAxis:
          new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec()),
    );

    var PointLinechart = new charts.LineChart(PointLineseries,
        animate: false,
        defaultRenderer: new charts.LineRendererConfig(includePoints: true));

    return SingleChildScrollView(
        child: Container(
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
//          Padding(
//            padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 10.0),
//            child: Container(
//              height: 100.0,
//              width: double.infinity,
//              decoration: new BoxDecoration(
//                image: new DecorationImage(
//                  image: new AssetImage(
//                      "assets/images/wave.png"),
//                  fit: BoxFit.cover,
//                ),
//              ),
//            ),
//          ),
          Text(
            'BUDGET USED',
            style: new TextStyle(fontSize: 17.0, letterSpacing: 2.5),
          ),
          Stack(
            children: <Widget>[
              FractionalTranslation(
                translation: Offset(0.0, 0.9),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black54,
                            width: 1.0
                        )
                    ),
                    height: 90.0,
                    width: w1,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 40.0,
                        ),
                        new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'SPENT BUDGET',
                                  style: new TextStyle(fontSize: 12.0),
                                ),
                                Text(
                                  'Php 765,000',
                                  style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'UNUSED BUDGET',
                                  style: new TextStyle(fontSize: 12.0),
                                ),
                                Text(
                                  'Php 255,000',
                                  style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: new Container(
                  width: 130.0,
                  height: 130.0,
                  decoration: new BoxDecoration(
                    gradient: new RadialGradient(colors: [
                      Color(0xFFb6babf),
                      Color(0xFF767b7b),
                    ]),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF19b3b1),
                        offset: Offset.zero,
                        blurRadius: 20.0,
                        spreadRadius: 5.0
                      ),
                      BoxShadow(
                          color: Color(0xFF093b5e),
                          offset: Offset.zero,
                          blurRadius: 15.0,
                          spreadRadius: 4.0
                      ),
                      BoxShadow(
                          color: Color(0xFF0b1925),
                          offset: Offset.zero,
                          blurRadius: 20.0,
                          spreadRadius: 4.0
                      ),
                    ],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SizedBox(height: 180, width: 180, child: Piechart),
            ],
            alignment: AlignmentDirectional.center,
          ),
          Container(
            height: 40.0,
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    legend(Color(0xFF0b1925), '35% Consultancy', w),
                    legend(Color(0xFF19b3b1), '25% Infastracture', w),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    legend(Color(0xFF093b5e), '15% Goods & Services', w),
                    legend(Color(0xFF767b7b), '25% Unused', w),
                  ],
                ),
              )
            ],
          ),
          new Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 10.0),
            child: Text(
              'DOCUMENTS MADE',
              style: new TextStyle(fontSize: 17.0, letterSpacing: 2.5),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 65.0,
                width: w3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '15',
                      style: new TextStyle(
                          fontSize: 40.0,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'PPMP',
                      style: new TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                height: 35.0,
                width: 1.0,
                color: Colors.grey[300],
              ),
              Container(
                height: 65.0,
                width: w3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '5',
                      style: new TextStyle(
                          fontSize: 40.0,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'PR',
                      style: new TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                height: 35.0,
                width: 1.0,
                color: Colors.grey[300],
              ),
              Container(
                height: 65.0,
                width: w3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '8',
                      style: new TextStyle(
                          fontSize: 40.0,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'BP',
                      style: new TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          new Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'BUDGET ALLOCATED',
              style: new TextStyle(fontSize: 17.0, letterSpacing: 2.5),
            ),
          ),
          SizedBox(height: 180, width: wchart, child: HBarchart),
          new Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 10.0),
            child: Text(
              'PURCHASES MADE',
              style: new TextStyle(fontSize: 17.0, letterSpacing: 2.5),
            ),
          ),
          SizedBox(height: 180, width: wchart, child: PointLinechart),
          new Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'RECENT UPDATES',
              style: new TextStyle(fontSize: 17.0, letterSpacing: 2.5),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: updates,
          ),
//          new Container(
//            height: 350.0,
//              width: w1,
//              child: new ListView(
//                children: updates,
//              )
//
//          ),
//          Column(
//            crossAxisAlignment: CrossAxisAlignment.stretch,
//            children: <Widget>[
//              recentUpdate(
//                  w1,
//                  "Your PPMP 'Sample Title na medj mahabahaba'",
//                  'Has been Approved!',
//                  'Dec. 30,2018 | 12:30pm'),
//              recentUpdate(
//                  w1,
//                  "Your PPMP 'Title Limit this sht to 35 chars only'",
//                  'Has been Rejected!',
//                  'Dec. 30,2018 | 10:19am'),
//              recentUpdate(
//                w1,
//                "Budget Proposal sent to",
//                'Fresh Lumpia',
//                'Dec. 28,2018 | 11:24am',
//              ),
//              recentUpdate(
//                w1,
//                "Your PPMP 'Sample Title3 na medj mahabahaba'",
//                'Has been Approved!',
//                'Dec. 25,2018 | 4:20pm',
//              ),
//              recentUpdate(
//                w1,
//                "A Budget Proposal was sent to you by",
//                'Obri and Boyet',
//                'Dec. 25,2018 | 7:20am',
//              ),
//            ],
//          ),
          new Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Center(
              child: Text(
                '© 2018 Procura | Technological Univeristy of the Philippines Manila',
                style: new TextStyle(fontSize: 10.0, fontFamily: 'Montserrat'),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
