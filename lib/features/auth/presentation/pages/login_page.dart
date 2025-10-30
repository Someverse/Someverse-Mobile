import 'package:flutter/material.dart';
import '../../../../core/design_system/design_system.dart';
import '../widgets/social_login_button.dart';

/// 로그인 화면
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 로고
                Image.asset('assets/images/logo.webp', width: 70, height: 70),
                const SizedBox(height: 20),
                // SOMEVERSE 브랜드명
                Text(
                  'SOMEVERSE',
                  style: AppTextStyles.brandName.copyWith(
                    color: AppColors.brandText,
                  ),
                ),
                const SizedBox(height: 20),
                // 메인 타이틀
                Text(
                  '당신의 취향이\n연결의 시작',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.loginMainTitle,
                ),
                const SizedBox(height: 13),
                // 부제목
                Text(
                  '콘텐츠 취향을 함께 나눌 친구를 만나세요.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.loginSubtitle.copyWith(
                    color: AppColors.gray,
                  ),
                ),
                const SizedBox(height: 30),
                // Placeholder 영역
                Container(
                  width: double.infinity,
                  height: 88,
                  decoration: BoxDecoration(
                    color: AppColors.placeholderGray,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                const SizedBox(height: 40),
                // 카카오 로그인 버튼
                SocialLoginButton(
                  onTap: () {
                    // TODO: 카카오 로그인 구현
                  },
                  backgroundColor: AppColors.kakaoYellow,
                  icon: SizedBox(
                    width: 20,
                    height: 20,
                    child: Image.asset('assets/images/kakao.webp'),
                  ),
                  label: '카카오 로그인',
                  textColor: AppColors.black,
                ),
                const SizedBox(height: 20),
                // Apple 로그인 버튼
                SocialLoginButton(
                  onTap: () {
                    // TODO: Apple 로그인 구현
                  },
                  backgroundColor: AppColors.appleGray,
                  icon: SizedBox(
                    width: 16,
                    height: 20,
                    child: Image.asset('assets/images/apple.webp'),
                  ),
                  label: '애플 로그인',
                  textColor: AppColors.black,
                ),
                const SizedBox(height: 66),
                // 법적 텍스트
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: '시작하면\n',
                    style: AppTextStyles.legalText.copyWith(
                      color: AppColors.descGray,
                    ),
                    children: [
                      TextSpan(
                        text: '서비스 이용약관, 개인정보 처리방침, 위치정보, 이용약관에\n',
                        style: AppTextStyles.legalText.copyWith(
                          color: AppColors.descGray,
                        ),
                      ),
                      const TextSpan(
                        text: '동의하게 됩니다.',
                        style: AppTextStyles.legalText,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // 사업자 정보
                GestureDetector(
                  onTap: () {
                    // TODO: 사업자 정보 표시
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '사업자 정보',
                        style: AppTextStyles.businessInfo.copyWith(
                          color: AppColors.descGray,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.chevron_right,
                        size: 12,
                        color: AppColors.descGray,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
