import 'package:flashare/views/screens/authen/change_password.dart';
import 'package:flashare/views/screens/authen/signin.dart';
import 'package:flashare/views/screens/main_tab_bar.dart';
import 'package:flashare/views/screens/upload/request_sent.dart';
import 'package:flashare/views/screens/profile/review_screen.dart';
import 'package:flashare/views/screens/upload/upload_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'authen/signup.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: Colors.white,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white70,
          titleTextStyle: GoogleFonts.roboto(fontSize: 18, letterSpacing: 1.05),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.white,
        ),
        unselectedWidgetColor: Colors.white,
        textTheme: TextTheme(
          headline1: TextStyle(),
          headline2: TextStyle(),
          headline3: TextStyle(),
          headline4: TextStyle(),
          headline5: TextStyle(),
          headline6: TextStyle(),
          subtitle1: TextStyle(),
          subtitle2: TextStyle(),
          bodyText1: TextStyle(),
          bodyText2: TextStyle(
            letterSpacing: 1.05,
          ),
          caption: TextStyle(),
          button: TextStyle(),
          overline: TextStyle(),
        ).apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
          fontFamily: GoogleFonts.roboto().fontFamily,
        ),
      ),
      initialRoute: '/signin',
      routes: {
        '/signin': (context) => SignIn(),
        '/signup': (context) => SignUp(),
        '/home': (context) => const MainTabBar(),
        '/upload_item': (context) => const UploadItemScreen(),
        '/my_request': (context) => const RequestSentScreen(),
        '/change_password': (context) => const ChangePasswordScreen(),
      },
    );
  }
}
