import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/home_tab_page.dart';

/// 앱의 라우팅 설정
final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  // TODO: 로그인 상태에 따른 라우트 추가
  errorBuilder: (context, state) {
    // Deep Link 파싱 에러(커스텀 스킴) 시 로그인 페이지로
    // 에러는 무시하고 정상적으로 로그인 페이지를 표시
    return const LoginPage();
  },
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeTabPage(),
    ),
  ],
);
