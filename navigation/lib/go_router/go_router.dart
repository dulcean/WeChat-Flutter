import 'package:navigation/navigation.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final _config = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
    GoRoute(
      name: GoRouterPages.splash.screenName,
      path: GoRouterPages.splash.screenPath,
      builder: (context, state) => const SizedBox(),
    )
  ],
);

GoRouter get config => _config;
