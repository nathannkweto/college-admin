import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:college_admin/core/services/api_service.dart';
// Ensure this points to your generated Lecturer API package
import 'package:lecturer_api/api.dart';

// --- 1. Basic Profile Provider ---
final lecturerProfileProvider = FutureProvider<LecturerProfile>((ref) async {
  final api = ApiService().lecturer;

  // The call returns the wrapper class: LecturerProfileGet200Response
  final response = await api.lecturerProfileGet();

  if (response == null || response.data == null) {
    throw Exception("Failed to load lecturer profile");
  }

  // Return the actual model stored inside the 'data' property
  return response.data!;
});

// --- 2. Weekly Schedule Provider ---
final lecturerScheduleProvider = FutureProvider<List<DailySchedule>>((ref) async {
  final api = ApiService().lecturer;

  // The API returns an object with a 'data' property which is a List<DailySchedule>
  final response = await api.lecturerScheduleGet();

  if (response == null || response.data == null) {
    throw Exception("Failed to load schedule");
  }

  // We return the inner list of DailySchedule objects
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
      await api.lecturerGradesPost(coursePublicId, batch);

      // CRITICAL: Invalidate the provider so that when the user returns
      // to the page, the "currentGrade" values are updated from the server.
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