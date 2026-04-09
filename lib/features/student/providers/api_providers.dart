import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_api/api.dart';
import 'package:college_admin/core/services/api_service.dart';

// 1. Provider to access the Student API instance
final studentApiProvider = Provider<DefaultApi>((ref) {
  return ApiService().student;
});

// ==========================================
// DASHBOARD & PROFILE
// ==========================================

final studentProfileProvider = FutureProvider.autoDispose<StudentProfile>((ref) async {
  final api = ref.watch(studentApiProvider);
  final response = await api.studentProfileGet();

  if (response?.data == null) {
    throw Exception('Failed to load profile data');
  }

  return response!.data!;
});

final currentCoursesProvider = FutureProvider.autoDispose<List<CourseCompact>>((ref) async {
  final api = ref.watch(studentApiProvider);
  final response = await api.studentCurrentCoursesGet();

  return response?.data?.toList() ?? [];
});

// ==========================================
// SCHEDULE (Updated for Weekly View)
// ==========================================

final studentScheduleProvider = FutureProvider.autoDispose<List<DailySchedule>>((ref) async {
  final api = ref.watch(studentApiProvider);

  // Calls the updated endpoint returning the weekly view
  final response = await api.studentScheduleGet();

  if (response == null || response.data == null) {
    return [];
  }

  return response.data!.toList();
});

// ==========================================
// ACADEMICS
// ==========================================

final curriculumProvider = FutureProvider.autoDispose<CurriculumProgress>((ref) async {
  final api = ref.watch(studentApiProvider);
  final response = await api.studentCurriculumGet();

  if (response?.data == null) {
    throw Exception('Curriculum data unavailable');
  }

  return response!.data!;
});

final upcomingExamsProvider = FutureProvider.autoDispose<List<ExamEvent>>((ref) async {
  final api = ref.watch(studentApiProvider);
  final response = await api.studentExamsGet();

  return response?.data?.toList() ?? [];
});

final transcriptProvider = FutureProvider.autoDispose<Transcript>((ref) async {
  final api = ref.watch(studentApiProvider);
  // Returns { data: { semesters: [...] } }
  final response = await api.studentResultsGet();

  if (response?.data == null) {
    throw Exception('Transcript unavailable');
  }

  return response!.data!;
});

// ==========================================
// FINANCE
// ==========================================

final financeProvider = FutureProvider.autoDispose<StudentFinance>((ref) async {
  final api = ref.watch(studentApiProvider);
  final response = await api.studentFinanceGet();

  if (response?.data == null) {
    throw Exception('Finance data unavailable');
  }

  return response!.data!;
});