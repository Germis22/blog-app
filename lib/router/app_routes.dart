import 'package:flutter/material.dart';
import 'package:flutter_technical_test/screens/comments_screen.dart';
import 'package:flutter_technical_test/screens/new_post_screen.dart';

import '../screens/home_screen.dart';

class AppRoutes {
  static const initialRoute = 'home';
  static const comments = 'comments';
  static const newPost = 'new_post';

  static Map<String, Widget Function(BuildContext)> routes = {
    'home': (BuildContext context) => const HomeScreen(),
    'comments': (BuildContext context) => const CommentsScreen(),
    'new_post': (BuildContext context) => const NewPostScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (BuildContext context) => const HomeScreen(),
    );
  }
}
