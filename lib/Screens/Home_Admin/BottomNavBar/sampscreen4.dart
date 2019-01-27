import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class sampscreen4 extends StatefulWidget {
  @override
  _sampscreen4State createState() => _sampscreen4State();
}

class _sampscreen4State extends State<sampscreen4> {
  Future<Directory> _tempDirectory;
  Future<Directory> _appDocumentsDirectory;
  Future<Directory> _externalDocumentsDirectory;

  void _requestTempDirectory() {
    setState(() {
      _tempDirectory = getTemporaryDirectory();
    });
  }

  Widget _buildDirectory(
      BuildContext context, AsyncSnapshot<Directory> snapshot) {
    Text text = const Text('');
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        text = Text('Error: ${snapshot.error}');
      } else if (snapshot.hasData) {
        text = Text('path: ${snapshot.data.path}');
      } else {
        text = const Text('path unavailable');
      }
    }
    return Padding(padding: const EdgeInsets.all(16.0), child: text);
  }

  void _requestAppDocumentsDirectory() {
    setState(() {
      _appDocumentsDirectory = getApplicationDocumentsDirectory();
    });
  }

  void _requestExternalStorageDirectory() {
    setState(() {
      _externalDocumentsDirectory = getExternalStorageDirectory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('heeee'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RaisedButton(
                    child: const Text('URL Launcher'),
                    onPressed: (){
                      launch('http://192.168.22.8/Procura/mobile/sampleurl.php');
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RaisedButton(
                    child: const Text('Get Temporary Directoryzzza'),
                    onPressed: _requestTempDirectory,
                  ),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<Directory>(
                  future: _tempDirectory, builder: _buildDirectory),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RaisedButton(
                    child: const Text('Get Application Documents Directory'),
                    onPressed: _requestAppDocumentsDirectory,
                  ),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<Directory>(
                  future: _appDocumentsDirectory, builder: _buildDirectory),
            ),
            Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RaisedButton(
                  child: Text(
                      '${Platform.isIOS ? "External directories are unavailable " "on iOS" : "Get External Storage Directory"}'),
                  onPressed:
                  Platform.isIOS ? null : _requestExternalStorageDirectory,
                ),
              ),
            ]),
            Expanded(
              child: FutureBuilder<Directory>(
                  future: _externalDocumentsDirectory,
                  builder: _buildDirectory),
            ),
          ],
        ),
      ),
    );
  }
}