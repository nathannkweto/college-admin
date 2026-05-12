import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_api/api.dart'; // Generated package
import '../../../core/services/api_service.dart';

// --- FILTER STATE ---
class StudentFilterState {
  final String? searchQuery;
  final String? programPublicId;
  final int page;

  StudentFilterState({this.searchQuery, this.programPublicId, this.page = 1});

  StudentFilterState copyWith({
    String? searchQuery,
    String? programPublicId,
    int? page,
  }) {
    return StudentFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      programPublicId: programPublicId ?? this.programPublicId,
      page: page ?? this.page,
    );
  }
}

// 1. Controller for Filter State
final studentFilterProvider = StateProvider.autoDispose<StudentFilterState>((
  ref,
) {
  return StudentFilterState();
});

// 2. The Main Data Provider (List)
// We watch the filter provider so this auto-refreshes whenever filters change
final studentsListProvider = FutureProvider.autoDispose<StudentsGet200Response>(
  (ref) async {
    final filter = ref.watch(studentFilterProvider);

    // Call Generated API
    return await ApiService().students.studentsGet(
          search: filter.searchQuery,
          programPublicId: filter.programPublicId,
        ) ??
        StudentsGet200Response(data: []); // Return empty if null
  },
);

// 3. Single Student Provider (GET /students/{public_id})
// Uses .family to pass the public_id argument
final studentDetailProvider = FutureProvider.autoDispose.family<StudentsShow200Response, String>(
  (ref, publicId) async {
    
    // FIXED: Passed as a positional argument
    return await ApiService().students.studentsShow(publicId) ??
        StudentsShow200Response(); 
  },
);

// 4. Student Actions Provider (Mutations)
// Exposes methods to handle PUT and DELETE, automatically refreshing UI state
final studentActionsProvider = Provider.autoDispose<StudentActions>((ref) {
  return StudentActions(ref);
});

class StudentActions {
  final Ref ref;

  StudentActions(this.ref);

  /// Update an existing student
  // FIXED: Changed type to StudentsUpdateRequest
  Future<void> updateStudent(String publicId, StudentsUpdateRequest body) async {
    try {
      // FIXED: Passed as positional arguments
      await ApiService().students.studentsUpdate(publicId, body);
          
      // Success! Refresh the list and the specific student's detail view
      ref.invalidate(studentsListProvider);
      ref.invalidate(studentDetailProvider(publicId));
    } catch (e) {
      // Handle or rethrow your error
      rethrow;
    }
  }

  /// Delete a student
  Future<void> deleteStudent(String publicId) async {
    try {
      // FIXED: Passed as a positional argument
      await ApiService().students.studentsDelete(publicId);
          
      // Success! Refresh the list
      ref.invalidate(studentsListProvider);
    } catch (e) {
      // Handle or rethrow your error
      rethrow;
    }
  }
}