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

  // Access the .data property from the wrapper
  if (response?.data == null) {
    throw Exception('Failed to load profile data');
  }

  return response!.data!;
});

final currentCoursesProvider = FutureProvider.autoDispose<List<CourseCompact>>((ref) async {
  final api = ref.watch(studentApiProvider);
  final response = await api.studentCurrentCoursesGet();

  // Access .data and convert to list
  return response?.data?.toList() ?? [];
});

// ==========================================
// SCHEDULE (With 'scope' parameter)
// ==========================================

final scheduleProvider = FutureProvider.autoDispose.family<List<ClassSession>, String>((ref, scope) async {
  final api = ref.watch(studentApiProvider);
  final response = await api.studentScheduleGet(scope: scope);

  return response?.data?.toList() ?? [];
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