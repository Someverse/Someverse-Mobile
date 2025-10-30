import 'package:flutter/material.dart';
import '../../../../core/design_system/design_system.dart';

/// 소셜 로그인 버튼
class SocialLoginButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color backgroundColor;
  final Widget icon;
  final String label;
  final Color textColor;

  const SocialLoginButton({
    super.key,
    required this.onTap,
    required this.backgroundColor,
    required this.icon,
    required this.label,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 12),
            Text(
              label,
              style: AppTextStyles.socialLoginButton.copyWith(
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
