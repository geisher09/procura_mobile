import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:procura/Components/custom_icons.dart';
import 'package:procura/Screens/Home_Admin/BottomNavBar/RequestScreen2.dart';
import 'package:http/http.dart' as http;

final formatter = new DateFormat.yMd("en_US");

class HomeRequests extends StatefulWidget {
  final String host;
  final List list;

  const HomeRequests({Key key, this.host, this.list}) : super(key: key);
  @override
  _HomeRequestsState createState() => _HomeRequestsState();
}

class _HomeRequestsState extends State<HomeRequests> {
  TextEditingController searchController = TextEditingController();

  Future<Null> getMyRequests_Dept() async {
    final response = await http.post("${widget.host}/getMyRequests_Dept.php",
        body: {"uid": widget.list[0]['id']});
    final responseJson = json.decode(response.body);

    setState(() {
      _requestDetails.clear();
      for (Map request in responseJson) {
        _requestDetails.add(RequestDetails.fromJson(request));
      }
    });
  }

  Future future(String usertype) {
    if (usertype == '1') {
      return getMyRequests_Dept();
    } else {
      return getMyRequests_Dept();
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.list[0]['user_type_id'] == '1') {
      getMyRequests_Dept();
    } else {
      getMyRequests_Dept();
    }
  }

  String date(String date) {
    return formatter.format(DateTime.parse(date));
  }

  @override
  Widget build(BuildContext context) {
    List splithost = widget.host.split('/');
    String newHost = 'http://${splithost[2]}/Procura/storage/app/public/';
    var width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Container(
//            decoration: new BoxDecoration(
//              borderRadius: BorderRadius.circular(20.0),
//              border: new Border.all(
//                color: Colors.grey,
//                width: 1.0,
//              ),
//            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
              child: Card(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(25.0)),
                child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Icon(
                        CustomIcons.uniE86F,
                        size: 16.0,
                      ),
                    ),
                    title: new TextField(
                      controller: searchController,
                      style: TextStyle(fontSize: 13.0, height: 1.5),
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search",
                          hintStyle: const TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w500),
                          contentPadding: EdgeInsets.all(0.0)),
                      onChanged: onSearchTextChanged,
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(top: 5.0,left: 25.0),
                      child: IconButton(
                        icon: Icon(
                          CustomIcons.uniE870,
                          size: 16.0,
                        ),
                        onPressed: () {
                          searchController.clear();
                          onSearchTextChanged('');
                        },
                      ),
                    )),
              ),
            ),
          ),
//          Padding(
//              padding: const EdgeInsets.all(10.0),
//              child: Container(
//                  decoration: new BoxDecoration(
//                    borderRadius: BorderRadius.circular(20.0),
//                    border: new Border.all(
//                      color: Colors.grey,
//                      width: 1.0,
//                    ),
//                  ),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    children: <Widget>[
//                      Padding(
//                        padding: const EdgeInsets.fromLTRB(15.0, 4.0, 0.0, 0.0),
//                        child: IconButton(
//                          icon: _searchIcon,
//                          onPressed: _searchPressed,
//                        ),
//                      ),
//                      Padding(
//                          padding:
//                              const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                          child: _searchTitle),
//                    ],
//                  )
//                  )),
//          Expanded(
//            child: FutureBuilder<List>(
//                future: future(widget.list[0]['user_type_id']),
//                builder: (context, snapshot) {
//                  if (snapshot.hasError) {
//                    print(snapshot.error);
//                  }
//                  if (snapshot.hasData) {
//                    if (snapshot.data.length == 0) {
//                      return Center(child: Text('No Data Available'));
//                    } else {
//                      return new MyRequests(
//                          host: widget.host,
//                          list: snapshot.data,
//                          image: widget.list[0]['user_image']);
//                    }
//                  } else {
//                    return Center(child: CircularProgressIndicator());
//                  }
//                }),
//          )
          _requestDetails.length != 0
              ? Expanded(
                  child: _searchResult.length != 0 ||
                          searchController.text.isNotEmpty
                      ? new ListView.builder(
                          itemCount: _searchResult.length,
                          itemBuilder: (context, i) {
                            return InkWell(
                              onTap: () => Navigator.of(context).push(
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new RequestScreen2(
                                              host: widget.host,
                                              title: _searchResult[i].title,
                                              requestType:
                                                  _searchResult[i].requestType,
                                              image: widget.list[0]
                                                  ['user_image'],
                                              approver:
                                                  _searchResult[i].approver,
                                              date: _searchResult[i].datec,
                                              status:
                                                  _searchResult[i].is_approved,
                                              remarks:
                                                  _searchResult[i].remarks))),
                              child: Container(
                                decoration: new BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 0.5,
                                      style: BorderStyle.solid),
                                )),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10.0, 5.0, 5.0, 5.0),
                                      child: Container(
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                            image: new NetworkImage(newHost +
                                                widget.list[0]['user_image']),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        width: 35.0,
                                        height: 35.0,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Container(
                                          height: 15.0,
                                          width: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.portrait
                                              ? width / 1.25
                                              : width / 1.15,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12.0),
                                                child: Text(
                                                  'Me',
                                                  style: new TextStyle(
                                                      fontSize: 13.5,
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Text(
                                                date(_searchResult[i].datec),
                                                style: new TextStyle(
                                                    fontSize: 10,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme.of(context)
                                                                .brightness ==
                                                            Brightness.light
                                                        ? Colors.blue
                                                        : Colors.blue[400]),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.portrait
                                                  ? width / 1.3
                                                  : width / 1.2,
                                              child: Text(
                                                _searchResult[i].title,
                                                style: new TextStyle(
                                                    fontSize: 12.5,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight:
                                                        FontWeight.w500),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: Text(
                                            'to ${_searchResult[i].approver}',
                                            style:
                                                new TextStyle(fontSize: 12.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                width: width,
                                height: 70.0,
                              ),
                            );
                          })
                      : ListView.builder(
                          itemCount: _requestDetails.length,
                          itemBuilder: (context, i) {
                            return InkWell(
                              onTap: () => Navigator.of(context).push(
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new RequestScreen2(
                                              host: widget.host,
                                              title: _requestDetails[i].title,
                                              requestType: _requestDetails[i]
                                                  .requestType,
                                              image: widget.list[0]
                                                  ['user_image'],
                                              approver:
                                                  _requestDetails[i].approver,
                                              date: _requestDetails[i].datec,
                                              status: _requestDetails[i]
                                                  .is_approved,
                                              remarks:
                                                  _requestDetails[i].remarks))),
                              child: Container(
                                decoration: new BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 0.5,
                                      style: BorderStyle.solid),
                                )),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10.0, 5.0, 5.0, 5.0),
                                      child: Container(
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                            image: new NetworkImage(newHost +
                                                widget.list[0]['user_image']),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        width: 35.0,
                                        height: 35.0,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Container(
                                          height: 15.0,
                                          width: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.portrait
                                              ? width / 1.25
                                              : width / 1.15,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12.0),
                                                child: Text(
                                                  'Me',
                                                  style: new TextStyle(
                                                      fontSize: 13.5,
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Text(
                                                date(_requestDetails[i].datec),
                                                style: new TextStyle(
                                                    fontSize: 10,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme.of(context)
                                                                .brightness ==
                                                            Brightness.light
                                                        ? Colors.blue
                                                        : Colors.blue[400]),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                          .orientation ==
                                                      Orientation.portrait
                                                  ? width / 1.3
                                                  : width / 1.2,
                                              child: Text(
                                                _requestDetails[i].title,
                                                style: new TextStyle(
                                                    fontSize: 12.5,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight:
                                                        FontWeight.w500),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: Text(
                                            'to ${_requestDetails[i].approver}',
                                            style:
                                                new TextStyle(fontSize: 12.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                width: width,
                                height: 70.0,
                              ),
                            );
                          }))
              : Expanded(
                  child: Center(
                    child: Text('You have no requests yet'),
                  ),
                )
        ],
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _requestDetails.forEach((requestDetail) {
      String date(String date) {
        return formatter.format(DateTime.parse(date));
      }

      if (requestDetail.title.toLowerCase().contains(text.toLowerCase()) ||
          requestDetail.approver.toLowerCase().contains(text.toLowerCase()) ||
          date(requestDetail.datec.toLowerCase()).contains(text.toLowerCase()))
        _searchResult.add(requestDetail);
    });
    setState(() {});
  }
}

List<RequestDetails> _searchResult = [];
List<RequestDetails> _requestDetails = [];

class RequestDetails {
  final String title;
  final String approver;
  final String datec;
  final String requestType;
  final String is_approved;
  final String remarks;
  RequestDetails(
      {this.title,
      this.approver,
      this.datec,
      this.requestType,
      this.is_approved,
      this.remarks});

  factory RequestDetails.fromJson(Map<String, dynamic> json) {
    return new RequestDetails(
        title: json['title'],
        approver: json['approver'],
        datec: json['datec'],
        requestType: json['requestType'],
        is_approved: json['is_approved'],
        remarks: json['remarks']);
  }
}

//class MyRequests extends StatelessWidget {
//  final String host;
//  final List list;
//  final String image;
//  MyRequests({this.host, this.list, this.image});
//  @override
//  String date(String date) {
//    return formatter.format(DateTime.parse(date));
//  }
//
//  Widget build(BuildContext context) {
//    return ListView.builder(
//        itemCount: list == null ? 0 : list.length,
//        itemBuilder: (context, i) {
//          return InkWell(
////              onTap: () {
////                Navigator.push(
////                  context,
////                  MaterialPageRoute(builder: (context) => RequestScreen2(text1,text2,text3,date,time)),
////                );
////              },
//            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
//                builder: (BuildContext context) => new RequestScreen2(
//                    host: host,
//                    title: list[i]['title'],
//                    requestType: list[i]['requestType'],
//                    image: image,
//                    approver: list[i]['approver'],
//                    date: list[i]['datec'],
//                    status: list[i]['is_approved']))),
//            child: Container(
//              decoration: new BoxDecoration(
//                  border: Border(
//                bottom: BorderSide(
//                    color: Colors.grey, width: 0.5, style: BorderStyle.solid),
//              )),
//              child: Row(
//                children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
//                    child: Container(
//                      decoration: new BoxDecoration(
//                        shape: BoxShape.circle,
//                        image: new DecorationImage(
//                          image: new NetworkImage(host + image),
//                          fit: BoxFit.cover,
//                        ),
//                      ),
//                      width: 35.0,
//                      height: 35.0,
//                    ),
//                  ),
////          Padding(
////            padding: const EdgeInsets.only(left: 5.0),
////            child: new Container(
////              height: 20.0,
////              width: 1.0,
////              color: Colors.grey.withOpacity(0.5),
////            ),
////          ),
//                  Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    mainAxisSize: MainAxisSize.max,
//                    children: <Widget>[
//                      Container(
//                        height: 15.0,
//                        width: MediaQuery.of(context).orientation ==
//                                Orientation.portrait
//                            ? width / 1.25
//                            : width / 1.15,
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: <Widget>[
//                            Padding(
//                              padding: const EdgeInsets.only(left: 12.0),
//                              child: Text(
//                                'Me',
//                                style: new TextStyle(
//                                    fontSize: 13.5,
//                                    fontFamily: 'Montserrat',
//                                    fontWeight: FontWeight.w500),
//                              ),
//                            ),
//                            Text(
//                              date(list[i]['datec']),
//                              style: new TextStyle(
//                                  fontSize: 10,
//                                  fontFamily: 'Montserrat',
//                                  fontWeight: FontWeight.w600,
//                                  color: Theme.of(context).brightness ==
//                                          Brightness.light
//                                      ? Colors.blue
//                                      : Colors.blue[400]),
//                            ),
//                          ],
//                        ),
//                      ),
//                      Padding(
//                          padding: const EdgeInsets.only(left: 12.0),
//                          child: Container(
//                            width: MediaQuery.of(context).orientation ==
//                                    Orientation.portrait
//                                ? width / 1.3
//                                : width / 1.2,
//                            child: Text(
//                              list[i]['title'],
//                              style: new TextStyle(
//                                  fontSize: 12.5,
//                                  fontFamily: 'Montserrat',
//                                  fontWeight: FontWeight.w500),
//                              overflow: TextOverflow.ellipsis,
//                            ),
//                          )),
//                      Padding(
//                        padding: const EdgeInsets.only(left: 12.0),
//                        child: Text(
//                          'to ${list[i]['approver']}',
//                          style: new TextStyle(fontSize: 12.0),
//                        ),
//                      ),
//                    ],
//                  ),
//                ],
//              ),
//              width: width,
//              height: 70.0,
//            ),
//          );
//        });
//  }
//}
