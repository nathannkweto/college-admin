import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http; // Needed for MultipartFile

// Alias the generated library
import 'package:admin_api/api.dart' as admin;

// Import your custom service
import '../../../core/services/api_service.dart';

// --- STATE CLASS ---
class AddLecturerState {
  final bool isLoading;
  final String? error;
  final String? successMessage;

  AddLecturerState({this.isLoading = false, this.error, this.successMessage});
}

// --- PROVIDERS ---

// 1. Fetch Departments (For the Dropdown)
final departmentsProvider = FutureProvider.autoDispose<List<admin.Department>>((
    ref,
    ) async {
  try {
    // The spec now returns an object { "data": [...] }
    final response = await ApiService().academics.departmentsGet();

    // UPDATED: We must access the .data property
    return response?.data ?? [];
  } catch (e) {
    print("Error fetching departments: $e");
    return [];
  }
});

// 2. Controller
final addLecturerControllerProvider =
StateNotifierProvider.autoDispose<AddLecturerController, AddLecturerState>((
    ref,
    ) {
  return AddLecturerController();
});

class AddLecturerController extends StateNotifier<AddLecturerState> {
  AddLecturerController() : super(AddLecturerState());

  // A. Register Single Lecturer
  Future<bool> registerLecturer({
    required String firstName,
    required String lastName,
    required String email,
    required String departmentPublicId,
    required String title, // 'Mr', 'Dr', 'Prof'
    required String gender, // 'M' or 'F'
    // --- NEW REQUIRED FIELDS ---
    required String nationalId,
    required DateTime dob,
    required String address,
    required String phone,
  }) async {
    state = AddLecturerState(isLoading: true);

    try {
      // 1. Map String Title to Enum
      admin.LecturersPostRequestTitleEnum titleEnum;
      switch (title) {
        case 'Mr':
          titleEnum = admin.LecturersPostRequestTitleEnum.mr;
          break;
        case 'Ms':
          titleEnum = admin.LecturersPostRequestTitleEnum.ms;
          break;
        case 'Mrs':
          titleEnum = admin.LecturersPostRequestTitleEnum.mrs;
          break;
        case 'Dr':
          titleEnum = admin.LecturersPostRequestTitleEnum.dr;
          break;
        case 'Prof':
          titleEnum = admin.LecturersPostRequestTitleEnum.prof;
          break;
        default:
          titleEnum = admin.LecturersPostRequestTitleEnum.mr;
      }

      // 2. Map String Gender to Enum
      admin.LecturersPostRequestGenderEnum genderEnum;
      switch (gender) {
        case 'M':
          genderEnum = admin.LecturersPostRequestGenderEnum.M;
          break;
        case 'F':
          genderEnum = admin.LecturersPostRequestGenderEnum.F;
          break;
        default:
          genderEnum = admin.LecturersPostRequestGenderEnum.M;
      }

      // 3. Create Request Object
      final request = admin.LecturersPostRequest(
        firstName: firstName,
        lastName: lastName,
        email: email,
        departmentPublicId: departmentPublicId,
        title: titleEnum,
        gender: genderEnum,
        nationalId: nationalId,
        dob: dob,
        address: address,
        phone: phone,
      );

      // 4. Call API
      await ApiService().lecturers.lecturersPost(request);

      state = AddLecturerState(
        isLoading: false,
        successMessage: "Lecturer registered successfully",
      );
      return true;
    } catch (e) {
      state = AddLecturerState(
        isLoading: false,
        error: e.toString().replaceAll("Exception:", "").trim(),
      );
      return false;
    }
  }

  // B. Batch Upload
  Future<bool> uploadCsv(PlatformFile file) async {
    state = AddLecturerState(isLoading: true);

    try {
      final bytes = file.bytes ?? await File(file.path!).readAsBytes();

      // Create MultipartFile
      final multipartFile = http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: file.name,
      );

      // Call API
      await ApiService().lecturers.lecturersBatchUploadPost(multipartFile);

      state = AddLecturerState(
        isLoading: false,
        successMessage: "Batch upload queued successfully.",
      );
      return true;
    } catch (e) {
      state = AddLecturerState(
        isLoading: false,
        error: "Upload failed: ${e.toString().replaceAll("Exception:", "").trim()}",
      );
      return false;
    }
  }

  // C. CSV Template Helper
  String generateCsvTemplate() {
    return "first_name,last_name,email,department_public_id,title,gender,national_id,dob,address,phone\n"
        "Jane,Doe,jane@college.edu,UUID-HERE,Dr,F,NAT-987654,1980-05-20,456 Faculty Rd,+1987654321";
  }
}