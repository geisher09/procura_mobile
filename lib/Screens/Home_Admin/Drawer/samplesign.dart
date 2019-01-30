import 'dart:io';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:procura/Screens/Home_Admin/Drawer/upload.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:flutter/services.dart';


const directoryName = 'Signature';

class SignApp2 extends StatefulWidget {
  SignApp2({this.host,this.list});
  final String host;
  final List list;
  @override
  State<StatefulWidget> createState() {
    return SignApp2State(host: host, list: list);
  }
}

class SignApp2State extends State<SignApp2> {
  SignApp2State({this.host,this.list});
  final String host;
  final List list;
  GlobalKey<SignatureState> signatureKey = GlobalKey();
  var image;
  File _imagesign;
  String _platformVersion = 'Unknown';
  Permission _permission = Permission.WriteExternalStorage;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }
  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await SimplePermissions.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
    print(_platformVersion);
  }

  @override
  Widget build(BuildContext context) {
    //forced-landscape
//    SystemChrome.setPreferredOrientations([
//      DeviceOrientation.landscapeRight
//    ]);

    return Scaffold(
      body: Signature(key: signatureKey),
      persistentFooterButtons: <Widget>[
        FlatButton(
          child: Text('Clear'),
          onPressed: () {
            signatureKey.currentState.clearPoints();
          },
        ),
        FlatButton(
          child: Text('Save'),
          onPressed: () {
            // Future will resolve later
            // so setState @image here and access in #showImage
            // to avoid @null Checks
            setState(() {
              image = signatureKey.currentState.rendered;
            });
            showImage(context, point: signatureKey.currentState._points);
          },
        )
      ],
    );
  }
  Future<Null> showImage(BuildContext context, {List<ui.Offset> point}) async {
    var pngBytes = await image.toByteData(format: ui.ImageByteFormat.png);
    int num2 = point.length;
    if(!(await checkPermission())) await requestPermission();
    // Use plugin [path_provider] to export image to storage
    Directory directory = await getExternalStorageDirectory();
    String path = directory.path;
    int lastnum;
    print(path);
    List<String> splitSignpath;
    if(list[0]['user_signature']==null){
      lastnum = 0;
    }else{
      splitSignpath = list[0]['user_signature'].split('.');
      lastnum = int.parse(splitSignpath[3]);
      print(splitSignpath);
    }
    //./assets/UserSignatures/7.2.png
    lastnum += 1;
    await Directory('$path/$directoryName').create(recursive: true);
    File('$path/$directoryName/${list[0]['id']}.$lastnum.png')
        .writeAsBytesSync(pngBytes.buffer.asInt8List());

    setState(() {
      _imagesign = File('$path/$directoryName/${list[0]['id']}.$lastnum.png');
    });
    String text;
    if(num2 > 0){
      text = 'Success! You have set your signature!';
    }else{
      text = 'Error! You should draw something.';
    }
    upload(host, list, _imagesign);
    return showDialog<Null>(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Theme.of(context).primaryColor,
                    letterSpacing: 1.1
                ),
              ),
              //content: Image.memory(Uint8List.view(pngBytes.buffer)),
              content: Column(
                children: <Widget>[
                  Image.asset('$path/$directoryName/${list[0]['id']}.$lastnum.png'),
                  //Image.file(File('$path/$directoryName/heee.png'))
                ],
              ),
              actions: <Widget>[
                new FlatButton(
                    child: new Text(
                      "Close",
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      Navigator.of(context).popAndPushNamed('/home');
                    }
//                  {
//                    Navigator.of(context).pop();
//                  },
                ),
              ],
            ),
          );
        }
    );
  }


  requestPermission() async {
    PermissionStatus result = await SimplePermissions.requestPermission(_permission);
    return result;
  }

  checkPermission() async {
    bool result = await SimplePermissions.checkPermission(_permission);
    return result;
  }

  getPermissionStatus() async {
    final result = await SimplePermissions.getPermissionStatus(_permission);
    print("permission status is " + result.toString());
  }

}

class Signature extends StatefulWidget {
  Signature({Key key}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SignatureState();
  }
}

class SignatureState extends State<Signature> {
  // [SignatureState] responsible for receives drag/touch events by draw/user
  // @_points stores the path drawn which is passed to
  // [SignaturePainter]#contructor to draw canvas
  List<Offset> _points = <Offset>[];

  ui.Image get rendered {
    // [CustomPainter] has its own @canvas to pass our
    // [ui.PictureRecorder] object must be passed to [Canvas]#contructor
    // to capture the Image. This way we can pass @recorder to [Canvas]#contructor
    // using @painter[SignaturePainter] we can call [SignaturePainter]#paint
    // with the our newly created @canvas
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    SignaturePainter painter = SignaturePainter(points: _points);
    var size = context.size;
    painter.paint(canvas, size);
    return recorder.endRecording()
        .toImage(size.width.floor(), size.height.floor());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            setState(() {
              RenderBox _object = context.findRenderObject();
              Offset _locationPoints = _object.localToGlobal(details.globalPosition);
              _points = new List.from(_points)..add(_locationPoints);
            });
          },
          onPanEnd: (DragEndDetails details) {
            setState(() {
              _points.add(null);
            });
          },
          child: CustomPaint(
            painter: SignaturePainter(points: _points),
            size: Size.infinite,
          ),
        ),
      ),
    );
  }

  // clearPoints method used to reset the canvas
  // method can be called using
  //   key.currentState.clearPoints();
  void clearPoints() {
    setState(() {
      _points.clear();
    });
  }
}


class SignaturePainter extends CustomPainter {
  // [SignaturePainter] receives points through constructor
  // @points holds the drawn path in the form (x,y) offset;
  // This class responsible for drawing only
  // It won't receive any drag/touch events by draw/user.
  List<Offset> points = <Offset>[];

  SignaturePainter({this.points});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;

    for(int i=0; i < points.length - 1; i++) {
      if(points[i] != null && points[i+1] != null) {
        canvas.drawLine(points[i], points[i+1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) {
    return oldDelegate.points != points;
  }

}