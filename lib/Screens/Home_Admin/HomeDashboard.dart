import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Components/custom_icons.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class SampleData {
  final String year;
  final int data_no;
  final charts.Color color;

  SampleData(
    this.year,
    this.data_no,
    Color color,
  ) : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class HomeDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = [
      new SampleData("1", 12, Colors.blue),
      new SampleData("2", 75, Colors.blueAccent),
      new SampleData("3", 42, Colors.lightBlue),
      new SampleData("4", 85, Colors.lightBlueAccent),
      new SampleData("5", 65, Colors.blueGrey),
    ];
    final GlobalKey<AnimatedCircularChartState> _chartKey =
        new GlobalKey<AnimatedCircularChartState>();

    final GlobalKey<AnimatedCircularChartState> _chartKey2 =
    new GlobalKey<AnimatedCircularChartState>();

    final GlobalKey<AnimatedCircularChartState> _chartKey3 =
    new GlobalKey<AnimatedCircularChartState>();

    var data2 = [0.0, 1.0, 1.5, 0.5, 1.0, 2.0];
    var data3 = [0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0, 0.5, 1.0, 1.0, 1.5];

    var series = [
      new charts.Series(
        domainFn: (SampleData clickData, _) => clickData.year,
        measureFn: (SampleData clickData, _) => clickData.data_no,
        colorFn: (SampleData clickData, _) => clickData.color,
        id: 'Sample no. of users',
        data: data,
      ),
    ];

    var chart = new charts.BarChart(
      series,
      animate: true,
    );
    var chartWidget = new SizedBox(
      height: 100.0,
      width: 120.0,
      child: chart,
    );
    var sparkWidget1 = new SizedBox(
        height: 40.0,
        width: 50.0,
        child: new Sparkline(
          data: data2,
          lineWidth: 4.0,
          lineGradient: new LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple[800], Theme.of(context).brightness == Brightness.light? Colors.white:Color(0xFF202020)],
          ),
        ));

    var sparkWidget2 = new SizedBox(
        height: 90.0,
        width: MediaQuery.of(context).size.width/1.05,
        child: new Sparkline(
          sharpCorners: false,
          data: data2,
          lineWidth: 2.0,
          lineColor: Colors.red[800],
          pointsMode: PointsMode.all,
          pointSize: 5.0,
          pointColor: Colors.limeAccent,
          fillMode: FillMode.below,
          fillGradient: new LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.red[800], Colors.transparent ],
          ),
        ));

    var radialChart = AnimatedCircularChart(
      holeRadius: 20.0,
      key: _chartKey,
      size: const Size(100.0, 100.0),
      initialChartData: <CircularStackEntry>[
        new CircularStackEntry(
          <CircularSegmentEntry>[
            new CircularSegmentEntry(
              64.0,
              Colors.yellow,
              rankKey: 'completed',
            ),
            new CircularSegmentEntry(
              36.0,
              Colors.blueGrey[600],
              rankKey: 'remaining',
            ),
          ],
        ),
      ],
      chartType: CircularChartType.Radial,
      edgeStyle: SegmentEdgeStyle.round,
      percentageValues: true,
      holeLabel: '64%',
      labelStyle: new TextStyle(
        color: Colors.blueGrey[600],
        fontWeight: FontWeight.bold,
        fontSize: 14.0,
      ),
    );

    var radialChart2 = AnimatedCircularChart(
      holeRadius: 20.0,
      key: _chartKey2,
      size: const Size(100.0, 100.0),
      initialChartData: <CircularStackEntry>[
        new CircularStackEntry(
          <CircularSegmentEntry>[
            new CircularSegmentEntry(
              90.0,
              Colors.green,
              rankKey: 'completed',
            ),
            new CircularSegmentEntry(
              10.0,
              Colors.blueGrey[600],
              rankKey: 'remaining',
            ),
          ],
          rankKey: 'progress',
        ),
      ],
      chartType: CircularChartType.Radial,
      edgeStyle: SegmentEdgeStyle.round,
      percentageValues: true,
      holeLabel: '90%',
      labelStyle: new TextStyle(
        color: Colors.blueGrey[600],
        fontWeight: FontWeight.bold,
        fontSize: 14.0,
      ),
    );

    var radialChart3 = AnimatedCircularChart(
      holeRadius: 20.0,
      key: _chartKey3,
      size: const Size(100.0, 100.0),
      initialChartData: <CircularStackEntry>[
        new CircularStackEntry(
          <CircularSegmentEntry>[
            new CircularSegmentEntry(
              19.0,
              Colors.red,
              rankKey: 'completed',
            ),
            new CircularSegmentEntry(
              81.0,
              Colors.blueGrey[600],
              rankKey: 'remaining',
            ),
          ],
          rankKey: 'progress',
        ),
      ],
      chartType: CircularChartType.Radial,
      edgeStyle: SegmentEdgeStyle.round,
      percentageValues: true,
      holeLabel: '19%',
      labelStyle: new TextStyle(
        color: Colors.blueGrey[600],
        fontWeight: FontWeight.bold,
        fontSize: 14.0,
      ),
    );

    var now = new DateTime.now();
    var formatter = new DateFormat('EEEE, LLL d y');
    String formatted = formatter.format(now);

    return SingleChildScrollView(
      child: new Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 15.0),
                  child: new Text(
                    'Geisher Bernabe',
                    style: new TextStyle(fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat'
                    ),
                  ),
                ),
                new Text(
                  formatted,
                  style: new TextStyle(fontSize: 10.0),
                )
              ],
            ),
            Container(
              height: 20.0,
            ),
            chartWidget,
            Container(
              width: MediaQuery.of(context).size.width/1.05,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  sparkWidget2,
                  Container(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text(
                        'JAN',
                        style: new TextStyle(fontSize: 12.0),
                      ),
                      new Text(
                        'FEB',
                        style: new TextStyle(fontSize: 12.0),
                      ),
                      new Text(
                        'MAR',
                        style: new TextStyle(fontSize: 12.0),
                      ),
                      new Text(
                        'APR',
                        style: new TextStyle(fontSize: 12.0),
                      ),
                      new Text(
                        'MAY',
                        style: new TextStyle(fontSize: 12.0),
                      ),
                      new Text(
                        'JUN',
                        style: new TextStyle(fontSize: 12.0),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 10.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              padding: EdgeInsets.only(left: 10.0),
              height: 80,
              child: ListView(
//                mainAxisSize: MainAxisSize.min,
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(12.0),
                        color: Colors.black38),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(CustomIcons.uniE836),
                          Text(
                            'Budget Year',
                            style: new TextStyle(fontSize: 10.0),
                          ),
                          Text(
                            '2019',
                            style: new TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold,fontFamily: 'Lulo',letterSpacing: 1.0  ),
                          ),
                        ],
                      ),
                    ),
                    width: MediaQuery.of(context).size.width/2.9,
                  ),
                  Container(
                    width: 10.0,
                  ),
                  Container(
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(12.0),
                        color: Colors.black38),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(CustomIcons.wallet_43),
                          Text(
                            'Total Budget',
                            style: new TextStyle(fontSize: 10.0),
                          ),
                          Text(
                            'P10.9M',
                            style: new TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                          ),
                        ],
                      ),
                    ),
                    width: MediaQuery.of(context).size.width/2.9,
                  ),
                  Container(
                    width: 10.0,
                  ),
                  Container(
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(12.0),
                        color: Colors.black38),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(CustomIcons.uniE82E),
                          Text(
                            'Budget Left',
                            style: new TextStyle(fontSize: 10.0),
                          ),
                          Text(
                            'P500k',
                            style: new TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                          ),
                        ],
                      ),
                    ),
                    width: MediaQuery.of(context).size.width/2.9,
                  ),
                  Container(
                    width: 10.0,
                  ),
                  Container(
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(12.0),
                        color: Colors.black38),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(FontAwesomeIcons.chartBar),
                          Text(
                            'Something',
                            style: new TextStyle(fontSize: 10.0),
                          ),
                          Text(
                            'IDK',
                            style: new TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),
                          ),
                        ],
                      ),
                    ),
                    width: MediaQuery.of(context).size.width/2.9,
                  ),
                ],
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: new Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Lorem ipsum dolor',
                      style: new TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w900),
                    ),
                    Container(
                      height: 15.0,
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet, pro id homero atomorum persequeris, vidit consulatu mel ea. An ius quando blandit voluptaria, ius ei oratio nemore. Sit decore apeirian constituto at, freeeeeshavacadoo.',
                      style: new TextStyle(
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 10.0,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: new Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Lorem ipsum dolor',
                      style: new TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w900),
                    ),
                    Container(
                      height: 5.0,
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet, pro id homero atomorum persequeris, vidit consulatu mel ea. An ius quando blandit voluptaria, ius ei oratio nemore. Sit decore apeirian constituto at, freeeeeshavacadoo. Et vitae gubergren est, omnesque pertinax consequat et sea, ius quem lucilius assentior ne. Omnium petentium sed ad, eum melius impetus regione ea. No aperiri assueverit deterruisset pri.',
                      style: new TextStyle(
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
//            Row(
//              mainAxisSize: MainAxisSize.max,
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                Column(
//                  children: <Widget>[
//                    sparkWidget1,
//                    SizedBox(
//                        height: 40.0,
//                        child: new Text(
//                          'JANUARY',
//                        )),
//                  ],
//                ),
//                Column(
//                  children: <Widget>[
//                    sparkWidget2,
//                    SizedBox(
//                        height: 40.0,
//                        child: new Text(
//                          'FEBRUARY',
//                        )),
//                  ],
//                ),
//                chartWidget
//              ],
//            ),
          ],
        ),
      ),
    );
  }
}
