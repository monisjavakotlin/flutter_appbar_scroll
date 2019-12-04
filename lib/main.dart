import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: NewsScreen(),
    );
  }
}

class NewsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final List<String> listItems = [];

  final List<String> _tabs = <String>[
    "Featured",
    "Popular",
    "Latest",
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: DefaultTabController(
          length: _tabs.length, // This is the number of tabs.
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              // These are the slivers that show up in the "outer" scroll view.
              return <Widget>[
                SliverOverlapAbsorber(
                  // This widget takes the overlapping behavior of the SliverAppBar,
                  // and redirects it to the SliverOverlapInjector below. If it is
                  // missing, then it is possible for the nested "inner" scroll view
                  // below to end up under the SliverAppBar even when the inner
                  // scroll view thinks it has not been scrolled.
                  // This is not necessary if the "headerSliverBuilder" only builds
                  // widgets that do not overlap the next sliver.
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  child: SliverSafeArea(
                    top: false,
                    sliver: SliverAppBar(
                      title: const Text('Books'),
                      floating: true,
                      pinned: true,
                      snap: true,
                      primary: true,
                      forceElevated: innerBoxIsScrolled,
                      bottom: TabBar(
                        // These are the widgets to put in each tab in the tab bar.
                        tabs: _tabs
                            .map((String name) => Tab(text: name))
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              // These are the contents of the tab views, below the tabs.
              children: _tabs.map((String name) {
                return SafeArea(
                  top: false,
                  bottom: false,
                  child: Builder(
                    // This Builder is needed to provide a BuildContext that is "inside"
                    // the NestedScrollView, so that sliverOverlapAbsorberHandleFor() can
                    // find the NestedScrollView.
                    builder: (BuildContext context) {
                      return CustomScrollView(
                        // The "controller" and "primary" members should be left
                        // unset, so that the NestedScrollView can control this
                        // inner scroll view.
                        // If the "controller" property is set, then this scroll
                        // view will not be associated with the NestedScrollView.
                        // The PageStorageKey should be unique to this ScrollView;
                        // it allows the list to remember its scroll position when
                        // the tab view is not on the screen.
                        key: PageStorageKey<String>(name),
                        slivers: <Widget>[
                          SliverOverlapInjector(
                            // This is the flip side of the SliverOverlapAbsorber above.
                            handle:
                                NestedScrollView.sliverOverlapAbsorberHandleFor(
                                    context),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.all(8.0),
                            // In this example, the inner scroll view has
                            // fixed-height list items, hence the use of
                            // SliverFixedExtentList. However, one could use any
                            // sliver widget here, e.g. SliverList or SliverGrid.
                            sliver: SliverFixedExtentList(
                              // The items in this example are fixed to 48 pixels
                              // high. This matches the Material Design spec for
                              // ListTile widgets.
                              itemExtent: 100.0,
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  // This builder is called for each child.
                                  // In this example, we just number each list item.
                                  return Column(
                                    children: <Widget>[
                                      Container(
                                        height: 90,
                                        width: double.infinity,
                                        color: Colors.blueGrey,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text('$index'),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  );
                                },
                                // The childCount of the SliverChildBuilderDelegate
                                // specifies how many children this inner list
                                // has. In this example, each tab has a list of
                                // exactly 30 items, but this is arbitrary.
                                childCount: 30,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

/*import 'package:flutter/material.dart';

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
                background: Image.network(
                  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1550383267899&di=9b9fe57bd7a0bd55c7d673ad449360b1&imgtype=0&src=http%3A%2F%2Fpptdown.pptbz.com%2Fpptbeijing%2F%25E9%2592%25A2%25E9%2593%2581%25E4%25BE%25A0%25E5%25B8%2585%25E6%25B0%2594%25E6%2589%258B%25E7%25BB%2598%25E8%25AE%25BE%25E8%25AE%25A1PPT%25E8%2583%258C%25E6%2599%25AF%25E5%259B%25BE%25E7%2589%2587.jpg",
                  fit: BoxFit.fill,
                ),
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
}*/

/*import 'package:flutter/material.dart';

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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // this sliver app bar is only use to hide/show the tabBar, the AppBar
    // is invisible at all times. The to the user visible AppBar is below
    return Scaffold(
      body: Stack(
        children: <Widget>[
          NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  primary: true,
                  floating: false,
                  backgroundColor: Colors.blue, //.withOpacity(0.3),
                  snap: false,
                  pinned: false,
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        child: Text(
                          "1",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Tab(
                        child: Text(
                          "2",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Tab(
                        child: Text(
                          "3",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    controller: _tabController,
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                MyScreen1(),
                MyScreen2(),
                MyScreen3(),
              ],
              controller: _tabController,
              physics: new NeverScrollableScrollPhysics(),
            ),
          ),

          // Here is the AppBar the user actually sees. The SliverAppBar
          // above will slide the TabBar underneath this one.
          // by using SafeArea it will.
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              child: SafeArea(
                top: false,
                child: AppBar(
                  backgroundColor: Colors.blue,
//                iconTheme: IconThemeData(
//                  color: Colors.red, //change your color here
//                ),
                  automaticallyImplyLeading: true,
                  elevation: 0,
                  title: Text(
                    "My Title",
                  ),
                  centerTitle: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Center(
        child: Text("My Screen 1"),
      ),
    );
  }
}

class MyScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("My Screen 2"),
      ),
    );
  }
}

class MyScreen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("My Screen 3"),
      ),
    );
  }
}*/

/*
import 'dart:math';

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
      home: MyHomePage(title: 'Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin*/
/*<-- This is for the controllers*/ /*
 {
  TabController _tabController; // To control switching tabs
  ScrollController _scrollViewController; // To control scrolling

  List<String> items = [];
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.blue,
    Colors.amber,
    Colors.cyan,
    Colors.pink
  ];
  Random random = new Random();

  Color getRandomColor() {
    return colors.elementAt(random.nextInt(colors.length));
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollViewController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _scrollViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Init the items
    for (var i = 0; i < 100; i++) {
      items.add('Item $i');
    }

    return SafeArea(
      child: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text("WhatsApp using Flutter"),
              floating: true,
              pinned: false,
              snap: true,
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    child: Text("Colors"),
                  ),
                  Tab(
                    child: Text("Chats"),
                  ),
                ],
                controller: _tabController,
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                Color color = getRandomColor();
                return Container(
                  height: 150.0,
                  color: color,
                  child: Text(
                    "Row $index",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              },
              //physics: NeverScrollableScrollPhysics(), //This may come in handy if you have issues with scrolling in the future
            ),
            ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Material(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                    ),
                    title: Text(items.elementAt(index)),
                  ),
                );
              },
              //physics: NeverScrollableScrollPhysics(),
            ),
          ],
        ),
      ),
    );
  }
}
*/
