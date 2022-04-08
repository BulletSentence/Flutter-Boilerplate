import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/constants/settings.dart';
import 'package:flutter_boilerplate/views/data_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NetRunner Data",
      debugShowCheckedModeBanner: false,
      theme: themeConfigs,
      home: DataView(),
    );
  }
}
