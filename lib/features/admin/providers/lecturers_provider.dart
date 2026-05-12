import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_api/api.dart' as admin;
import 'package:college_admin/core/services/api_service.dart';

/// 1. Provider for the list of lecturers
final lecturersListProvider = FutureProvider.autoDispose<List<admin.Lecturer>>((ref) async {
  // Access the singleton ApiService
  final api = ApiService();
  
  // Call the GET /lecturers endpoint
  final response = await api.lecturers.lecturersGet();

  // Based on the generated code, we extract the data list
  return response?.data ?? [];
});

/// 2. Provider for a single lecturer's details
/// Uses .family to accept the publicId as a parameter
final lecturerDetailProvider = FutureProvider.autoDispose.family<admin.LecturersShow200Response?, String>((ref, publicId) async {
  final api = ApiService();
  
  // Call the GET /lecturers/{public_id} endpoint
  final response = await api.lecturers.lecturersShow(publicId);
  
  return response;
});