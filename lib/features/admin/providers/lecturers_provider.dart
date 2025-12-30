import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_api/api.dart' as admin;
import 'package:college_admin/core/services/api_service.dart';

// Provider for the list of lecturers
final lecturersListProvider = FutureProvider.autoDispose<List<admin.Lecturer>>((ref) async {
  // Use the generated API client instead of manual http calls
  final response = await ApiService().lecturers.lecturersGet();

  // The generated code usually returns a 'LecturerResponse' or 'List<Lecturer>'
  // based on your YAML. Adjust the access below to match your specific response object:
  return response?.data ?? [];
});