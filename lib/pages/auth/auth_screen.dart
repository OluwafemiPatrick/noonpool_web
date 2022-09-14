import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:noonpool_web/controller/auth_controller.dart';
import 'package:noonpool_web/pages/auth/forgot_password/forgot_password.dart';
import 'package:noonpool_web/pages/auth/login/login_sceen.dart';
import 'package:noonpool_web/pages/auth/register/register_sceen.dart';

class AuthPage extends StatefulWidget {
  final int startPage;
  const AuthPage({Key? key, required this.startPage}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(8.0),
      child: GetX<AuthController>(
          init: AuthController(widget.startPage),
          builder: (controller) {
            final page = controller.currentPage;
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: (page == 0)
                  ? const LoginPage()
                  : (page == 1)
                      ? const RegisterPage()
                      : const ForgotPasswordPage(),
            );
          }),
    );
  }
}
