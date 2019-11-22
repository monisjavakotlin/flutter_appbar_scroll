import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: false,
              floating: true,
              snap: true,
              title: Text(widget.title),
            )
          ];
        },
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return ListItemDemo('标题_$index');
          },
          itemCount: 50,
        ),
      ),
    );
  }
}

class ListItemDemo extends StatelessWidget {
  final String title;
  ListItemDemo(this.title);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        leading: Icon(Icons.ac_unit),
        title: Text(title),
      ),
    );
  }
}
