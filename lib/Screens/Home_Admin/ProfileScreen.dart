import 'package:flutter/material.dart';
import 'package:procura/Components/custom_icons.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({this.host,this.list, this.pic});
  final String host;
  final List list;
  final String pic;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
//      appBar: AppBar(
//        iconTheme: IconThemeData(
//          color: Theme.of(context).brightness == Brightness.light
//              ? Colors.black
//              : Colors.white, //change your color here
//        ),
//        title: Text(
//          "My Profile",
//          style: new TextStyle(
//              color: Theme.of(context).brightness == Brightness.light
//                  ? Colors.black
//                  : Colors.white,
//              fontSize: 16.0,
//              fontWeight: FontWeight.w500,
//              letterSpacing: 0.5,
//              fontFamily: 'Montserrat'),
//        ),
//        centerTitle: true,
//        elevation: 0.0,
//        backgroundColor: Colors.transparent,
//      ),
      body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          //User's Details(name,pic,signature)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FractionalTranslation(
                translation: Offset(0.0, 0.6),
                child: IconButton(
                  icon: Icon(CustomIcons.uniE875),
                  iconSize: 20.0,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
                ),
              ),
              FractionalTranslation(
                translation: Offset(0.26, -0.04),
                child: Container(
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      image: new NetworkImage(host + list[0]['user_image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: width/1.2,
                  height: width/1.2,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    list[0]['user_signature'] == null
                        ? FractionalTranslation(
                            translation: Offset(0.0, -0.4),
                            child: Container(
//                                  decoration: BoxDecoration(
//                                    border: Border.all(
//                                      color: Colors.deepOrange,
//                                      width: 1.0
//                                    )
//                                  ),
                                height: 80.0,
                                width: 200.0,
                                child: GestureDetector(
                                  onTap: (){},
                                  child: Center(
                                    child: Text(
                                      'Signature not yet provided.\n'
                                          'Click here to create your signature',
                                      style: new TextStyle(
                                          color:
                                              Theme.of(context).brightness ==
                                                      Brightness.light
                                                  ? Colors.black
                                                  : Colors.white,
                                          fontSize: 14.0,
                                          fontStyle: FontStyle.italic,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )),
                          )
                        : FractionalTranslation(
                            translation: Offset(0.0, -0.4),
                            child: Container(
//                                decoration: BoxDecoration(
//                                    border: Border.all(
//                                        color: Colors.deepOrange,
//                                        width: 1.0
//                                    )
//                                ),
                              height: 80.0,
                              width: 180.0,
                              child: Image.network(
                                  host + list[0]['user_signature']),
                            ),
                          ),
                    Text(
                      list[0]['name'],
                      style: new TextStyle(
                          color: Theme.of(context).brightness ==
                                  Brightness.light
                              ? Colors.black
                              : Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          fontFamily: 'Lulo'),
                    ),
                    FractionalTranslation(
                      translation: Offset(0.0, 1.0),
                      child: Text(
                        list[0]['username'],
                        style: new TextStyle(
                            color: Theme.of(context).brightness ==
                                Brightness.light
                                ? Colors.black
                                : Colors.white,
                            fontSize: 17.0,
                            letterSpacing: 0.5,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                    FractionalTranslation(
                      translation: Offset(0.0, 2.0),
                      child: Text(
                        list[0]['user_types'],
                        style: new TextStyle(
                            color: Theme.of(context).brightness ==
                                Brightness.light
                                ? Colors.black
                                : Colors.white,
                            fontSize: 17.0,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 0.5,),
                      ),
                    ),
                  ],
                ),
                Center(
                    child: Container(
                      height: 150.0
                    ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
