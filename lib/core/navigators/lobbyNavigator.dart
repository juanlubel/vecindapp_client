import 'package:bloc/bloc.dart';
import 'package:vecinapp/screens/user/apartment.dart';
import 'package:vecinapp/screens/user/dashboard.dart';
import 'package:vecinapp/screens/user/profile.dart';

enum NavigationEvents {
  DashboardClickedEvent,
  ProfileClickedEvent,
  ApartmentClickedEvent,
}

abstract class NavigationStates {}

class NavigationUser extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => DashboardScreen();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.DashboardClickedEvent:
        yield DashboardScreen();
        break;
      case NavigationEvents.ProfileClickedEvent:
        yield ProfileScreen();
        break;
      case NavigationEvents.ApartmentClickedEvent:
        yield ApartmentScreen();
        break;
    }
  }
}