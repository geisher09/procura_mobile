import 'dart:io';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

Future uploadPic(String host, List list, File imageFile) async {
  var stream =
  new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  var length = await imageFile.length();
  var uri = Uri.parse("${host}/updatePic.php");
  var idno = list[0]['id'];
  var request = http.MultipartRequest("POST", uri);
  var multipartFile = http.MultipartFile("image", stream, length, filename: basename(imageFile.path));
  request.fields['idnum'] = idno;
  request.files.add(multipartFile);
  var response = await request.send();

  if(response.statusCode == 200){
    print("IMAGE UPDATED");
  }else{
    print("Failed");
  }
}