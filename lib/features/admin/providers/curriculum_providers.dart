import 'package:flutter_riverpod/flutter_riverpod.dart';
// Alias the generated library
import 'package:admin_api/api.dart' as admin;
// Import your custom service
import '../../../core/services/api_service.dart';

// ==========================================
// 1. DATA FETCHING PROVIDERS (WITH DEBUGGING)
// ==========================================

// --- ACADEMICS ---

final departmentsProvider = FutureProvider.autoDispose<List<admin.Department>>((ref) async {
  print("🔄 [Departments] Fetching...");
  try {
    // UPDATED: Now returns a wrapper, access .data
    final result = await ApiService().academics.departmentsGet();
    print("✅ [Departments] Success: Found ${result?.data?.length ?? 0} items");
    return result?.data?.toList() ?? [];
  } catch (e) {
    print("🔴 [Departments] Error: $e");
    throw e;
  }
});

final programsProvider = FutureProvider.autoDispose<List<admin.Program>>((ref) async {
  print("🔄 [Programs] Fetching...");
  try {
    // UPDATED: No need for dynamic casting hacks anymore.
    // The generated client now correctly expects the wrapper object.
    final response = await ApiService().academics.programsGet();

    final list = response?.data?.toList() ?? [];
    print("✅ [Programs] Success: Found ${list.length} items");
    return list;
  } catch (e) {
    print("🔴 [Programs] Error: $e");
    throw e;
  }
});

final coursesProvider = FutureProvider.autoDispose<List<admin.Course>>((ref) async {
  print("🔄 [Courses] Fetching...");
  try {
    // UPDATED: Access .data
    final result = await ApiService().academics.coursesGet();
    print("✅ [Courses] Success: Found ${result?.data?.length ?? 0} items");
    return result?.data?.toList() ?? [];
  } catch (e) {
    print("🔴 [Courses] Error: $e");
    throw e;
  }
});

final qualificationsProvider = FutureProvider.autoDispose<List<admin.Qualification>>((ref) async {
  print("🔄 [Qualifications] Fetching...");
  try {
    // UPDATED: Access .data
    final result = await ApiService().academics.qualificationsGet();
    print("✅ [Qualifications] Success: Found ${result?.data?.length ?? 0} items");
    return result?.data?.toList() ?? [];
  } catch (e) {
    print("🔴 [Qualifications] Error: $e");
    throw e;
  }
});

// --- CURRICULUM (Program Specific) ---
final curriculumProvider = FutureProvider.family.autoDispose<List<admin.ProgramCourse>, String>((ref, programId) async {
  print("🔄 [Curriculum] Fetching for Program $programId...");
  try {
    // UPDATED: Access .data
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
    // UPDATED: Access .data
    final result = await ApiService().timetables.semestersGet();
    return result?.data?.toList() ?? [];
  } catch (e) {
    print("🔴 [Semesters] Error: $e");
    throw e;
  }
});

final activeSemesterProvider = FutureProvider.autoDispose<admin.Semester?>((ref) async {
  print("🔄 [Active Semester] Fetching...");
  try {
    // 1. Await the response (this returns SemesterResponse?)
    final response = await ApiService().timetables.semestersActiveGet();

    // 2. Extract the actual Semester model from the 'data' field
    // response is SemesterResponse, response.data is Semester
    final admin.Semester? semester = response?.data;

    if (semester == null) {
      print("ℹ️ [Active Semester] Successfully fetched, but no active semester found (data is null).");
      return null;
    }

    print("✅ [Active Semester] Parsed: ${semester.academicYear} - ${semester.semesterNumber}");
    return semester;
  } catch (e) {
    print("🔴 [Active Semester] Error: $e");
    return null;
  }
});

// --- EXAMS ---
final examSeasonsProvider = FutureProvider.autoDispose<List<dynamic>>((ref) async {
  // Placeholder until API endpoint exists
  return [];
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
      print("🚀 Adding Department: $name");
      final req = admin.DepartmentsPostRequest(name: name, code: code);
      await ApiService().academics.departmentsPost(req);
      ref.invalidate(departmentsProvider);
    });
  }

  Future<bool> addQualification(String name, String code) async {
    return _perform(() async {
      print("🚀 Adding Qualification: $name");
      // FIX: Used to be DepartmentsPostRequest, changed to QualificationsPostRequest
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
      print("🚀 Adding Program: $name");
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
      int semesterSeq,
      ) async {
    return _perform(() async {
      final req = admin.ProgramsCoursesPostRequest(
        coursePublicId: courseId,
        semesterSequence: semesterSeq,
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
    });
  }

  Future<dynamic> getPromotionPreview() async {
    try {
      final result = await ApiService().students.studentsPromotionPreview();
      // Note: Promotion Preview in spec is { eligible: [...], repeating: [...] }
      // The generator usually returns a specific object for this (e.g. StudentsPromotionPreview200Response)
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

  // --- EXAM ACTIONS ---

  Future<bool> addExamSeason(String name, String semesterId) async {
    return _perform(() async {
      final req = admin.ExamSeasonsPostRequest(
        name: name,
        semesterPublicId: semesterId,
      );
      await ApiService().exams.examSeasonsPost(req);
    });
  }
}