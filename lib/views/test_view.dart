import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:projectb/models/battlelog.dart';

class TestView extends StatefulWidget {
  const TestView({Key? key}) : super(key: key);

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  late Future<Battlelog> futureUserData;

  Future<Battlelog> fetchUserData() async {
    final response = await http.get(Uri.parse(
        'https://api.tracker.gg/api/v2/bf2042/standard/profile/psn/LeoAlmeidaBS'));
    if (response.statusCode == 200) {
      return Battlelog.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchUserData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data!.name);
          } else {
            return Text("Nada");
          }
        },
      ),
    );
  }
}
