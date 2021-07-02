import 'package:flutter/material.dart';
import 'package:kmodal_listview/kmodal_listview.dart';

void main() {
  runApp(MyApp());
}

///===================================
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'KModalListView'),
    );
  }
}

///===================================
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SafeArea(
        child: KListView<String>(
          model: MyModal(),
          options: KOptions(
            loadingIcon: Container(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(color: Colors.purple)),
          ),
        ),
      ),
    );
  }
}

///===================================
class MyModal extends KModal<String> {
  @override
  Widget empty({VoidCallback? retryFunction}) => Center(
        child: Text('Empty Content'),
      );

  @override
  String? get getKey => 'private_key';

  @override
  Widget listItem({String? data}) => Container(
        color: Colors.green.shade200,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          data ?? '...',
          style: TextStyle(fontSize: 15, color: Colors.black87),
        ),
      );

  @override
  Widget loading() =>
      Center(child: CircularProgressIndicator(color: Colors.red));

  @override
  Future<List<String>?> request({int page = 1}) async {
    if (page == 1) {
      return Future.delayed(
        const Duration(seconds: 3),
        () => List<String>.generate(10, (index) => "ListItem $index"),
      );
    } else if (page == 2) {
      return Future.delayed(
        const Duration(seconds: 3),
        () => List<String>.generate(4, (index) => "Next ListItem $index"),
      );
    } else {
      return <String>[];
    }
  }
}
