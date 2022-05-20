import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:projectb/config/app_theme.dart';
import 'package:projectb/config/configs.dart';
import 'package:projectb/functions/offline_data.dart';
import 'package:projectb/services/auth_service.dart';
import 'package:projectb/shared/string_texts.dart';
import 'package:projectb/widgets/alertdialog_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserView extends StatefulWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  State<UserView> createState() => _UserViewState();
}

@override
Future<String?> welcomeHeader() async {
  final prefs = await SharedPreferences.getInstance();
  final String? name = prefs.getString('user-name');
  return name;
}

class _UserViewState extends State<UserView> {
  logout() async {
    try {
      await context.read<AuthService>().logout();
      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          settingsTexts,
          style: primaryTextStyle,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child:
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(children: [
              Container(
                margin: const EdgeInsets.only(top: 48),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 80, bottom: 20, left: 20, right: 20),
                  child: Column(
                    children: [
                      FutureBuilder(
                        future: getOffUsername(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            return TextFormField(
                                initialValue: snapshot.data,
                                style: formStyle,
                                keyboardType: TextInputType.text,
                                enabled: false,
                                decoration:
                                    formStyleFunction("Nome do Usuario"));
                          } else {
                            return Container();
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      FutureBuilder(
                        future: getOffEmail(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            return TextFormField(
                                initialValue: snapshot.data,
                                style: formStyle,
                                keyboardType: TextInputType.text,
                                enabled: false,
                                decoration:
                                    formStyleFunction("Email do Usuario"));
                          } else {
                            return Container();
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                          initialValue: "************",
                          style: formStyle,
                          keyboardType: TextInputType.text,
                          enabled: false,
                          decoration: formStyleFunction("************")),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  child: CircleAvatar(
                    radius: 40.0,
                    child: FutureBuilder(
                      future: getOffProfilePic(),
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.hasData) {
                          return CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage:
                                (snapshot.data.toString().length > 5)
                                    ? NetworkImage(snapshot.data.toString())
                                    : const AssetImage('assets/images/user.png')
                                        as ImageProvider,
                            child: const Align(
                              alignment: Alignment.bottomRight,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 12.0,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 15.0,
                                  color: Color(0xFF404040),
                                ),
                              ),
                            ),
                            radius: 38.0,
                          );
                        } else {
                          return const CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage('assets/images/user.png'),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 12.0,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 15.0,
                                  color: Color(0xFF404040),
                                ),
                              ),
                            ),
                            radius: 38.0,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    child: Text(editProfile),
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.redAccent),
                    ),
                    child: Text(quitBtnText),
                    onPressed: () {
                      showDialogWidget(
                        context,
                        logoutDialTitle,
                        logoutDialDesc,
                        logoutText,
                        logout,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      ),
    );
  }
}
