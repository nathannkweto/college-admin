import 'package:flutter_riverpod/flutter_riverpod.dart';
// Alias the generated library
import 'package:admin_api/api.dart' as admin;
// Import your custom service
import '../../../core/services/api_service.dart';

// ==========================================
// 1. DATA FETCHING PROVIDERS
// ==========================================

// --- ACADEMICS ---

final departmentsProvider = FutureProvider.autoDispose<List<admin.Department>>((ref) async {
  try {
    final result = await ApiService().academics.departmentsGet();
    return result?.data?.toList() ?? [];
  } catch (e) {
    print("🔴 [Departments] Error: $e");
    throw e;
  }
});

final programsProvider = FutureProvider.autoDispose<List<admin.Program>>((ref) async {
  try {
    final response = await ApiService().academics.programsGet();
    return response?.data?.toList() ?? [];
  } catch (e) {
    print("🔴 [Programs] Error: $e");
    throw e;
  }
});

final coursesProvider = FutureProvider.autoDispose<List<admin.Course>>((ref) async {
  try {
    final result = await ApiService().academics.coursesGet();
    return result?.data?.toList() ?? [];
  } catch (e) {
    print("🔴 [Courses] Error: $e");
    throw e;
  }
});

final qualificationsProvider = FutureProvider.autoDispose<List<admin.Qualification>>((ref) async {
  try {
    final result = await ApiService().academics.qualificationsGet();
    return result?.data?.toList() ?? [];
  } catch (e) {
    print("🔴 [Qualifications] Error: $e");
    throw e;
  }
});

final lecturersProvider = FutureProvider.autoDispose<List<admin.Lecturer>>((ref) async {
  try {
    final result = await ApiService().lecturers.lecturersGet();
    return result?.data?.toList() ?? [];
  } catch (e) {
    print("🔴 [Lecturers] Error: $e");
    throw e;
  }
});

// --- CURRICULUM (Program Specific) ---
final curriculumProvider = FutureProvider.family.autoDispose<List<admin.ProgramCourse>, String>((ref, programId) async {
  try {
    final result = await ApiService().academics.programsCoursesGet(programId);
    return result?.data?.toList() ?? [];
  } catch (e) {
    print("🔴 [Curriculum] Error: $e");
    throw e;
  }
});

// --- TIMETABLES & SEMESTERS ---

final semestersProvider = FutureProvider.autoDispose<List<admin.Semester>>((ref) async {
  try {
    final result = await ApiService().timetables.semestersGet();
    return result?.data?.toList() ?? [];
  } catch (e) {
    print("🔴 [Semesters] Error: $e");
    throw e;
  }
});

final activeSemesterProvider = FutureProvider.autoDispose<admin.Semester?>((ref) async {
  try {
    final response = await ApiService().timetables.semestersActiveGet();
    return response?.data;
  } catch (e) {
    print("🔴 [Active Semester] Error: $e");
    return null;
  }
});

// --- EXAMS (SEASONS) ---

// 1. Provider for the single Active Exam Season (if any)
final activeExamSeasonProvider = FutureProvider.autoDispose<admin.ExamSeason?>((ref) async {
  try {
    final response = await ApiService().exams.examSeasonsActive();
    return response?.data;
  } catch (e) {
    // It is common to not have an active season, so we just return null
    return null;
  }
});

// 2. Provider for All Exam Seasons (History)
final examSeasonsProvider = FutureProvider.autoDispose<List<admin.ExamSeason>>((ref) async {
  try {
    final result = await ApiService().exams.examSeasonsList();
    return result?.data?.toList() ?? [];
  } catch (e) {
    print("🔴 [Exam Seasons] Error: $e");
    return [];
  }
});


// ==========================================
// 2. ACTION CONTROLLER
// ==========================================

final curriculumControllerProvider =
StateNotifierProvider<CurriculumController, AsyncValue<void>>((ref) {
  return CurriculumController(ref);
});

class CurriculumController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  CurriculumController(this.ref) : super(const AsyncValue.data(null));

  // --- HELPER: Handles Loading & Error States ---
  Future<bool> _perform(Future<void> Function() action) async {
    state = const AsyncValue.loading();
    try {
      await action();
      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      if (e is admin.ApiException) {
        print('🔴 API ERROR ${e.code}: ${e.message}');
      } else {
        print('🔴 GENERIC ERROR: $e');
      }
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  // --- ACADEMIC ACTIONS ---

  Future<bool> addDepartment(String name, String code) async {
    return _perform(() async {
      final req = admin.DepartmentsPostRequest(name: name, code: code);
      await ApiService().academics.departmentsPost(req);
      ref.invalidate(departmentsProvider);
    });
  }

  Future<bool> addQualification(String name, String code) async {
    return _perform(() async {
      final req = admin.DepartmentsPostRequest(name: name, code: code);
      await ApiService().academics.qualificationsPost(req);
      ref.invalidate(qualificationsProvider);
    });
  }

  Future<bool> addProgram({
    required String name,
    required String code,
    required String deptId,
    required String qualId,
    required int semesters,
  }) async {
    return _perform(() async {
      final req = admin.ProgramsPostRequest(
        name: name,
        code: code,
        departmentPublicId: deptId,
        qualificationPublicId: qualId,
        totalSemesters: semesters,
      );
      await ApiService().academics.programsPost(req);
      ref.invalidate(programsProvider);
    });
  }

  Future<bool> addCourse(String name, String code, String deptId) async {
    return _perform(() async {
      final req = admin.CoursesPostRequest(
        name: name,
        code: code,
        departmentPublicId: deptId,
      );
      await ApiService().academics.coursesPost(req);
      ref.invalidate(coursesProvider);
    });
  }

  Future<bool> addCourseToSemester(
      String programId,
      String courseId,
      int semesterSeq, {
        String? lecturerId,
      }) async {
    return _perform(() async {
      final req = admin.ProgramsCoursesPostRequest(
        coursePublicId: courseId,
        semesterSequence: semesterSeq,
        lecturerPublicId: lecturerId,
      );
      await ApiService().academics.programsCoursesPost(programId, req);
      ref.invalidate(curriculumProvider(programId));
    });
  }

  Future<bool> removeCourseFromProgram(String programId, String courseId) async {
    return _perform(() async {
      await ApiService().academics.programsCoursesDelete(programId, courseId);
      ref.invalidate(curriculumProvider(programId));
    });
  }

  // --- SEMESTER & PROMOTION ACTIONS ---

  Future<bool> addSemester(
      String year,
      int number,
      int weeks,
      DateTime startDate,
      ) async {
    return _perform(() async {
      final req = admin.SemestersPostRequest(
        academicYear: year,
        semesterNumber: number,
        lengthWeeks: weeks,
        startDate: DateTime(startDate.year, startDate.month, startDate.day),
      );

      await ApiService().timetables.semestersPost(req);
      ref.invalidate(semestersProvider);
      ref.invalidate(activeSemesterProvider);
    });
  }

  Future<bool> endSemester(String semesterId) async {
    return _perform(() async {
      await ApiService().timetables.semesterEndPost(semesterId);
      ref.invalidate(semestersProvider);
      ref.invalidate(activeSemesterProvider);
      ref.invalidate(activeExamSeasonProvider);
    });
  }

  Future<dynamic> getPromotionPreview() async {
    try {
      final result = await ApiService().students.studentsPromotionPreview();
      return result;
    } catch (e) {
      print("Error fetching promotion preview: $e");
      return null;
    }
  }

  Future<bool> executePromotion({List<String>? excludeStudentIds}) async {
    return _perform(() async {
      final req = admin.StudentsPromotePostRequest(
        excludeStudentIds: excludeStudentIds ?? [],
      );
      await ApiService().students.studentsPromotePost(req);
      ref.invalidate(semestersProvider);
      ref.invalidate(activeSemesterProvider);
    });
  }

  // --- EXAM SEASONS ACTIONS ---

  Future<bool> addExamSeason(String name, String semesterId) async {
    return _perform(() async {
      final req = admin.ExamSeasonsPostRequest(
        name: name,
        semesterPublicId: semesterId,
      );
      await ApiService().exams.examSeasonsPost(req);

      ref.invalidate(examSeasonsProvider);
      ref.invalidate(activeExamSeasonProvider);
      ref.invalidate(activeSemesterProvider);
    });
  }

  Future<bool> endExamSession(String seasonPublicId) async {
    return _perform(() async {
      await ApiService().exams.examSeasonsEnd(seasonPublicId);

      ref.invalidate(examSeasonsProvider);
      ref.invalidate(activeExamSeasonProvider);
      ref.invalidate(activeSemesterProvider);
    });
  }

  // --- EXAM SCHEDULING ACTIONS (Moved Inside Class) ---

  // Fetch existing schedules for a specific program & season
  Future<List<admin.ExamPaper>> fetchExamSchedules(
      String programId, String seasonId) async {
    try {
      // Note: Using named parameters as is standard for generated query params
      final result = await ApiService().exams.examSchedulesList(
        programId,
        seasonId,
      );
      return result?.data?.toList() ?? [];
    } catch (e) {
      print("🔴 [Exam Schedules] Error: $e");
      return [];
    }
  }

  // Schedule (or update) a specific exam
  Future<bool> scheduleExam({
    required String seasonId,
    required String programId,
    required String courseId,
    required String date, // "YYYY-MM-DD"
    required String startTime, // "HH:MM"
    required int duration,
    required String location,
  }) async {
    return _perform(() async {
      final req = admin.ExamPaperRequest(
        seasonPublicId: seasonId,
        programPublicId: programId,
        coursePublicId: courseId,
        date: DateTime.parse(date),
        startTime: startTime,
        durationMinutes: duration,
        location: location,
      );

      await ApiService().exams.examSchedulesPost(req);
      // No specific provider to invalidate unless we cache schedules globally,
      // but the UI calling this usually updates its local state or refetches.
    });
  }
}