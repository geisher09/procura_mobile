import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

final formatCurrency = new NumberFormat("#,##0.00", "en_US");
final formatter = new DateFormat.yMMMMd("en_US").add_jm();

Timer timer;
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
          child: Container(
            width: width / 1.3,
            child: Text(
              text,
              style: new TextStyle(
                  color: Colors.black,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.fade,
            ),
          ),
        ),
      ],
    ),
    width: width,
  );
}

class HomeDashboard2 extends StatefulWidget {
  final String host;
  final List list;
  HomeDashboard2({this.host, this.list});
  @override
  _HomeDashboard2State createState() => _HomeDashboard2State();
}

class _HomeDashboard2State extends State<HomeDashboard2> {
  Future<List> getRecentUpdates() async {
    final response = await http.post("${widget.host}/getRecentUpdates.php",
        body: {"uid": widget.list[0]['id']});
    final responseJson = json.decode(response.body);
    // print('Recent Updates: $responseJson');
    setState(() {
      _recentUpdates.clear();
      for (Map request in responseJson) {
        _recentUpdates.add(RecentUpdates.fromJson(request));
        //_sectorBudgetAlloc.add(OrdinalSales.fromJson(request));
      }
    });
  }

  Future<List> getSectorBudgetAlloc() async {
    final response = await http.post(
        "${widget.host}/getSectorBudgetAllocated.php",
        body: {"uid": widget.list[0]['id']});
    final responseJson = json.decode(response.body);
    //print('SectorAlloc: $responseJson');
    setState(() {
      _sectorBudgetAlloc.clear();
      for (Map request in responseJson) {
        _sectorBudgetAlloc.add(SectorBudgetAlloc.fromJson(request));
        //_sectorBudgetAlloc.add(OrdinalSales.fromJson(request));
      }
    });
  }

  Future<List> getBOBudgetAlloc() async {
    final response = await http.post(
        "${widget.host}/getBudgetOfficerBudgetAllocated.php",
        body: {"uid": widget.list[0]['id']});
    final responseJson = json.decode(response.body);
    //print('SectorAlloc: $responseJson');
    setState(() {
      _sectorBudgetAlloc.clear();
      for (Map request in responseJson) {
        _sectorBudgetAlloc.add(SectorBudgetAlloc.fromJson(request));
        //_sectorBudgetAlloc.add(OrdinalSales.fromJson(request));
      }
    });
  }

  Future<List> getPurchasesMade() async {
    final response = await http.post("${widget.host}/getPurchasesMade.php",
        body: {"uid": widget.list[0]['id']});
    final responseJson = json.decode(response.body);
    // print('PM: $responseJson');
    setState(() {
      _purchasesMade.clear();
      for (Map request in responseJson) {
        _purchasesMade.add(PurchaseMade.fromJson(request));
        //_sectorBudgetAlloc.add(OrdinalSales.fromJson(request));
      }
    });
  }

  Future<List> getDocumentsMadeApproved() async {
    final response = await http.post(
        "${widget.host}/getDocumentsMadeApproved.php",
        body: {"uid": widget.list[0]['id']});
    final responseJson = json.decode(response.body);
    print('DMA: ${response.body}');
    setState(() {
      _documentsMadeApproved.clear();
      for (Map request in responseJson) {
        _documentsMadeApproved.add(DocumentsMadeApproved.fromJson(request));
        //_sectorBudgetAlloc.add(OrdinalSales.fromJson(request));
      }
    });
  }

  Future<List> getDocumentsApproved() async {
    final response = widget.list[0]['user_type_id'] == '2'
        ? await http.post("${widget.host}/getFilesApprovedBOCount.php",
            body: {"uid": widget.list[0]['id']})
        : await http.post("${widget.host}/getFilesApprovedSectorCount.php",
            body: {"uid": widget.list[0]['id']});
    final responseJson = json.decode(response.body);
    print('DA APP: ${response.body}');
    setState(() {
      _documentsApproved.clear();
      for (Map request in responseJson) {
        _documentsApproved.add(DocumentsApproved.fromJson(request));
        //_sectorBudgetAlloc.add(OrdinalSales.fromJson(request));
      }
    });
  }

  Future<String> getDocs() async {
    final response = await http.post("${widget.host}/getDocumentsMade.php",
        body: {"uid": widget.list[0]['id']});
    //print('DOCS: ${response.body}');
    return (response.body);
  }

  Future<String> getFilesApprovedSector() async {
    final response = await http.post(
        "${widget.host}/getFilesApprovedSector.php",
        body: {"uid": widget.list[0]['id']});
    //print('DOCS: ${response.body}');
    return (response.body);
  }

  Future<String> getFilesApprovedBO() async {
    final response = await http.post("${widget.host}/getFilesApprovedBO.php",
        body: {"uid": widget.list[0]['id']});
    //print('DOCS: ${response.body}');
    return (response.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.list[0]['user_type_id'] == '3') {
      getSectorBudgetAlloc();
      getDocumentsApproved();
    } else if (widget.list[0]['user_type_id'] == '2') {
      getBOBudgetAlloc();
      getDocumentsApproved();
    } else if (widget.list[0]['user_type_id'] == '1') {
      getPurchasesMade();
      getDocumentsMadeApproved();
    }
    getRecentUpdates();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft
    ]);
    var w = MediaQuery.of(context).size.width / 2.19;
    var w1 = MediaQuery.of(context).size.width / 1.1;
    var wchart = MediaQuery.of(context).size.width / 1.06;
    var width = MediaQuery.of(context).size.width;
    double percent = _documentsMadeApproved[0].total > 0 ?
        _documentsMadeApproved[0].td / _documentsMadeApproved[0].total *
            100.0 : 0;
    double percentOverFiles = _documentsMadeApproved[0].total > 0 ? percent / _documentsMadeApproved[0].td : 0;
    int ppmpint = _documentsMadeApproved[0].total > 0 ? (percentOverFiles * _documentsMadeApproved[0].ppmp).round() : 0;
    var ppmp = _documentsMadeApproved[0].total > 0 ? percentOverFiles * _documentsMadeApproved[0].ppmp : 0;
    int pRint = _documentsMadeApproved[0].total > 0 ?(percentOverFiles * _documentsMadeApproved[0].pr).round() : 0;
    var pr = _documentsMadeApproved[0].total > 0 ? percentOverFiles * _documentsMadeApproved[0].pr : 0;
    int bpint = _documentsMadeApproved[0].total > 0 ? (percentOverFiles * _documentsMadeApproved[0].bp).round() : 0;
    var bp = _documentsMadeApproved[0].total > 0 ? percentOverFiles * _documentsMadeApproved[0].bp : 0;
    var pending_rejected = _documentsMadeApproved[0].total > 0 ? 100 - percent : 0;
    var approved_file = _documentsMadeApproved[0].total > 0 ? _documentsMadeApproved[0].td : 0;
    var pen_rej = _documentsMadeApproved[0].total > 0 ? _documentsMadeApproved[0].diff : 0;
    var Piedata = [
      new LinearSales(0, ppmpint, Color(0xFF0b1925)),
      new LinearSales(1, pRint, Color(0xFF19b3b1)),
      new LinearSales(2, bpint, Color(0xFF093b5e)),
    ];
    double percent2 = _documentsApproved[0].total > 0 ?
        (_documentsApproved[0].approved + _documentsApproved[0].rejected) /
            _documentsApproved[0].total *
            100.0 : 0;
    double percentOverFiles2 = _documentsApproved[0].total > 0 ? percent2 /
        (_documentsApproved[0].approved + _documentsApproved[0].rejected) : 0;
    int approvedint = _documentsApproved[0].total > 0 ?
        (percentOverFiles2 * _documentsApproved[0].approved).round() : 0;
    var approved = _documentsApproved[0].total > 0 ? percentOverFiles2 * _documentsApproved[0].approved : 0;
    int rejectedint = _documentsApproved[0].total > 0 ?
        (percentOverFiles2 * _documentsApproved[0].rejected).round() : 0;
    var rejected = _documentsApproved[0].total > 0 ? percentOverFiles2 * _documentsApproved[0].rejected : 0;
    var pending = _documentsApproved[0].total > 0 ? 100 - percent2 : 0;
    var Piedata2 = [
      new LinearSales(0, approvedint, Color(0xFF093637)),
      new LinearSales(1, rejectedint, Color(0xFF6f0000)),
    ];

    var HBardata = [];
    for (int i = 0; i < _sectorBudgetAlloc.length; i++) {
      int total = int.parse(_sectorBudgetAlloc[i].sales.toString());
      // _sectorBudgetAlloc.add(SectorBudgetAlloc('${_sectorBudgetAlloc[i]}', _sectorBudgetAlloc[i].sales));
      HBardata.add(SectorBudgetAlloc(
          '${_sectorBudgetAlloc[i].year}', _sectorBudgetAlloc[i].sales));
    }

    var PointLinedata = [];
    for (int i = 0; i < _purchasesMade.length; i++) {
      int total = int.parse(_purchasesMade[i].tot.toString()).round();
      int num = int.parse(_purchasesMade[i].num.toString());
      //print(total);
      PointLinedata.add(PurchaseMade(i + 1, total));
      //PointLinedata.add(PurchaseMade(1, 1));
    }

    var Pieseries = [
      new charts.Series(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        colorFn: (LinearSales sales, _) => sales.color,
        data: Piedata,
      ),
    ];

    var Pieseries2 = [
      new charts.Series(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        colorFn: (LinearSales sales, _) => sales.color,
        data: Piedata2,
      ),
    ];

    var HBarseries = [
      new charts.Series(
          id: 'Sales',
          domainFn: (SectorBudgetAlloc sales, _) => sales.year,
          measureFn: (SectorBudgetAlloc sales, _) => sales.sales,
          data: _sectorBudgetAlloc,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (SectorBudgetAlloc sales, _) =>
              '${sales.year}: \Php${formatCurrency.format(double.parse(sales.sales.toString()))}')
    ];

    var PointLineseries = [
      new charts.Series(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (PurchaseMade sales, _) => sales.num,
        measureFn: (PurchaseMade sales, _) => sales.tot,
        data: _purchasesMade,
      )
    ];
    double degree = (percent / 100.0) * 360.0;
    double arc_length = (degree * 3.14) / 180;
    var Piechart = new charts.PieChart(
      Pieseries,
      animate: false,
      defaultRenderer: new charts.ArcRendererConfig(arcLength: arc_length),
    );

    double degree2 = (percent2 / 100.0) * 360.0;
    double arc_length2 = (degree2 * 3.14) / 180;
    var Piechart2 = new charts.PieChart(
      Pieseries2,
      animate: false,
      defaultRenderer: new charts.ArcRendererConfig(arcLength: arc_length2),
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

    Widget budgetAllocated() {
      return Column(
        children: <Widget>[
          Text(
            'FILES APPROVED/REJECTED',
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
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black54
                                    : Colors.white,
                            width: 1.0)),
                    height: 100.0,
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
                                  'APPROVED FILES',
                                  style: new TextStyle(fontSize: 14.0),
                                ),
                                Text(
                                  '${_documentsApproved[0].approved}',
                                  style: new TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Lulo'),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'REJECTED FILES',
                                  style: new TextStyle(fontSize: 14.0),
                                ),
                                Text(
                                  '${_documentsApproved[0].rejected}',
                                  style: new TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Lulo'),
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
                      Color(0xFFeef2f3),
                      Color(0xFF8e9eab),
                    ]),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFFeef2f3),
                          offset: Offset.zero,
                          blurRadius: 20.0,
                          spreadRadius: 5.0),
                      BoxShadow(
                          color: Color(0xFF8e9eab),
                          offset: Offset.zero,
                          blurRadius: 15.0,
                          spreadRadius: 4.0),
                      BoxShadow(
                          color: Color(0xFF093637),
                          offset: Offset.zero,
                          blurRadius: 20.0,
                          spreadRadius: 4.0),
                    ],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SizedBox(height: 180, width: 180, child: Piechart2),
            ],
            alignment: AlignmentDirectional.center,
          ),
          Container(
            height: 55.0,
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    legend(Color(0xFF093637),
                        '${approved.toStringAsFixed(2)}% APPROVED', w),
                    legend(Color(0xFF6f0000),
                        '${rejected.toStringAsFixed(2)}% REJECTED', w),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: legend(Color(0xFF8e9eab),
                    '${pending.toStringAsFixed(2)}% PENDING', w),
              )
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 10.0),
            child: Text(
              'DOCUMENTS APPROVED',
              style: new TextStyle(fontSize: 17.0, letterSpacing: 2.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100.0,
              child: FutureBuilder<String>(
                future: widget.list[0]['user_type_id'] == '3'
                    ? getFilesApprovedSector()
                    : getFilesApprovedBO(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print('ERROR: ${snapshot.error}');
                  }
                  if (snapshot.hasData) {
                    if (widget.list[0]['user_type_id'] == '3') {
                      return FilesApprovedSector(
                          list: snapshot.data.split(':'));
                    } else if (widget.list[0]['user_type_id'] == '2') {
                      return FilesApprovedBO(list: snapshot.data.split(':'));
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'BUDGET ALLOCATED',
              style: new TextStyle(fontSize: 17.0, letterSpacing: 2.5),
            ),
          ),
          SizedBox(height: 180, width: wchart, child: HBarchart),
          new Divider(),
        ],
      );
    }

    Widget purchaseMade() {
      return Column(
        children: <Widget>[
          Text(
            'APPROVED FILES',
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
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black54
                                    : Colors.white,
                            width: 1.0)),
                    height: 100.0,
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
                                  'APPROVED FILES',
                                  style: new TextStyle(fontSize: 14.0),
                                ),
                                Text(
                                  '$approved_file',
                                  style: new TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Lulo'),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'PENDING/REJECTED',
                                  style: new TextStyle(fontSize: 14.0),
                                ),
                                Text(
                                  '$pen_rej',
                                  style: new TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Lulo'),
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
                          spreadRadius: 5.0),
                      BoxShadow(
                          color: Color(0xFF093b5e),
                          offset: Offset.zero,
                          blurRadius: 15.0,
                          spreadRadius: 4.0),
                      BoxShadow(
                          color: Color(0xFF0b1925),
                          offset: Offset.zero,
                          blurRadius: 20.0,
                          spreadRadius: 4.0),
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
            height: 55.0,
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    legend(Color(0xFF0b1925),
                        '${ppmp.toStringAsFixed(2)}% PPMP', w),
                    legend(
                        Color(0xFF19b3b1), '${pr.toStringAsFixed(2)}% PR', w),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    legend(
                        Color(0xFF093b5e), '${bp.toStringAsFixed(2)}% BP', w),
                    legend(
                        Color(0xFF767b7b),
                        '${pending_rejected.toStringAsFixed(2)}% Pending/Rejected',
                        w),
                  ],
                ),
              )
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 10.0),
            child: Text(
              'DOCUMENTS MADE',
              style: new TextStyle(fontSize: 17.0, letterSpacing: 2.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100.0,
              child: FutureBuilder<String>(
                future: getDocs(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print('ERROR: ${snapshot.error}');
                  }
                  if (snapshot.hasData) {
                    //print(snapshot.data.split(':')[1][1]);
                    return DocumentsMade(list: snapshot.data.split(':'));
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
            /*child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: h,
                  width: w3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        _docMade[0].ppmp,
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
                  height: h,
                  width: w3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        _docMade[0].pr,
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
                  height: h,
                  width: w3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        _docMade[0].bp,
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
            ),*/
          ),
          new Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'PURCHASES MADE',
                  style: new TextStyle(fontSize: 17.0, letterSpacing: 2.5),
                ),
                Text(
                  '(Recent 10 purchases)',
                  style: new TextStyle(
                      fontSize: 15.0,
                      letterSpacing: 2.5,
                      fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          SizedBox(height: 180, width: wchart, child: PointLinechart),
          new Divider(),
        ],
      );
    }

    Widget bothBAPM() {
      return Column(
        children: <Widget>[
          Divider(),
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
        ],
      );
    }

    String date(String date) {
      return formatter.format(DateTime.parse(date));
    }

    String editdata(String data) {
      var length = data.length;
      length -= 3;
      String text = data.substring(12, length);
      return text;
    }

    var pagechart;
    if (widget.list[0]['user_type_id'] == '2') {
      pagechart = budgetAllocated();
    } else if (widget.list[0]['user_type_id'] == '1') {
      pagechart = purchaseMade();
    } else if (widget.list[0]['user_type_id'] == '3') {
      pagechart = budgetAllocated();
    } else {
      pagechart = Container();
    }
    return ListView.builder(
        itemCount: widget.list == null ? 0 : widget.list.length,
        itemBuilder: (context, i) {
          return SingleChildScrollView(
              child: Container(
            child: new Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Container(
                    width: width / 1.3,
                    child: Center(
                      child: Text(
                        'Hello ${widget.list[0]['name']}!',
                        style:
                            new TextStyle(fontSize: 17.0, letterSpacing: 2.5),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
                pagechart,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'RECENT UPDATES',
                    style: new TextStyle(fontSize: 17.0, letterSpacing: 2.5),
                  ),
                ),
                Container(
                  width: width / 1.05,
                  height: 350.0,
                  child: _recentUpdates.length != 0
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _recentUpdates.length,
                          itemBuilder: (context, i) {
                            return Card(
                              elevation: 2.0,
                              shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Container(
                                decoration: new BoxDecoration(
                                    /*gradient: new LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFF17ead9).withOpacity(0.7),
                                      Color(0xFF6078ea).withOpacity(0.7)
                                    ]),*/
                                    //borderRadius: new BorderRadius.only(topLeft: Radius.zero, topRight: Radius.circular(20.0), bottomLeft: Radius.zero, bottomRight: Radius.circular(20.0) ),
                                    border: Border(
                                  left: BorderSide(
                                      color: Color(0xFF19b3b1),
                                      width: 10.0,
                                      style: BorderStyle.solid),
                                  /*top: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                    style: BorderStyle.solid),*/
                                )),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0),
                                            child: Container(
                                              width: w1 / 1.1,
                                              child: Text(
                                                editdata(
                                                    _recentUpdates[i].data),
                                                overflow: TextOverflow.ellipsis,
                                                style: new TextStyle(
                                                    fontSize: 14.0,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            )),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: Text(
                                            date(_recentUpdates[i].date),
                                            style: new TextStyle(
                                                fontSize: 13.0,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                width: w1 / 2.0,
                                height: 60.0,
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text('You have no notifications yet'),
                        ),
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
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Center(
                    child: Container(
                      child: Text(
                        '© 2019 Procura | Technological University of the Philippines Manila',
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            fontSize: 10.0, fontFamily: 'Montserrat'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
        });
  }
}

class DocumentsMade extends StatelessWidget {
  final List list;
  const DocumentsMade({Key key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var w3 = MediaQuery.of(context).size.width / 3.2;
    var h = 75.0;
    return ListView.builder(
      itemCount: list == null ? 0 : 1,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, i) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: h,
              width: w3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    list[1][1],
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
              height: h,
              width: w3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    list[2][1],
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
              height: h,
              width: w3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    list[3][1],
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
        );
      },
    );
  }
}

class FilesApprovedSector extends StatelessWidget {
  final List list;
  const FilesApprovedSector({Key key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var w3 = MediaQuery.of(context).size.width / 2.2;
    var h = 75.0;
    return ListView.builder(
      itemCount: list == null ? 0 : 1,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, i) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: h,
              width: w3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    list[1][1],
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
              height: h,
              width: w3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    list[2][1],
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
          ],
        );
      },
    );
  }
}

class FilesApprovedBO extends StatelessWidget {
  final List list;
  const FilesApprovedBO({Key key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var w3 = MediaQuery.of(context).size.width / 2.2;
    var h = 75.0;
    return ListView.builder(
      itemCount: list == null ? 0 : 1,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, i) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: h,
              width: w3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    list[1][1],
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
            new Container(
              height: 35.0,
              width: 1.0,
              color: Colors.grey[300],
            ),
            Container(
              height: h,
              width: w3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    list[2][1],
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
          ],
        );
      },
    );
  }
}

List<SectorBudgetAlloc> _sectorBudgetAlloc = [];

class SectorBudgetAlloc {
  final String year;
  final int sales;
  SectorBudgetAlloc(this.year, this.sales);

  factory SectorBudgetAlloc.fromJson(Map<String, dynamic> json) {
    return new SectorBudgetAlloc(
        json['year'], double.parse(json['total']).round());
  }
}

List<PurchaseMade> _purchasesMade = [];

class PurchaseMade {
  final int num;
  final int tot;
  PurchaseMade(this.num, this.tot);

  factory PurchaseMade.fromJson(Map<String, dynamic> json) {
    int i = 0;
    return new PurchaseMade(int.parse(json['id'].toString()),
        double.parse(json['tot'].toString()).round());
  }
}

List<DocumentsMadeApproved> _documentsMadeApproved = [];

class DocumentsMadeApproved {
  final int ppmp;
  final int pr;
  final int bp;
  final int total;
  final int diff;
  final int td;
  DocumentsMadeApproved(
      this.ppmp, this.pr, this.bp, this.total, this.diff, this.td);
  factory DocumentsMadeApproved.fromJson(Map<String, dynamic> json) {
    List i = [];
    return new DocumentsMadeApproved(json['PPMP'], json['PR'], json['BP'],
        json['TOTAL'], json['DIFF'], json['TD']);
  }
}

List<DocumentsApproved> _documentsApproved = [];

class DocumentsApproved {
  final int approved;
  final int rejected;
  final int pending;
  final int total;
  DocumentsApproved(this.approved, this.rejected, this.pending, this.total);
  factory DocumentsApproved.fromJson(Map<String, dynamic> json) {
    return new DocumentsApproved(
        json['APPROVED'], json['REJECTED'], json['PENDING'], json['TOTAL']);
  }
}

List<RecentUpdates> _recentUpdates = [];

class RecentUpdates {
  final String date;
  final String data;
  RecentUpdates({this.date, this.data});

  factory RecentUpdates.fromJson(Map<String, dynamic> json) {
    int i = 0;
    return new RecentUpdates(
      date: json['created_at'],
      data: json['data'],
    );
  }
}
