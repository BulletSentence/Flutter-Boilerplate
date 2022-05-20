import 'package:flutter/material.dart';
import 'package:projectb/config/app_theme.dart';
import 'package:projectb/widgets/auth_widget.dart';
import 'package:provider/provider.dart';
import '../functions/remove_spaces.dart';
import '../services/auth_service.dart';
import '../shared/string_texts.dart';
import '../widgets/loginform_widget.dart';
import '../widgets/registerform_widget.dart';
import '../widgets/snackbar_message.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();
  var _passwordVisible = false;
  bool loading = false;
  bool isRegistering = false;
  bool isLogin = true;

  login() async {
    setState(() => loading = true);
    try {
      await context.read<AuthService>().login(
          removeSpaces(emailController.text),
          removeSpaces(passController.text));
      setState(() => loading = false);
    } on AuthException catch (e) {
      setState(() => loading = false);
      snackbarMessage(e.message, _scaffoldKey, context);
    }
  }

  register() async {
    setState(() => loading = true);
    try {
      await context.read<AuthService>().registrar(
          removeSpaces(emailController.text),
          removeSpaces(passController.text),
          nameController.text);
      setState(() => loading = false);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const AuthCheck()));
    } on AuthException catch (e) {
      setState(() => loading = false);
      snackbarMessage(e.message, _scaffoldKey, context);
    }
  }

  googleLogin() async {
    setState(() => loading = true);
    try {
      await context.read<AuthService>().signInwithGoogle();
      setState(() => loading = false);
    } on AuthException catch (e) {
      setState(() => loading = false);
      snackbarMessage(e.message, _scaffoldKey, context);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  void callback() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Image(
                image: AssetImage('assets/images/mobile_login.png'),
                height: 300,
              ),
              Center(
                child: (isRegistering)
                    ? registerFormWidget(
                        context,
                        _formKey,
                        nameController,
                        emailController,
                        passController,
                        _passwordVisible,
                        loading,
                        callback,
                        register,
                        googleLogin)
                    : loginFormWidget(
                        context,
                        _formKey,
                        emailController,
                        passController,
                        _passwordVisible,
                        loading,
                        callback,
                        login,
                        googleLogin),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: primaryButtonStyle,
                onPressed: () {
                  if (isRegistering == false) {
                    setState(() => isRegistering = true);
                  } else {
                    setState(() => isRegistering = false);
                  }
                },
                child: (isRegistering)
                    ? Text(btnLogin,
                        style: primaryTextStyle,
                        textDirection: TextDirection.ltr)
                    : Text(btnCreate,
                        style: primaryTextStyle,
                        textDirection: TextDirection.ltr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
