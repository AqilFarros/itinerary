import 'package:flutter/material.dart';
import 'package:itinerary/ui/page/page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => WelcomePage());
      case '/sign-in':
        return MaterialPageRoute(builder: (_) => SignInPage());
      case '/sign-up':
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/itinerary':
        return MaterialPageRoute(builder: (_) => ItineraryPage());
      case '/add-itinerary':
        return MaterialPageRoute(builder: (_) => AddIteneraryPage());
      case '/add-agenda':
        return MaterialPageRoute(builder: (_) => AddAgenda());
      case '/daily-routine':
        return MaterialPageRoute(builder: (_) => DailyRoutinePage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold();
      },
    );
  }
}
