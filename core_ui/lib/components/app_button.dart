import 'package:core_ui/core_ui.dart';

class AppButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const AppButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.size_16),
        decoration: BoxDecoration(
          color: AppTheme.themeData!.primaryColor,
          borderRadius: BorderRadius.circular(Dimensions.size_32),
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyles.button24,
          ),
        ),
      ),
    );
  }
}
