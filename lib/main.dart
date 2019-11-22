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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      var index = _tabController.index;
      var previewIndex = _tabController.previousIndex;
      print('index:$index, preview:$previewIndex');
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
//              expandedHeight: 200.0,
              floating: false,
              pinned: false,
              snap: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(widget.title,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 16.0,
                    )),
                /* background: Image.network(
                  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1550383267899&di=9b9fe57bd7a0bd55c7d673ad449360b1&imgtype=0&src=http%3A%2F%2Fpptdown.pptbz.com%2Fpptbeijing%2F%25E9%2592%25A2%25E9%2593%2581%25E4%25BE%25A0%25E5%25B8%2585%25E6%25B0%2594%25E6%2589%258B%25E7%25BB%2598%25E8%25AE%25BE%25E8%25AE%25A1PPT%25E8%2583%258C%25E6%2599%25AF%25E5%259B%25BE%25E7%2589%2587.jpg",
                  fit: BoxFit.fill,
                ),*/
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverPersistentHeaderDelegate(TabBar(
                  controller: _tabController,
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(icon: Icon(Icons.home), text: "tab1"),
                    Tab(icon: Icon(Icons.person), text: "tab2"),
                    Tab(icon: Icon(Icons.person), text: "tab2"),
                    Tab(icon: Icon(Icons.person), text: "tab2"),
                  ])),
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

class _SliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverPersistentHeaderDelegate(this._tabBar);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
      color: Colors.white,
    );
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
