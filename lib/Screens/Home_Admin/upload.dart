import 'dart:io';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

Future upload(File imagefile) async {
  var stream = new http.ByteStream(DelegatingStream.typed(imagefile.openRead()));
  var length = await imagefile.length();
  var uri = Uri.parse("http://192.168.22.5/Procura/mobile/uploadSign.php");
  var request = new http.MultipartRequest("POST", uri);
  var multipartFile = new http.MultipartFile("image", stream, length, filename: basename(imagefile.path));

  request.files.add(multipartFile);

  var response = await request.send();

  if(response.statusCode == 200){
    print("Image uploaded");
  }else{
    print("Failed");
  }
}