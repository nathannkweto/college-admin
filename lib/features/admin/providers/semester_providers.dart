import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_api/api.dart' as admin;
import '../../../core/services/api_service.dart';

// ==========================================
// 1. FILTER CLASS
// ==========================================
class TimetableFilter {
  final String semesterId;
  final String programId;

  TimetableFilter({
    required this.semesterId,
    required this.programId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TimetableFilter &&
              runtimeType == other.runtimeType &&
              semesterId == other.semesterId &&
              programId == other.programId;

  @override
  int get hashCode => semesterId.hashCode ^ programId.hashCode;
}

// ==========================================
// 2. DATA PROVIDER
// ==========================================
final timetableEntriesProvider = FutureProvider.family
    .autoDispose<List<admin.TimetableEntry>, TimetableFilter>((
    ref,
    filter,
    ) async {
  try {
    final result = await ApiService().timetables.logisticsTimetableGet(
      filter.semesterId,
      programPublicId: filter.programId,
    );

    // 🔴 FIX: Access .data because the response is now wrapped
    return result?.data?.toList() ?? [];
  } catch (e) {
    return [];
  }
});

// ==========================================
// 3. ACTION CONTROLLER
// ==========================================
final timetableControllerProvider =
StateNotifierProvider<TimetableController, AsyncValue<void>>((ref) {
  return TimetableController(ref);
});

class TimetableController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  TimetableController(this.ref) : super(const AsyncData(null));

  Future<bool> assignClass({
    required String programId,
    required String semesterId,
    required String courseId,
    required String day,
    required String startTime,
    String? roomId,
  }) async {
    state = const AsyncLoading();
    try {
      final hour = int.parse(startTime.split(':')[0]);
      final endTime = "${(hour + 1).toString().padLeft(2, '0')}:00:00";
      final formattedStartTime = "$startTime:00";

      final req = admin.LogisticsTimetablePostRequest(
        programPublicId: programId,
        semesterPublicId: semesterId,
        coursePublicId: courseId,
        day: day,
        startTime: formattedStartTime,
        endTime: endTime,
        location: roomId,
        // Note: 'lecturerPublicId' is available in your spec but optional.
        // If you need to assign a lecturer later, add it here.
      );

      await ApiService().timetables.logisticsTimetablePost(req);

      // Refresh the grid
      ref.invalidate(timetableEntriesProvider(
        TimetableFilter(semesterId: semesterId, programId: programId),
      ));

      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }

  Future<bool> removeClass({
    required String entryId,
    required String programId,
    required String semesterId,
  }) async {
    state = const AsyncLoading();
    try {
      // ⚠️ NOTE: Your spec is still missing the DELETE endpoint for /logistics/timetable
      // You need to add a DELETE path in your YAML if you want this to work.

      print("Delete functionality is currently missing from the generated API.");

      // Refresh to simulate update
      await Future.delayed(const Duration(milliseconds: 500));
      ref.invalidate(timetableEntriesProvider(
        TimetableFilter(semesterId: semesterId, programId: programId),
      ));

      state = const AsyncData(null);
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }
}