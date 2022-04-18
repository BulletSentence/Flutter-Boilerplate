import 'package:flutter/material.dart';
import 'package:projectb/services/auth_service.dart';
import 'package:projectb/views/home_view.dart';
import 'package:projectb/views/login_view.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    if (auth.isLoading) {
      return loading();
    } else if (auth.usuario == null) {
      return const LoginView();
    } else {
      print("Usuario Logado: " + auth.usuario.toString());
      return const HomeView();
    }
  }

  Widget loading() {
    return const Scaffold(
      body: CircularProgressIndicator(),
    );
  }
}