import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String> items = [('ORange'),('Grape'),('pineapple'),('freeshavado'),('banana'),('mango')];
  TextEditingController controller = new TextEditingController();
  String filter;

  @override
  initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
        child: new Column(children: <Widget>[
      new Padding(
        padding: new EdgeInsets.only(top: 20.0),
      ),
      new TextField(
        decoration: new InputDecoration(labelText: "Search something"),
        controller: controller,
      ),
      new Expanded(
        child: new ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return filter == null || filter == ""
                ? new Card(child: new Text(items[index]))
                : items[index].toLowerCase().contains(filter.toLowerCase())
                    ? new Card(child: new Text(items[index]))
                    : new Container();
          },
        ),
      )
    ]));
  }
}
