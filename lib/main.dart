import 'package:flutter/material.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iwhollet/screens/welcome_screen/welcome_screen.dart';
import 'routes.dart';

void main() async {
  await GetStorage.init();
  await FlutterIconNetwork.instance!
      .init(host: "https://bicon.net.solidwallet.io/api/v3", isTestNet: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iWhollet Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: WelcomeScreen.routeName,
      routes: routes,
    );
  }
}

