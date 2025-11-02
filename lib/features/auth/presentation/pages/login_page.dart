import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/design_system.dart';
import '../providers/auth_providers.dart';
import '../widgets/social_login_button.dart';

/// 로그인 화면
class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                Consumer(
                  builder: (context, ref, _) {
                    final kakaoLogin = ref.watch(kakaoLoginProvider.notifier);
                    final kakaoLoginState = ref.watch(kakaoLoginProvider);

                    // 로그인 상태 변경을 감지하여 성공 시 홈으로 이동
                    ref.listen<AsyncValue<void>>(
                      kakaoLoginProvider,
                      (previous, next) {
                        // 에러 발생 시 스낵바 표시 (에러는 먼저 처리)
                        if (next.hasError) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('로그인 실패: ${next.error.toString()}'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                          return; // 에러 시에는 홈으로 이동하지 않음
                        }
                        
                        // 로그인 성공: 이전 상태가 로딩이었고, 현재 상태가 에러 없이 완료된 경우
                        if (previous?.isLoading == true && 
                            next.hasValue && 
                            !next.hasError) {
                          if (context.mounted) {
                            context.go('/home');
                          }
                        }
                      },
                    );

                    return SocialLoginButton(
                      onTap: kakaoLoginState.isLoading
                          ? () {} // 로딩 중일 때는 빈 함수
                          : () {
                              kakaoLogin.login();
                            },
                      backgroundColor: AppColors.kakaoYellow,
                      icon: SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset('assets/images/kakao.webp'),
                      ),
                      label: kakaoLoginState.isLoading
                          ? '로그인 중...'
                          : '카카오 로그인',
                      textColor: AppColors.black,
                    );
                  },
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
