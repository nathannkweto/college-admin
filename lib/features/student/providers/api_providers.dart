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
  // The 'response' IS the profile
  final profile = await api.studentProfileGet();

  if (profile == null) {
    throw Exception('Failed to load profile data');
  }

  return profile; // Return directly
});

final currentCoursesProvider = FutureProvider.autoDispose<List<CourseCompact>>((ref) async {
  final api = ref.watch(studentApiProvider);
  final courses = await api.studentCurrentCoursesGet();

  if (courses == null) {
    return [];
  }

  return courses.toList();
});

// ==========================================
// SCHEDULE (With 'scope' parameter)
// ==========================================

final scheduleProvider = FutureProvider.autoDispose.family<List<ClassSession>, String>((ref, scope) async {
  final api = ref.watch(studentApiProvider);
  final sessionList = await api.studentScheduleGet(scope: scope);

  if (sessionList == null) {
    return [];
  }

  return sessionList.toList();
});

// ==========================================
// ACADEMICS
// ==========================================

final curriculumProvider = FutureProvider.autoDispose<CurriculumProgress>((ref) async {
  final api = ref.watch(studentApiProvider);
  final progress = await api.studentCurriculumGet();

  if (progress == null) {
    throw Exception('Curriculum data unavailable');
  }

  return progress;
});

final upcomingExamsProvider = FutureProvider.autoDispose<List<ExamEvent>>((ref) async {
  final api = ref.watch(studentApiProvider);
  final exams = await api.studentExamsGet();

  if (exams == null) {
    return [];
  }

  return exams.toList();
});

final transcriptProvider = FutureProvider.autoDispose<Transcript>((ref) async {
  final api = ref.watch(studentApiProvider);
  final transcript = await api.studentResultsGet();

  if (transcript == null) {
    throw Exception('Transcript unavailable');
  }

  return transcript;
});

// ==========================================
// FINANCE
// ==========================================

final financeProvider = FutureProvider.autoDispose<StudentFinance>((ref) async {
  final api = ref.watch(studentApiProvider);
  final finance = await api.studentFinanceGet();

  if (finance == null) {
    throw Exception('Finance data unavailable');
  }

  return finance;
});