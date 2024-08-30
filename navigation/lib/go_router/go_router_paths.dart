import 'package:navigation/navigation.dart';

extension GoRouterPaths on GoRouterPages {
  String get screenPath {
    switch (this) {
      case GoRouterPages.splash:
        return "/";
      case GoRouterPages.welcome:
        return "/welcome";
      case GoRouterPages.authentication:
        return "/authentication";
      case GoRouterPages.login:
        return "/login";
      case GoRouterPages.register:
        return "/register";
      case GoRouterPages.profile_fill:
        return "/profile_fill";
      case GoRouterPages.home:
        return "home";
      case GoRouterPages.search:
        return "/search";
      default:
        return "/";
    }
  }
}