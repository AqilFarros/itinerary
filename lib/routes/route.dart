import 'package:flutter/material.dart';
import 'package:itinerary/ui/page/page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>? ?? {};
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
        return MaterialPageRoute(
          builder: (_) => AddAgenda(itineraryId: settings.arguments as String),
        );
      case '/daily-routine':
        return MaterialPageRoute(builder: (_) => DailyRoutinePage());
      case '/edit-itinerary':
        return MaterialPageRoute(
          builder: (_) => EditIteneraryPage(
            id: args['id'],
            name: args['name'],
            type: args['type'],
            from: args['from'],
            to: args['to'],
            description: args['description'],
          ),
        );
      case '/edit-agenda':
        return MaterialPageRoute(
          builder: (_) => EditAgenda(
            itineraryId: args['itineraryId'],
            agendaId: args['agendaId'],
            name: args['name'],
            description: args['description'],
            type: args['type'],
            location: args['location'],
            date: args['date'],
          ),
        );
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
