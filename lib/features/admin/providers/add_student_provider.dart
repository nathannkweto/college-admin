import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// Alias the generated library
import 'package:admin_api/api.dart' as admin;

// Import your custom service
import '../../../core/services/api_service.dart';

// --- STATE CLASS ---
class AddStudentState {
  final bool isLoading;
  final String? error;
  final String? successMessage;

  AddStudentState({this.isLoading = false, this.error, this.successMessage});
}

// --- PROVIDERS ---

// 1. Fetch Programs (For Dropdown)
final academicProgramsProvider = FutureProvider.autoDispose<List<admin.Program>>((
    ref,
    ) async {
  try {
    // Call the Academics API
    // Note: The spec defines the response as { data: [Program] }
    final response = await ApiService().academics.programsGet();

    // The generated client typically unwraps the response, or we access .data
    // Adjust '.data' based on exactly how the generator built the 'ProgramsGet200Response'
    return response?.data ?? [];
  } catch (e) {
    // Return empty list on error to prevent UI crash
    return [];
  }
});

// 2. Controller
final addStudentControllerProvider =
StateNotifierProvider.autoDispose<AddStudentController, AddStudentState>((
    ref,
    ) {
  return AddStudentController();
});

class AddStudentController extends StateNotifier<AddStudentState> {
  AddStudentController() : super(AddStudentState());

  // A. Register Single Student
  Future<bool> registerSingleStudent({
    required String firstName,
    required String lastName,
    required String email,
    required String programPublicId,
    required String gender, // 'M' or 'F'
    required DateTime enrollmentDate,
    // --- NEW REQUIRED FIELDS ADDED BELOW ---
    required String nationalId,
    required DateTime dob,
    required String address,
    required String phone,
  }) async {
    state = AddStudentState(isLoading: true);

    try {
      // Map String to Enum
      final genderEnum = gender == 'M'
          ? admin.StudentsPostRequestGenderEnum.M
          : admin.StudentsPostRequestGenderEnum.F;

      // Create Request Object (Matches new YAML definition)
      final requestBody = admin.StudentsPostRequest(
        firstName: firstName,
        lastName: lastName,
        email: email,
        programPublicId: programPublicId,
        gender: genderEnum,
        enrollmentDate: enrollmentDate,
        // New Fields Mapped:
        nationalId: nationalId,
        dob: dob,
        address: address,
        phone: phone,
      );

      // Call API
      await ApiService().students.studentsPost(requestBody);

      state = AddStudentState(
        isLoading: false,
        successMessage: "Student registered successfully",
      );
      return true;
    } catch (e) {
      state = AddStudentState(
        isLoading: false,
        error: e.toString().replaceAll("Exception:", "").trim(),
      );
      return false;
    }
  }

  // B. Batch Upload
  Future<bool> uploadCsv(PlatformFile file) async {
    state = AddStudentState(isLoading: true);

    try {
      // 1. Prepare bytes
      final bytes = file.bytes ?? await File(file.path!).readAsBytes();

      // 2. Create MultipartFile (The generated client usually expects this)
      final multipartFile = http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: file.name,
      );

      // 3. Call API for Batch Upload
      // Note: The generated method name might vary slightly (e.g., file: vs params)
      await ApiService().students.studentsBatchUploadPost(multipartFile);

      state = AddStudentState(
        isLoading: false,
        successMessage: "Batch job queued successfully. Check email for results.",
      );
      return true;
    } catch (e) {
      state = AddStudentState(
        isLoading: false,
        error: "Upload failed: ${e.toString().replaceAll("Exception:", "").trim()}",
      );
      return false;
    }
  }

  // C. Helper for CSV Template
  // Updated to include all 10 required fields
  String generateCsvTemplate() {
    return "first_name,last_name,email,program_public_id,gender,enrollment_date,national_id,dob,address,phone\n"
        "John,Doe,john@college.edu,UUID-HERE,M,2025-09-01,NAT-123456,2000-01-01,123 Main St,+1234567890";
  }
}