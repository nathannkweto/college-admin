import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_api/api.dart' as admin;
import '../../../core/services/api_service.dart';

// ==========================================
// 1. DATA FETCHING PROVIDERS
// ==========================================

// A. Fetch Transaction History
final transactionsProvider =
FutureProvider.autoDispose<List<admin.FinanceTransaction>>((ref) async {
  try {
    // OperationId: financeTransactionsGet
    // Returns { data: [...] } wrapper based on your YAML
    final result = await ApiService().finance.financeTransactionsGet();
    return result?.data?.toList() ?? [];
  } catch (e) {
    return [];
  }
});

// B. Fetch Fees for a Specific Student (Dropdown Source)
final studentFeesProvider = FutureProvider.family
    .autoDispose<List<admin.FinanceFee>, String>((ref, studentId) async {
  if (studentId.isEmpty) return [];
  try {
    // FIX: Use the specific endpoint that accepts the manual ID in the path
    final result = await ApiService().finance.financeStudentFeesGet(
      studentId,
    );

    // 🔴 UPDATED: Must access .data because this endpoint is now wrapped too!
    return result?.data?.toList() ?? [];
  } catch (e) {
    print("Error fetching student fees: $e");
    return [];
  }
});

// C. Fetch all students (used for the "Select Student" dropdown)
final studentsProvider = FutureProvider.autoDispose<List<admin.Student>>((
    ref,
    ) async {
  try {
    final result = await ApiService().students.studentsGet();
    // Correctly accessing .data
    return result?.data?.toList() ?? [];
  } catch (e) {
    return [];
  }
});

// ==========================================
// 2. ACTION CONTROLLER
// ==========================================

final financeControllerProvider =
StateNotifierProvider<FinanceController, AsyncValue<void>>((ref) {
  return FinanceController(ref);
});

class FinanceController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  FinanceController(this.ref) : super(const AsyncValue.data(null));

  Future<bool> _perform(Future<void> Function() action) async {
    state = const AsyncValue.loading();
    try {
      await action();
      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      if (e is admin.ApiException) {
        print('🔴 API ERROR ${e.code}: ${e.message}');
      } else {
        print('🔴 GENERIC ERROR: $e');
      }
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  // --- ACTIONS ---

  // 1. Apply Fee (Create Invoice)
  Future<bool> applyFee({
    required String title,
    required double amount,
    required admin.FinanceFeesPostRequestTargetTypeEnum targetType,
    String? targetId,
    DateTime? dueDate,
  }) async {
    return _perform(() async {
      final req = admin.FinanceFeesPostRequest(
        title: title,
        amount: amount,
        targetType: targetType,
        targetPublicId: targetId,
        // Now valid because we added due_date to YAML
        dueDate: dueDate != null
            ? DateTime(dueDate.year, dueDate.month, dueDate.day)
            : null,
      );

      await ApiService().finance.financeFeesPost(req);

      // If we applied to a specific student, refresh their fees; otherwise refresh everything
      if (targetId != null &&
          targetType == admin.FinanceFeesPostRequestTargetTypeEnum.STUDENT) {
        ref.invalidate(studentFeesProvider(targetId));
      }
    });
  }

  // 2. Record Fee Payment (Income linked to a Fee)
  Future<bool> recordFeePayment({
    required String studentId,
    required String feeId,
    required double amount,
    required String transactionId,
    required DateTime date,
    String? note,
  }) async {
    return _perform(() async {
      final cleanDate = DateTime(date.year, date.month, date.day);
      final paymentTitle = "Fee Payment - $studentId";

      final req = admin.FinanceTransactionsPostRequest(
        title: paymentTitle,
        amount: amount,
        type: admin.FinanceTransactionsPostRequestTypeEnum.income, // Always income
        date: cleanDate,
        transactionId: transactionId,
        feePublicId: feeId, // Link to the fee
        note: note ?? "Fee Clearance", // Now valid
      );

      await ApiService().finance.financeTransactionsPost(req);

      // Refresh list to show new transaction
      ref.invalidate(transactionsProvider);
      // Refresh student fees so the paid one disappears from 'pending'
      ref.invalidate(studentFeesProvider(studentId));
    });
  }

  // 3. Record General Transaction (Ad-hoc Income/Expense)
  Future<bool> recordGeneralTransaction({
    required String title,
    required double amount,
    required admin.FinanceTransactionsPostRequestTypeEnum type,
    required String transactionId,
    required DateTime date,
    String? note,
  }) async {
    return _perform(() async {
      final cleanDate = DateTime(date.year, date.month, date.day);

      final req = admin.FinanceTransactionsPostRequest(
        title: title,
        amount: amount,
        type: type,
        date: cleanDate,
        transactionId: transactionId,
        feePublicId: null, // No fee linked
        note: note,
      );

      await ApiService().finance.financeTransactionsPost(req);

      ref.invalidate(transactionsProvider);
    });
  }
}