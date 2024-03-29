import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mvvm/auth_view_model.dart';
import 'mvvm/pages/login_page.dart';
import 'mvvm/pages/profile_scrren.dart';
import 'mvvm/pages/signup.dart';
import 'mvvm/pages/view_list.dart';
import 'mvvm/task_list_viewmodel.dart';
import 'views/home.dart';
import 'package:flutter/services.dart';

Future main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskViewModel('ownerUserId')),
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => SignIn(),
          '/signup': (context) => SignUpScreen(),
          '/home': (context) => ProfileScreen(),
          '/dashboard': (context) => TaskViewList(),

        },
      )

    );
  }
}
