import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:college_admin/core/services/api_service.dart';
import 'package:lecturer_api/api.dart';

// --- 1. Basic Profile Provider ---
final lecturerProfileProvider = FutureProvider<LecturerProfile>((ref) async {
  final api = ApiService().lecturer;
  final response = await api.lecturerProfileGet();

  if (response == null || response.data == null) {
    throw Exception("Failed to load lecturer profile");
  }
  return response.data!;
});

// --- 2. Weekly Schedule Provider ---
final lecturerScheduleProvider = FutureProvider<List<DailySchedule>>((ref) async {
  final api = ApiService().lecturer;
  final response = await api.lecturerScheduleGet();

  if (response == null || response.data == null) {
    throw Exception("Failed to load schedule");
  }
  return response.data!;
});

// --- 3. Detailed Courses Provider ---
final lecturerCoursesProvider = FutureProvider<List<CourseDetail>>((ref) async {
  final api = ApiService().lecturer;
  final response = await api.lecturerCoursesGet();

  if (response == null || response.data == null) {
    throw Exception("Failed to load assigned courses");
  }
  return response.data!;
});

// --- 4. Dashboard Course Summary Provider ---
final lecturerCoursesSummaryProvider = FutureProvider<List<CourseSummary>>((ref) async {
  final api = ApiService().lecturer;
  final response = await api.lecturerCoursesSummaryGet();

  if (response == null || response.data == null) {
    throw Exception("Failed to load course summary");
  }
  return response.data!;
});

// --- 5. Course Students (Grading) Provider ---
// We use family here because we need to pass the course ID
final lecturerCourseStudentsProvider = FutureProvider.family<List<StudentGradeRecord>, String>((ref, courseId) async {
  final api = ApiService().lecturer;
  final response = await api.lecturerCourseStudentsGet(courseId);

  if (response == null || response.data == null) {
    throw Exception("Failed to load students for this course");
  }
  return response.data!;
});

// --- 6. Grading Action Provider (Not a FutureProvider) ---
// This provides a function to submit grades
final gradingServiceProvider = Provider((ref) {
  final api = ApiService().lecturer;

  return (String courseId, GradeSubmission submission) async {
    final response = await api.lecturerGradesPost(courseId, submission);
    // Refresh the student list after submission to show updated scores
    ref.invalidate(lecturerCourseStudentsProvider(courseId));
    return response;
  };
});

final selectedCourseIdProvider = StateProvider<String?>((ref) => null);