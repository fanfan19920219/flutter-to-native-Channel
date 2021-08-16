import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue, splashColor: Colors.transparent),
      home: HYBatteryScreen(),
    );
  }
}

class HYBatteryScreen extends StatefulWidget {
  static const String routeName = "/battery";

  @override
  _HYBatteryScreenState createState() => _HYBatteryScreenState();
}

class _HYBatteryScreenState extends State<HYBatteryScreen> {
  // 核心代码一：
  static const platform = const MethodChannel("coderwhy.com/battery");
  int _result = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Battery"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("当前电池信息: $_result"),
            RaisedButton(
              child: Text("获取电池信息"),
              onPressed: getBatteryInfo,
            )
          ],
        ),
      ),
    );
  }

  void getBatteryInfo() async {
    // 核心代码二
    final int result = await platform.invokeMethod("getBatteryInfo");
    print("result $result");
    setState(() {
      _result = result;
    });
  }
}