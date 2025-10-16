import 'package:someverse/features/auth/domain/entities/movie_category.dart';
import 'package:someverse/features/auth/domain/entities/movie_content.dart';
import 'package:someverse/features/auth/domain/entities/region.dart';
import 'package:someverse/features/auth/domain/entities/user.dart';

/// 온보딩 관련 비즈니스 로직을 처리하는 Repository 인터페이스
///
/// 취향 선택, 프로필 설정 등 온보딩 과정에서 필요한 기능을 제공합니다.
abstract class OnboardingRepository {
  /// 사용 가능한 영화 카테고리 목록을 가져옵니다.
  Future<List<MovieCategory>> getMovieCategories();

  /// 특정 카테고리에 속한 영화 목록을 가져옵니다.
  ///
  /// Parameters:
  /// - categoryIds: 조회할 카테고리 ID 목록
  /// - page: 페이지 번호 (기본값: 1)
  /// - pageSize: 페이지당 아이템 수 (기본값: 10)
  Future<List<MovieContent>> getMoviesByCategories(
    List<String> categoryIds, {
    int page = 1,
    int pageSize = 10,
  });

  /// 영화를 검색합니다.
  ///
  /// Parameters:
  /// - query: 검색어
  /// - page: 페이지 번호 (기본값: 1)
  /// - pageSize: 페이지당 아이템 수 (기본값: 10)
  Future<List<MovieContent>> searchMovies(
    String query, {
    int page = 1,
    int pageSize = 10,
  });

  /// 사용 가능한 활동 지역 목록을 가져옵니다.
  Future<List<Region>> getRegions();

  /// 프로필 이미지를 업로드합니다.
  ///
  /// Parameters:
  /// - imagePath: 업로드할 이미지 파일 경로
  ///
  /// Returns:
  /// - 업로드된 이미지의 URL
  Future<String> uploadProfileImage(String imagePath);

  /// 온보딩 정보를 서버에 제출하고 사용자 프로필을 업데이트합니다.
  ///
  /// Parameters:
  /// - nickname: 사용자 닉네임 (한글 2-8자)
  /// - gender: 성별
  /// - birthDate: 생년월일
  /// - activeRegionIds: 활동 지역 ID 목록 (최소 1개, 최대 2개)
  /// - profileImageUrls: 프로필 이미지 URL 목록 (최소 1장, 최대 6장)
  /// - preferredMovieCategoryIds: 선호 영화 카테고리 ID 목록 (최대 5개)
  /// - preferredMovieIds: 선호 영화 ID 목록 (최소 5개)
  ///
  /// Returns:
  /// - 업데이트된 사용자 정보
  Future<User> submitOnboardingData({
    required String nickname,
    required Gender gender,
    required DateTime birthDate,
    required List<String> activeRegionIds,
    required List<String> profileImageUrls,
    required List<String> preferredMovieCategoryIds,
    required List<String> preferredMovieIds,
  });

  /// 닉네임 중복 여부를 확인합니다.
  ///
  /// Parameters:
  /// - nickname: 확인할 닉네임
  ///
  /// Returns:
  /// - 사용 가능하면 true, 중복이면 false
  Future<bool> checkNicknameAvailability(String nickname);
}