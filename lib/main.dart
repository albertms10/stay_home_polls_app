import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stay_home_polls_app/login_flow/auth_state_switch.dart';
import 'package:stay_home_polls_app/pages/home_page.dart';

void main() => runApp(
      AppConstants(
        font: GoogleFonts.getFont('Nunito'),
        textTheme: GoogleFonts.getTextTheme('Nunito'),
        child: AuthStateSwitch(StayHomePollsApp()),
      ),
    );

class AppConstants extends InheritedWidget {
  static AppConstants of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppConstants>();

  const AppConstants({
    @required this.font,
    @required this.textTheme,
    Widget child,
    Key key,
  })  : assert(font != null, textTheme != null),
        super(key: key, child: child);

  final TextStyle font;
  final TextTheme textTheme;

  @override
  bool updateShouldNotify(AppConstants oldWidget) => false;
}

class StayHomePollsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const title = 'Stay Home Polls';

    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.orangeAccent,
        textTheme: AppConstants.of(context).textTheme,
      ),
      home: HomePage(title: title),
    );
  }
}
