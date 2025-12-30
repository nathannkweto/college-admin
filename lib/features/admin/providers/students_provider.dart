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

// 2. The Main Data Provider
// We watch the filter provider so this auto-refreshes whenever filters change
final studentsListProvider = FutureProvider.autoDispose<StudentsGet200Response>(
  (ref) async {
    final filter = ref.watch(studentFilterProvider);

    // Call Generated API
    // Method likely named 'studentsGet' based on GET /students
    return await ApiService().students.studentsGet(
          search: filter.searchQuery,
          programPublicId: filter.programPublicId,
        ) ??
        StudentsGet200Response(data: []); // Return empty if null
  },
);
