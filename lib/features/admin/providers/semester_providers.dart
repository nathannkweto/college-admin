import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_api/api.dart' as admin;
import '../../../core/services/api_service.dart';

// ==========================================
// 1. FILTER CLASS
// ==========================================
// We use this to uniquely identify a specific timetable view
class TimetableFilter {
  final String semesterId;
  final String programId;

  TimetableFilter({required this.semesterId, required this.programId});

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
    .autoDispose<List<admin.TimetableEntry>, TimetableFilter>((ref, filter) async {
  print("🔄 [Timetable] Fetching for Sem: ${filter.semesterId}...");
  try {
    final result = await ApiService().timetables.logisticsTimetableGet(
      filter.semesterId,
      programPublicId: filter.programId,
    );

    return result?.data?.toList() ?? [];
  } catch (e) {
    print("🔴 [Timetable] Error: $e");
    throw e;
  }
});

// ==========================================
// 3. CONTROLLER
// ==========================================

final timetableControllerProvider =
StateNotifierProvider<TimetableController, AsyncValue<void>>((ref) {
  return TimetableController(ref);
});

class TimetableController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  TimetableController(this.ref) : super(const AsyncValue.data(null));

  Future<bool> assignClass({
    required String programId,
    required String semesterId,
    required String courseId,
    // required String lecturerId, <--- REMOVED (Backend resolves this now)
    required String day,
    required String startTime,
    required String endTime,
    required String location,
  }) async {
    state = const AsyncValue.loading();
    try {
      print("🚀 Assigning Class: $courseId (Lecturer resolved by backend) at $startTime");

      // Convert String day to Enum
      final dayEnum = admin.LogisticsTimetablePostRequestDayEnum.values.firstWhere(
            (e) => e.value == day,
        orElse: () => throw Exception('Invalid day provided: $day'),
      );

      final req = admin.LogisticsTimetablePostRequest(
        semesterPublicId: semesterId,
        programPublicId: programId,
        coursePublicId: courseId,
        // lecturerPublicId: lecturerId, <--- REMOVED
        day: dayEnum,
        startTime: startTime,
        endTime: endTime,
        location: location,
      );

      await ApiService().timetables.logisticsTimetablePost(req);

      // Refresh the specific timetable view
      ref.invalidate(timetableEntriesProvider(
        TimetableFilter(semesterId: semesterId, programId: programId),
      ));

      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      print("🔴 Assign Class Error: $e");
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> removeClass({
    required String entryId,
    required String programId,
    required String semesterId,
  }) async {
    // Placeholder for DELETE logic
    print("🗑️ Removing Class Entry: $entryId");

    // await ApiService().timetables.logisticsTimetableEntryDelete(entryId);

    ref.invalidate(timetableEntriesProvider(
      TimetableFilter(semesterId: semesterId, programId: programId),
    ));
    return true;
  }
}