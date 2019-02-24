import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:procura/Components/custom_icons.dart';
import 'package:procura/Screens/Home_Admin/BottomNavBar/ApprovalScreen2.dart';
import 'package:http/http.dart' as http;
import 'package:procura/Screens/Home_Admin/BottomNavBar/ApprovalScreen2_BO.dart';

final formatter = new DateFormat.yMd("en_US");

class HomeApproval_BO extends StatefulWidget {
  final String host;
  final List list;

  const HomeApproval_BO({Key key, this.host, this.list}) : super(key: key);
  @override
  _HomeApproval_BOState createState() => _HomeApproval_BOState();
}

class _HomeApproval_BOState extends State<HomeApproval_BO> {
  TextEditingController searchController = TextEditingController();

  Future<Null> getSectorsForApproval() async {
    final response = await http.post(
        "${widget.host}/getBudgetOfficerForApproval.php",
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
    if (usertype == '3') {
      return getSectorsForApproval();
    } else {
      return getSectorsForApproval();
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.list[0]['user_type_id'] == '3') {
      getSectorsForApproval();
    } else {
      getSectorsForApproval();
    }
  }

  String date(String date) {
    return formatter.format(DateTime.parse(date));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    List splithost = widget.host.split('/');
    String newHost = 'http://${splithost[2]}/Procura/storage/app/public/';
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
                      padding: const EdgeInsets.only(top: 5.0, left: 25.0),
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
                                          new ApprovalScreen2_BO(
                                            listuser: widget.list,
                                            host: widget.host,
                                            title: _searchResult[i].title,
                                            requestType:
                                                _searchResult[i].requestType,
                                            name: _searchResult[i].name,
                                            image: _searchResult[i].user_image,
                                            date: _searchResult[i].datec,
                                            remarks: _searchResult[i].remarks,
                                            sign: widget.list[0]
                                                ['user_signature'],
                                            proposal_file:
                                                _searchResult[i].proposal_file,
                                            proposal_id:
                                                _searchResult[i].proposal_id,
                                            user_id: _searchResult[i].user_id,
                                          ))),
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
                                                _searchResult[i].user_image),
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
                                                  _searchResult[i].name,
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
                                            'from ${_searchResult[i].departmentname}',
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
                                          new ApprovalScreen2_BO(
                                            listuser: widget.list,
                                            host: widget.host,
                                            title: _requestDetails[i].title,
                                            requestType:
                                                _requestDetails[i].requestType,
                                            name: _requestDetails[i].name,
                                            image:
                                                _requestDetails[i].user_image,
                                            date: _requestDetails[i].datec,
                                            remarks: _requestDetails[i].remarks,
                                            sign: widget.list[0]
                                                ['user_signature'],
                                            proposal_file: _requestDetails[i]
                                                .proposal_file,
                                            proposal_id:
                                                _requestDetails[i].proposal_id,
                                            user_id: _requestDetails[i].user_id,
                                          ))),
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
                                            image: new NetworkImage(
                                              newHost +
                                                  _requestDetails[i].user_image,
                                            ),
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
                                                  _requestDetails[i].name,
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
                                            'from ${_requestDetails[i].departmentname}',
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
          requestDetail.name.toLowerCase().contains(text.toLowerCase()) ||
          date(requestDetail.datec.toLowerCase())
              .contains(text.toLowerCase()) ||
          requestDetail.departmentname
              .toLowerCase()
              .contains(text.toLowerCase())) _searchResult.add(requestDetail);
    });
    setState(() {});
  }
}

List<RequestDetails> _searchResult = [];
List<RequestDetails> _requestDetails = [];

class RequestDetails {
  final String title;
  final String name;
  final String departmentname;
  final String datec;
  final String requestType;
  final String is_approved;
  final String remarks;
  final String user_image;
  final String proposal_file;
  final String proposal_id;
  final String user_id;
  RequestDetails(
      {this.title,
      this.name,
      this.departmentname,
      this.datec,
      this.requestType,
      this.is_approved,
      this.remarks,
      this.user_image,
      this.proposal_file,
      this.proposal_id,
      this.user_id});

  factory RequestDetails.fromJson(Map<String, dynamic> json) {
    return new RequestDetails(
      title: json['title'],
      name: json['name'],
      departmentname: json['departmentname'],
      datec: json['datec'],
      requestType: json['requestType'],
      is_approved: json['is_approved'],
      remarks: json['remarks'],
      user_image: json['user_image'],
      proposal_file: json['proposal_file'],
      proposal_id: json['proposal_id'],
      user_id: json['user_id'],
    );
  }
}
