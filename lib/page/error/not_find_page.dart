import 'package:flutter/material.dart';

/// @author jd

class NotFindPage extends StatefulWidget {
  final String title = '迷路了';

  const NotFindPage({Key? key}) : super(key: key);

  @override
  State createState() => _NotFindPageState();
}

class _NotFindPageState extends State<NotFindPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(children: const <Widget>[
            Text('我迷路了哎'),
          ]),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
