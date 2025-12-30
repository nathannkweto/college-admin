import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_api/api.dart' as admin;
import '../../../core/services/api_service.dart';

// ==========================================
// 1. PROGRAM SUMMARY PROVIDER
//    Fetches list of students + "is_published" status
// ==========================================
final programResultsProvider = FutureProvider.family
    .autoDispose<admin.ResultsProgramSummaryGet200Response, ResultsFilter>((
    ref,
    filter,
    ) async {
  try {
    // FIX: Pass arguments positionally (in order), not by name
    final response = await ApiService().results.resultsProgramSummaryGet(
      filter.programId, // 1st argument: programPublicId
      filter.semesterId, // 2nd argument: semesterPublicId
    );

    if (response == null) {
      throw Exception("No data returned from API");
    }
    return response;
  } catch (e) {
    // Allow the UI to handle the error state (e.g. show "Failed to load")
    rethrow;
  }
});

// ==========================================
// 2. STUDENT TRANSCRIPT PROVIDER
//    Fetches detailed marks for one student
// ==========================================
final studentTranscriptProvider = FutureProvider.family
    .autoDispose<admin.StudentTranscript, TranscriptFilter>((
    ref,
    filter,
    ) async {
  try {
    // FIX: Pass arguments positionally here too
    final response = await ApiService().results.resultsStudentTranscriptGet(
      filter.studentId, // 1st: studentPublicId
      filter.semesterId, // 2nd: semesterPublicId
    );

    if (response == null) {
      throw Exception("Transcript not found");
    }
    return response;
  } catch (e) {
    rethrow;
  }
});

// ==========================================
// 3. PUBLISH/UNPUBLISH CONTROLLER
//    Handles the POST action to show/hide results
// ==========================================
final publishResultsControllerProvider =
StateNotifierProvider<PublishResultsController, AsyncValue<void>>((ref) {
  return PublishResultsController(ref);
});

class PublishResultsController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  PublishResultsController(this.ref) : super(const AsyncData(null));

  Future<void> togglePublication({
    required String programId,
    required String semesterId,
    required bool currentStatusIsPublished,
  }) async {
    state = const AsyncLoading();

    try {
      // Determine action based on current state
      final action = currentStatusIsPublished
          ? admin.ResultsPublishPostRequestActionEnum.UNPUBLISH
          : admin.ResultsPublishPostRequestActionEnum.PUBLISH;

      final request = admin.ResultsPublishPostRequest(
        programPublicId: programId,
        semesterPublicId: semesterId,
        action: action,
      );

      // FIX: Pass request object positionally
      await ApiService().results.resultsPublishPost(request);

      // CRITICAL: Refresh the summary provider so the UI updates the "Published" status
      ref.invalidate(programResultsProvider(
        ResultsFilter(programId: programId, semesterId: semesterId),
      ));

      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }
}

// ==========================================
// HELPER CLASSES (For passing multiple args to .family)
// ==========================================

/// Used to filter the main list by Program AND Semester
class ResultsFilter {
  final String programId;
  final String semesterId;

  ResultsFilter({required this.programId, required this.semesterId});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ResultsFilter &&
              runtimeType == other.runtimeType &&
              programId == other.programId &&
              semesterId == other.semesterId;

  @override
  int get hashCode => programId.hashCode ^ semesterId.hashCode;
}

/// Used to fetch a specific student's transcript for a specific Semester
class TranscriptFilter {
  final String studentId;
  final String semesterId;

  TranscriptFilter({required this.studentId, required this.semesterId});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TranscriptFilter &&
              runtimeType == other.runtimeType &&
              studentId == other.studentId &&
              semesterId == other.semesterId;

  @override
  int get hashCode => studentId.hashCode ^ semesterId.hashCode;
}