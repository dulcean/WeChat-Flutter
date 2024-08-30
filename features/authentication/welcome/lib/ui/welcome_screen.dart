import 'package:welcome/welcome.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.themeData!.scaffoldBackgroundColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: linearGradient,
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Lottie.asset(
                  Assets.lottie.bow,
                  width: Dimensions.size_300,
                  height: Dimensions.size_300,
                ),
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: Dimensions.size_80),
                child: Text(
                  WelcomeConstants.text,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bold24,
                )),
            const SizedBox(
              height: Dimensions.size_40,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Dimensions.size_16),
              child: AppButton(
                onTap: () {
                  config.pushNamed(GoRouterPages.register.screenName);
                },
                text: WelcomeConstants.next,
              ),
            ),
            const SizedBox(
              height: Dimensions.size_100,
            ),
          ],
        ),
      ),
    );
  }
}
