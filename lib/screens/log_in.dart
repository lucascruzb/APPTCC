import 'package:flutter/material.dart';
import 'package:listy/realm/realm_services.dart';
import 'package:listy/realm/schemas.dart';
import 'package:listy/theme.dart';
import 'package:provider/provider.dart';
import 'package:listy/realm/app_services.dart';

import 'todo/components/widgets.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool _isLogin = true;
  String? _errorMessage;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController()..addListener(clearError);
    _passwordController = TextEditingController()..addListener(clearError);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.only(top: 30),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(_isLogin ? 'Log In' : 'Sign Up',
                    style: const TextStyle(fontSize: 25)),
                loginField(_emailController,
                    labelText: "Email",
                    hintText: "Enter valid email like abc@gmail.com"),
                loginField(_passwordController,
                    labelText: "Password",
                    hintText: "Enter secure password",
                    obscure: true),
                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Text(
                      "Please login or register with a Device Sync user account. This is separate from your Atlas Cloud login.",
                      textAlign: TextAlign.center),
                ),
                loginButton(context,
                    child: Text(_isLogin ? "Log in" : "Sign up"),
                    onPressed: () => _logInOrSignUpUser(context,
                        _emailController.text, _passwordController.text)),
                TextButton(
                    onPressed: () => setState(() => _isLogin = !_isLogin),
                    child: Text(
                      _isLogin
                          ? "New to Flutter Realm Todo? Sign up"
                          : 'Already have an account? Log in.',
                    )),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Text(_errorMessage ?? "",
                      style: errorTextStyle(context),
                      textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void clearError() {
    if (_errorMessage != null) {
      setState(() {
        // Reset error message when user starts typing
        _errorMessage = null;
      });
    }
  }

  void _logInOrSignUpUser(
      BuildContext context, String email, String password) async {
    final appServices = Provider.of<AppServices>(context, listen: false);
    clearError();
    try {
      if (_isLogin) {
        await appServices.logInUserEmailPassword(email, password);
      } else {
        await appServices.registerUserEmailPassword(email, password);
      }

      if (!context.mounted) return;
      ajustePermissao(context);
      Navigator.pushNamed(context, '/');
    } catch (err) {
      setState(() {
        _errorMessage = err.toString();
      });
    }
  }

  void ajustePermissao(BuildContext context) {
    final realmServices = Provider.of<RealmServices>(context);
    realmServices.switchSubscription(
        realmServices.realm.query<Item>(
            r'owner_id == $0', [realmServices.currentUser?.id.toString()]),
        "getMyItemsSubscription");
    realmServices.switchSubscription(
        realmServices.realm.query<Usuario>(
            r'IDUser == $0', [realmServices.currentUser?.id.toString()]),
        "usuarioSubscription");
    final usuarioAtual =
        realmServices.realm.query<Usuario>("TRUEPREDICATE SORT(_id ASC)").first;
    realmServices.switchSubscription(
        realmServices.realm
            .query<Perfil>(r'IDPerfil == $0', [usuarioAtual.perfil]),
        "perfilSubscription");
  }
}
