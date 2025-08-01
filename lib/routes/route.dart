import 'package:flutter/material.dart';
import 'package:itinerary/firebase/firebase.dart';
import 'package:itinerary/ui/page/page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => WelcomePage());
      case '/sign-in':
        return MaterialPageRoute(builder: (_) => SignInPage(auth: AuthService(),));
      case '/sign-up':
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/itinerary':
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          builder: (_) => ItineraryPage(
            id: args['id'],
            place: args['place'],
            type: args['type'],
            from: args['from'],
            to: args['to'],
            description: args['description'],
          ),
        );
      case '/add-itinerary':
        return MaterialPageRoute(builder: (_) => AddIteneraryPage());
      case '/add-agenda':
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          builder: (_) => AddAgenda(
            itineraryId: args['id'],
            startDate: args['startDate'],
            endDate: args['endDate'],
          ),
        );
      case '/daily-routine':
        return MaterialPageRoute(builder: (_) => DailyRoutinePage());
      case '/agenda':
        return MaterialPageRoute(builder: (_) => AgendaPage());
      case '/edit-itinerary':
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute<Map<String, dynamic>>(
          builder: (_) => EditIteneraryPage(
            id: args['id'],
            place: args['place'],
            type: args['type'],
            from: args['from'],
            to: args['to'],
            description: args['description'],
          ),
        );
      case '/edit-agenda':
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          builder: (_) => EditAgenda(
            itineraryId: args['itineraryId'],
            agendaId: args['agendaId'],
            name: args['name'],
            description: args['description'],
            type: args['type'],
            location: args['location'],
            date: args['date'],
            fromDate: args['fromDate'],
            toDate: args['toDate'],
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
