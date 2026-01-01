import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_api/api.dart' as admin;
import 'package:college_admin/core/services/api_service.dart'; // Direct Import

// -----------------------------------------------------------------------------
// 1. Program Summary Provider
// -----------------------------------------------------------------------------
// Fetches the list of students and publication status for a specific program & semester.
// Usage: ref.watch(programResultsProvider((programId: '...', semesterId: '...')))
final programResultsProvider = FutureProvider.family
    .autoDispose<admin.ProgramResultsResponse, ({String programId, String semesterId})>((ref, args) async {

  // Direct access via Singleton
  final api = ApiService().results;

  // FIX: Positional arguments, and the response IS the data (nullable)
  final response = await api.resultsProgramSummaryGet(
      args.programId,
      args.semesterId
  );

  // FIX: Handle null response safely
  return response ?? admin.ProgramResultsResponse(isPublished: false, data: []);
});

// -----------------------------------------------------------------------------
// 2. Student Transcript Provider
// -----------------------------------------------------------------------------
// Fetches detailed results for a single student.
final studentTranscriptProvider = FutureProvider.family
    .autoDispose<admin.StudentTranscript, ({String studentId, String semesterId})>((ref, args) async {

  // Direct access via Singleton
  final api = ApiService().results;

  // FIX: Positional arguments
  final response = await api.resultsStudentTranscriptGet(
      args.studentId,
      args.semesterId
  );

  if (response == null) {
    throw Exception("No transcript data returned from server");
  }

  return response;
});

// -----------------------------------------------------------------------------
// 3. Publish Results Controller
// -----------------------------------------------------------------------------
// Handles the action of publishing/unpublishing.
final publishResultControllerProvider = StateNotifierProvider<PublishResultNotifier, AsyncValue<void>>((ref) {
  return PublishResultNotifier(ref);
});

class PublishResultNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  PublishResultNotifier(this.ref) : super(const AsyncData(null));

  Future<bool> publish({required String programId, required String semesterId}) async {
    state = const AsyncLoading();
    try {
      // Direct access via Singleton
      final api = ApiService().results;

      // FIX: Positional argument for the request body object
      await api.resultsPublishPost(
          admin.ResultsPublishPostRequest(
            programPublicId: programId,
            semesterPublicId: semesterId,
            action: admin.ResultsPublishPostRequestActionEnum.PUBLISH,
          )
      );

      state = const AsyncData(null);

      // CRITICAL: Invalidate the specific program provider so the UI updates
      // the status from "Draft" to "Published" immediately.
      ref.invalidate(programResultsProvider((programId: programId, semesterId: semesterId)));

      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }
}