import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:procura/Components/custom_icons.dart';
import 'package:procura/Screens/Home_Admin/BottomNavBar/RequestScreen2.dart';
import 'package:http/http.dart' as http;
import 'package:procura/Screens/Home_Admin/Drawer/BudgetAllocationSector.dart';
import 'package:procura/Screens/Home_Admin/Drawer/BudgetProposalScreen.dart';
import 'package:procura/Screens/Home_Admin/Drawer/DeptPPMPScreen.dart';
import 'package:procura/Screens/Home_Admin/Drawer/DeptPRScreen.dart';
import 'package:procura/Screens/Home_Admin/Drawer/PurchaseRequestScreen.dart';
import 'package:procura/Screens/Home_Admin/Drawer/SectorPPMPScreen.dart';

final formatter = new DateFormat.yMMMMd("en_US");
Timer timer;
class HomeNotifications extends StatefulWidget {
  final String host;
  final List list;

  const HomeNotifications({Key key, this.host, this.list}) : super(key: key);
  @override
  _HomeNotificationsState createState() => _HomeNotificationsState();
}

class _HomeNotificationsState extends State<HomeNotifications> {
  TextEditingController searchController = TextEditingController();

  Future<Null> getNotifications() async {
    final response = await http.post("${widget.host}/getNotifications.php",
        body: {"id": '1', "uid": widget.list[0]['id']});
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
      return getNotifications();
    } else {
      return getNotifications();
    }
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => getNotifications());
  }

  String date(String date) {
    return formatter.format(DateTime.parse(date));
  }
  String editdata(String data){
    var length = data.length;
    length -= 3;
    String text = data.substring(12,length);
    return text;
  }
  AssetImage imagenotif(String type){
    //var newstring = jsonDecode('"${type.replaceAll(r"\\", r"")}"');
    if(type == r'App\Notifications\BudgetYearActivated'){
      return AssetImage("assets/images/budgetyearactivated.png");
    }else if(type == r'App\Notifications\ProjectApproved'){
      return AssetImage("assets/images/ppmpapproved.png");
    }else if(type == r'App\Notifications\ProjectRejected'){
      return AssetImage("assets/images/ppmprejected.png");
    }else if(type == r'App\Notifications\PurchaseRequestApproved'){
      return AssetImage("assets/images/prapproved.png");
    }else if(type == r'App\Notifications\PurchaseRequestRejected'){
      return AssetImage("assets/images/prrejected.png");
    }else if(type == r'App\Notifications\BudgetProposalApproved'){
      return AssetImage("assets/images/bpapproved.png");
    }else if(type == r'App\Notifications\BudgetProposalRejected'){
      return AssetImage("assets/images/bprejected.png");
    }else if(type == r'App\Notifications\ProjectSubmitted'){
      return AssetImage("assets/images/ppmpsent.png");
    }else if(type == r'App\Notifications\BudgetProposalSubmitted'){
      return AssetImage("assets/images/bpsent.png");
    }else if(type == r'App\Notifications\PurchaseRequestSubmitted'){
      return AssetImage("assets/images/prsent.png");
    }else if(type == r'App\Notifications\DepartmentBudgetAllocated'){
      return AssetImage("assets/images/departmentallocated.png");
    }else if(type == r'App\Notifications\SectorBudgetAllocated'){
      return AssetImage("assets/images/sectorallocated.png");
    }else{
      return AssetImage("assets/icons/pLogo.png");
    }
  }
  void readNotif(String id) {
    var url = "${widget.host}/readNotif.php";
    http.post(url, body: {
      "id": id,
    });
  }
  Widget nextpage(String type, String id){
    if(type == r'App\Notifications\BudgetProposalSubmitted'){
      readNotif(id);
      return BudgetProposalScreen(
          bp: 'budgetofficer',
          host: widget.host,
          id: widget.list[0]['id']);
    }else if(type == r'App\Notifications\BudgetYearActivated'){
      readNotif(id);
      if(widget.list[0]['user_type_id'] == '1'){
        /*return BudgetProposalScreen(
            bp: 'depthead',
            host: widget.host,
            id: widget.list[0]['id']);*/
        return Scaffold(
          body: Center(
            child: Text('A new active budget year has been set!', textAlign: TextAlign.center),
          ),
        );
      }else if(widget.list[0]['user_type_id'] == '3'){
        return BudgetAllocationSector(
            host: widget.host,uid: widget.list[0]['id']);
      }else if(widget.list[0]['user_type_id'] == '5'){
          return Scaffold(
            body: Center(
              child: Text('A new active budget year has been set!', textAlign: TextAlign.center),
            ),
          );
      }
    }else if(type == r'App\Notifications\SectorBudgetAllocated'){
      readNotif(id);
      return BudgetAllocationSector(
          host: widget.host,uid: widget.list[0]['id']);
    }else if(type == r'App\Notifications\DepartmentBudgetAllocated'){
      readNotif(id);
      /*return BudgetProposalScreen(
          bp: 'depthead',
          host: widget.host,
          id: widget.list[0]['id']);*/
      return Scaffold(
        body: Center(
          child: Text("Your department's budget for the active year has now been allocated", textAlign: TextAlign.center),
        ),
      );
    }else if(type == r'App\Notifications\ProjectSubmitted'){
      readNotif(id);
      return SectorPPMPScreen(
          host: widget.host, listuser:widget.list, id: widget.list[0]['id']);
    }else if(type == r'App\Notifications\PurchaseRequestSubmitted'){
      readNotif(id);
      return PurchaseRequestScreen(host: widget.host, listuser:widget.list);
    }else if((type == r'App\Notifications\ProjectApproved') || (type == r'App\Notifications\ProjectRejected')){
      readNotif(id);
      return DeptPPMPScreen(
          host: widget.host, listuser:widget.list, id: widget.list[0]['id']);
    }else if((type == r'App\Notifications\PurchaseRequestApproved') || (type == r'App\Notifications\PurchaseRequestRejected')){
      readNotif(id);
      return DeptPRScreen(
          host: widget.host, id: widget.list[0]['id']);
    }else if((type == r'App\Notifications\BudgetProposalApproved') || (type == r'App\Notifications\BudgetProposalRejected')){
      readNotif(id);
      return BudgetProposalScreen(
          bp: 'depthead',
          host: widget.host,
          id: widget.list[0]['id']);
    }else if(type == r'App\Notifications\DepartmentBudgetAllocated'){
      readNotif(id);
      return BudgetProposalScreen(
          bp: 'depthead',
          host: widget.host,
          id: widget.list[0]['id']);
    }
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
          _requestDetails.length != 0
              ? Expanded(
              child: ListView.builder(
                  itemCount: _requestDetails.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () => Navigator.of(context).push(
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                              nextpage(_requestDetails[i].type,_requestDetails[i].id))),
                      child: Container(
                        decoration: new BoxDecoration(
                          color: _requestDetails[i].read_at == null ? Theme.of(context).brightness == Brightness.light
                              ? Colors.blueGrey[100] : Colors.blueGrey[800] : Theme.of(context).brightness == Brightness.light
                              ? Colors.grey[50] : Colors.grey[850],
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
                                    image: imagenotif(_requestDetails[i].type),
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
                              MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                               /* Container(
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

                                    ],
                                  ),
                                ),*/
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
                                        editdata(_requestDetails[i].data),
                                        //_requestDetails[i].type,
                                        style: new TextStyle(
                                            fontSize: 13.5,
                                            fontFamily: 'Montserrat',
                                            fontWeight:
                                            _requestDetails[i].read_at == null ? FontWeight.w600 : FontWeight.w500
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 12.0, top:3.0),
                                  child: Text(
                                    date(_requestDetails[i].created_at),
                                    style: new TextStyle(
                                        fontSize: 11,
                                        fontFamily: 'Montserrat',
                                        fontWeight:
                                        _requestDetails[i].read_at == null ? FontWeight.w500 : FontWeight.w300,
                                        /*color: Theme.of(context)
                                            .brightness ==
                                            Brightness.light
                                            ? Colors.blue
                                            : Colors.blue[400]*/
                                    ),
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
              child: Text('You have no notifications yet'),
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

      if (requestDetail.id.toLowerCase().contains(text.toLowerCase()) ||
          requestDetail.type.toLowerCase().contains(text.toLowerCase()) ||
          date(requestDetail.data.toLowerCase()).contains(text.toLowerCase()))
        _searchResult.add(requestDetail);
    });
    setState(() {});
  }
}

List<RequestDetails> _searchResult = [];
List<RequestDetails> _requestDetails = [];

class RequestDetails {
  final String id;
  final String type;
  final String notifiable_type;
  final String notifiable_id;
  final String data;
  final String read_at;
  final String created_at;
  RequestDetails(
      {this.id,
        this.type,
        this.notifiable_type,
        this.notifiable_id,
        this.data,
        this.read_at,
        this.created_at});

  factory RequestDetails.fromJson(Map<String, dynamic> json) {
    return new RequestDetails(
        id: json['id'],
        type: json['type'],
        notifiable_type: json['notifiable_type'],
        notifiable_id: json['notifiable_id'],
        data: json['data'],
        read_at: json['read_at'],
        created_at: json['created_at']);
  }
}
