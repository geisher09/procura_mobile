import 'dart:io';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future upload(String host, List list, File imagefile) async {
  var stream = new http.ByteStream(DelegatingStream.typed(imagefile.openRead()));
  var length = await imagefile.length();
  var uri = Uri.parse("$host/uploadSign.php");
  var idno = list[0]['id'];
  //sendID(host, list);
  var request = new http.MultipartRequest("POST", uri);
  var multipartFile = new http.MultipartFile("image", stream, length, filename: basename(imagefile.path));
  request.fields['idnum'] = idno;
  request.files.add(multipartFile);

  var response = await request.send();

  if(response.statusCode == 200){
    print("Image uploaded");
  }else{
    print("Failed");
  }
}