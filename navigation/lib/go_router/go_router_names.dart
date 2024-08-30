import 'package:navigation/navigation.dart';

extension GoRouterNames on GoRouterPages {
  String get screenName {
    switch (this) {
      case GoRouterPages.splash:
        return 'splash';
      case GoRouterPages.welcome:
        return 'welcome';
      case GoRouterPages.authentication:
        return 'authentication';
      case GoRouterPages.login:
        return 'login';
      case GoRouterPages.register:
        return 'register';
      case GoRouterPages.profile_fill:
        return 'profile_fill';
      case GoRouterPages.home:
        return 'home';
      case GoRouterPages.search:
        return 'search';
      default:
        return 'splash';
    }
  }
}
