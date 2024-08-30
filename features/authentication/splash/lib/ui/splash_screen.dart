import 'package:splash/splash.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(milliseconds: SplashConstants.duration),
    );
    config.go(GoRouterPages.authentication.screenPath);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppTheme.themeData?.primaryColor,
        ),
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.images.background.path),
              fit: BoxFit.cover,
            ),
          ),
        ),
        AnimatedSplashScreen(
          splash: LottieBuilder.asset(
            Assets.lottie.logoAnimation,
            width: Dimensions.size_400,
            height: Dimensions.size_400,
          ),
          backgroundColor: Colors.transparent,
          nextScreen: Container(),
          duration: SplashConstants.duration,
        ),
      ],
    );
  }
}
