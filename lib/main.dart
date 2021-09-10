import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stay_home_polls_app/login_flow/auth_state_switch.dart';
import 'package:stay_home_polls_app/pages/home_page.dart';

void main() => runApp(
      AppConstants(
        font: GoogleFonts.getFont('Nunito'),
        textTheme: GoogleFonts.getTextTheme('Nunito'),
        child: const AuthStateSwitch(app: StayHomePollsApp()),
      ),
    );

class AppConstants extends InheritedWidget {
  final TextStyle font;
  final TextTheme textTheme;

  const AppConstants({
    Key key,
    @required this.font,
    @required this.textTheme,
    Widget child,
  })  : assert(font != null, textTheme != null),
        super(key: key, child: child);

  static AppConstants of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppConstants>();

  @override
  bool updateShouldNotify(covariant AppConstants oldWidget) => false;
}

class StayHomePollsApp extends StatelessWidget {
  const StayHomePollsApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'Stay Home Polls';

    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        colorScheme: const ColorScheme.light(
          secondary: Colors.orangeAccent,
        ),
        textTheme: AppConstants.of(context).textTheme,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(title: title),
    );
  }
}
