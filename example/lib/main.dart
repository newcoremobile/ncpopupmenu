import 'package:flutter/material.dart';
import 'package:ncpopupmenu/ncpopupmenu.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<State<StatefulWidget>> _bottomBtnKey = GlobalKey();
  GlobalKey<State<StatefulWidget>> _actionMoreKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black87,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('PopupMenu Demo'),
          actions: [
            FlatButton(
              key: _actionMoreKey,
              child: Icon(Icons.more_horiz),
              onPressed: () {
                ncShowPopupMenu(context, anchorViewKey: _actionMoreKey,
                    onMenuItemTap: (value) {
                  print("Select menu item value: $value");
                }, menuItems: [
                  NCMenuItem.textWithIcon(
                    value: "menu1",
                    icon: Icon(Icons.edit),
                    text: Text(
                      '编辑',
                    ),
                  ),
                  NCMenuItem.textWithIcon(
                    value: "menu2",
                    icon: Icon(Icons.delete),
                    text: Text('删除日志'),
                  ),
                ]);
              },
            )
          ]),
      body: SafeArea(
        child: Builder(
          builder: (ctx) => Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomRight,
                child: RaisedButton(
                  key: _bottomBtnKey,
                  child: Text('showBottom'),
                  onPressed: () {
                    ncShowPopupMenu(context, anchorViewKey: _bottomBtnKey,
                        onMenuItemTap: (value) {
                      print("Select menu item value: $value");
                    }, menuItems: [
                      NCMenuItem.textWithIcon(
                        value: "menu item 1",
                        icon: Icon(Icons.edit),
                        text: Text(
                          '编辑',
                        ),
                      ),
                      NCMenuItem.textWithIcon(
                        value: "menu item 2",
                        icon: Icon(Icons.delete),
                        text: Text('删除日志'),
                      ),
                    ]);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
