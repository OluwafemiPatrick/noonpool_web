import 'package:flutter/material.dart';

Route<dynamic> _generateAppRoutes(RouteSettings settings) {
  switch (settings.name) {
    //AUTHENTICATION
    /*   case loginRoute:
      return _getPageRoute(
        const LoginPage(),
        arguement: settings.arguments,
      ); */

    default:
      return _getPageRoute(
        const SizedBox(),
        arguement: settings.arguments,
      );
  }
}

//used to navigate the auth screens
Navigator pageNavigation({
  required Key? navigatorKey,
  required String? initialRoute,
}) =>
    Navigator(
      key: navigatorKey,
      initialRoute: initialRoute,
      onGenerateRoute: _generateAppRoutes,
    );

PageRoute _getPageRoute(Widget child, {Object? arguement}) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 500),
    reverseTransitionDuration: const Duration(milliseconds: 600),
    settings: RouteSettings(
      arguments: arguement,
    ),
    pageBuilder: (_, __, ___) => child,
    transitionsBuilder: (_, anim1, __, child) => FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(anim1),
      child: child,
    ),
  );
}
