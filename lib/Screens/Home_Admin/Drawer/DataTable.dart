import 'package:flutter/material.dart';

class DataTablesamp extends StatefulWidget {
  @override
  DataTablesampState createState() {
    return new DataTablesampState();
  }
}

class DataTablesampState extends State<DataTablesamp> {
  Widget bodyData() => DataTable(
      onSelectAll: (b) {},
      sortColumnIndex: 1,
      sortAscending: true,
      columns: <DataColumn>[
        DataColumn(
          label: Text("First Name"),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              names.sort((a, b) => a.firstName.compareTo(b.firstName));
            });
          },
          tooltip: "To display first name of the Name",
        ),
        DataColumn(
          label: Text("Last Name"),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              names.sort((a, b) => a.lastName.compareTo(b.lastName));
            });
          },
          tooltip: "To display last name of the Name",
        ),
      ],
      rows: names
          .map(
            (name) => DataRow(
          cells: [
            DataCell(
              Text(name.firstName),
              showEditIcon: false,
              placeholder: false,
            ),
            DataCell(
              Text(name.lastName),
              showEditIcon: false,
              placeholder: false,
            )
          ],
        ),
      )
          .toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Table"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(child: Card(child: bodyData())),
        ),
      ),
    );
  }
}

class table extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.topCenter,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      children: [
                        TableRow(children: [
                          TableCell(
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  'NAME',
                                  style: new TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'STATUS',
                                  style: new TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'YEAR',
                                  style: new TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          )
                        ]),
                      ],
                    ),
                  ),
                  Container(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey[300]
                        : Colors.grey[850],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Table(
                          children: [
                            TableRow(children: [
                              TableCell(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Expanded(flex: 1,child: Container(child: Text('Sample aasdascascca', overflow: TextOverflow.ellipsis))),
                                    Expanded(flex: 1,child: Container(child: Text('Sample sample', overflow: TextOverflow.ellipsis))),
                                    Expanded(flex: 1,child: Container(child: Text('Sample sample', overflow: TextOverflow.ellipsis))),
                                  ],
                                ),
                              )
                            ])
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}


class Name {
  String firstName;
  String lastName;

  Name({this.firstName, this.lastName});
}

var names = <Name>[
  Name(firstName: "Geisher", lastName: "Bernabe"),
  Name(firstName: "Audrey Noelle", lastName: "Waje"),
  Name(firstName: "Leonardo", lastName: "Pajuyo"),
];