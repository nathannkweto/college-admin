import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:college_admin/core/services/api_service.dart';
// Ensure this points to your generated Lecturer API package
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

// --- 3. Assigned Courses List Provider ---
final lecturerCoursesProvider = FutureProvider<List<CourseAssignment>>((ref) async {
  final api = ApiService().lecturer;
  final response = await api.lecturerCoursesGet();

  if (response == null || response.data == null) {
    throw Exception("Failed to load assigned courses");
  }
  return response.data!;
});

// --- 4. Course Details & Student List Provider ---
final lecturerCourseDetailsProvider = FutureProvider.family<CourseCohortDetails, String>((ref, coursePublicId) async {
  final api = ApiService().lecturer;

  // This call now returns the object containing 'programCourseId' (int) and 'context.semester'
  final response = await api.lecturerCourseDetailsGet(coursePublicId);

  if (response == null) {
    throw Exception("Failed to load course details for $coursePublicId");
  }
  return response;
});

// --- 5. Grading Action Service ---
final gradingActionProvider = Provider((ref) {
  final api = ApiService().lecturer;

  return (String coursePublicId, GradeSubmissionBatch batch) async {
    try {
      // POST /courses/{course_public_id}/grades
      // We still use the UUID for the URL, but the 'batch' body now contains the Integer ID
      await api.lecturerGradesPost(coursePublicId, batch);

      // Invalidate the provider so the UI updates with the new "currentGrade" from server
      ref.invalidate(lecturerCourseDetailsProvider(coursePublicId));

      return true;
    } catch (e) {
      print("Grading Submission Error: $e");
      rethrow;
    }
  };
});

// --- 6. Helper State for Navigation ---
final selectedCourseIdProvider = StateProvider<String?>((ref) => null);