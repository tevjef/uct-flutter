import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new PreferredSize(
          preferredSize: new Size(MediaQuery.of(context).size.width, 200.0),
          child: new Stack(
            alignment: const FractionalOffset(0.98, 1.12),
            children: <Widget>[
              new Container(
                  color: Colors.blue,
                  child: new Column(
                    children: <Widget>[
                      new Container(
                          margin:
                              const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                          child: new Column(children: <Widget>[
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Row(
                                  children: <Widget>[
                                    new IconButton(
                                        icon: new Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        }),
                                    new Text(
                                      "Controller Name",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ]))
                    ],
                  )),
              new FloatingActionButton(
                onPressed: () {
                  print("floating button Tapped");
                },
                child: new Icon(Icons.add),
              )
            ],
          )),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Container(),
      ),
    );
  }
}
