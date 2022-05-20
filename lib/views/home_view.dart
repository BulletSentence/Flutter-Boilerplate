import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:projectb/config/app_theme.dart';
import 'package:projectb/models/battlelog.dart';
import 'package:projectb/repositories/requests_url.dart';
import 'package:projectb/widgets/header.dart';
import 'package:projectb/widgets/horizontal_minicard.dart';
import 'package:projectb/widgets/vertical_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

Future<String?> welcomeHeader() async {
  final prefs = await SharedPreferences.getInstance();
  final String? name = prefs.getString('user-name');
  return name;
}

class _HomeViewState extends State<HomeView> {
  late Future<Battlelog> futureUserData;

  Future<Battlelog> fetchUserData() async {
    final response = await http.get(Uri.parse("${valorantUrl}Almeida%23LeoBS"));
    if (response.statusCode == 200) {
      var test = jsonDecode(response.body);
      //print(test['data']['segments'][0]['stats']['deaths']['displayValue']);
      return Battlelog.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    super.initState();
    fetchUserData();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, '/user');
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HeaderScrollable(
                image: "assets/images/valorant-icon.png",
                textTop: "User Text",
                textBottom: "text",
                offset: offset,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: FutureBuilder(
                        future: fetchUserData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            return CircleAvatar(
                              backgroundImage: NetworkImage(snapshot.data!.profileUrl),
                              radius: 40,
                            );
                          } else {
                            return const CircleAvatar(
                              backgroundImage: AssetImage("assets/images/user.png"),
                              radius: 40,
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: FutureBuilder(
                        future: fetchUserData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data!.name,
                              style: primaryBigTextStyleBold,
                            );
                          } else {
                            return Text(
                              " ",
                              style: primaryTextStyle,
                            );
                          }
                        },
                      ),
                    ),
                    Center(
                      child: FutureBuilder(
                        future: fetchUserData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data!.platform.toString().toUpperCase(),
                              style: primaryTextStyle,
                            );
                          } else {
                            return Text(
                              " ",
                              style: primaryTextStyle,
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "User Status",
                      style: primaryTextStyleBold,
                    ),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FutureBuilder(
                            future: fetchUserData(),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData) {
                                return hMiniCardWidget(
                                  image: "assets/images/target.png",
                                  title: "Kills",
                                  subtitle: snapshot.data!.kills,
                                  isActive: true,
                                );
                              } else {
                                return const hMiniCardWidget(
                                  image: "assets/images/target.png",
                                  title: "Kills",
                                  subtitle: " ",
                                  isActive: true,
                                );
                              }
                            },
                          ),
                          FutureBuilder(
                            future: fetchUserData(),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData) {
                                return hMiniCardWidget(
                                  image: "assets/images/deaths.png",
                                  title: "Deaths",
                                  subtitle: snapshot.data!.deaths,
                                  isActive: true,
                                );
                              } else {
                                return const hMiniCardWidget(
                                  image: "assets/images/deaths.png",
                                  title: "Deaths",
                                  subtitle: " ",
                                  isActive: true,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text("Prevention", style: primaryTextStyleBold),
                    const SizedBox(height: 20),
                    const vCardWidget(
                      text:
                          "Since the start of the coronavirus outbreak some places have fully embraced wearing facemasks",
                      image: "assets/images/wear_mask.png",
                      title: "Wear face mask",
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
