import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart'; // Add intl for date formatting
import 'package:admin_api/api.dart' as admin;
import '../../providers/finance_providers.dart';
import '../../providers/curriculum_providers.dart';

// --- SEAMLESS STYLE HELPER ---
InputDecoration _decor(String label, {IconData? icon, String? hint}) =>
    InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: icon != null
          ? Icon(icon, size: 20, color: Colors.blueGrey)
          : null,
      filled: true,
      fillColor: Colors.grey.shade50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      isDense: true,
    );

class ApplyFeeDialog extends ConsumerStatefulWidget {
  const ApplyFeeDialog({super.key});
  @override
  ConsumerState<ApplyFeeDialog> createState() => _ApplyFeeDialogState();
}

class _ApplyFeeDialogState extends ConsumerState<ApplyFeeDialog> {
  final _titleCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _studentIdCtrl = TextEditingController();
  DateTime? _dueDate;

  admin.FinanceFeesPostRequestTargetTypeEnum _targetType =
      admin.FinanceFeesPostRequestTargetTypeEnum.ALL;
  String? _selectedProgramId;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(financeControllerProvider);
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 450),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Apply Fee / Invoice",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),

                // Title
                TextField(
                  controller: _titleCtrl,
                  decoration: _decor(
                    "Fee Title",
                    icon: Icons.description_outlined,
                    hint: "e.g. Lab Fee Term 1",
                  ),
                ),
                const SizedBox(height: 12),

                // Amount
                TextField(
                  controller: _amountCtrl,
                  decoration: _decor(
                    "Amount",
                    icon: Icons.attach_money_rounded,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
                const SizedBox(height: 12),

                // Due Date Picker
                InkWell(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now().add(const Duration(days: 30)),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        const Duration(days: 365 * 2),
                      ),
                    );
                    if (picked != null) setState(() => _dueDate = picked);
                  },
                  child: InputDecorator(
                    decoration: _decor(
                      "Due Date",
                      icon: Icons.calendar_today_rounded,
                    ),
                    child: Text(
                      _dueDate == null
                          ? "Select Due Date (Optional)"
                          : DateFormat('MMM dd, yyyy').format(_dueDate!),
                      style: TextStyle(
                        color: _dueDate == null
                            ? Colors.grey.shade600
                            : Colors.black87,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Target Dropdown
                DropdownButtonFormField<
                  admin.FinanceFeesPostRequestTargetTypeEnum
                >(
                  value: _targetType,
                  decoration: _decor(
                    "Apply To",
                    icon: Icons.track_changes_rounded,
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: admin.FinanceFeesPostRequestTargetTypeEnum.ALL,
                      child: Text("All Active Students"),
                    ),
                    DropdownMenuItem(
                      value: admin.FinanceFeesPostRequestTargetTypeEnum.PROGRAM,
                      child: Text("Specific Program"),
                    ),
                    DropdownMenuItem(
                      value: admin.FinanceFeesPostRequestTargetTypeEnum.STUDENT,
                      child: Text("Specific Student"),
                    ),
                  ],
                  onChanged: (v) => setState(() {
                    _targetType = v!;
                    _selectedProgramId = null;
                    _studentIdCtrl.clear();
                  }),
                ),

                // Conditional Inputs based on Target
                if (_targetType ==
                    admin.FinanceFeesPostRequestTargetTypeEnum.PROGRAM) ...[
                  const SizedBox(height: 12),
                  ref
                      .watch(programsProvider)
                      .when(
                        loading: () => const LinearProgressIndicator(),
                        error: (_, __) => const Text("Error loading programs"),
                        data: (programs) => DropdownButtonFormField<String>(
                          decoration: _decor(
                            "Select Program",
                            icon: Icons.school_outlined,
                          ),
                          items: programs
                              .map(
                                (p) => DropdownMenuItem(
                                  value: p.publicId,
                                  child: Text(p.name ?? "-"),
                                ),
                              )
                              .toList(),
                          onChanged: (v) => _selectedProgramId = v,
                        ),
                      ),
                ],

                if (_targetType ==
                    admin.FinanceFeesPostRequestTargetTypeEnum.STUDENT) ...[
                  const SizedBox(height: 12),
                  TextField(
                    controller: _studentIdCtrl,
                    decoration: _decor(
                      "Student ID",
                      icon: Icons.person_outline,
                      hint: "e.g.  2025-CSC-001",
                    ),
                  ),
                ],

                const SizedBox(height: 24),

                // --- ERROR DISPLAY ---
                if (state.hasError) ...[
                  _buildErrorBanner(state.error!),
                  const SizedBox(height: 16),
                ],

                // Actions
                _buildActionButtons(
                  state: state,
                  onConfirm: () async {
                    String? finalTargetId;

                    if (_targetType ==
                        admin.FinanceFeesPostRequestTargetTypeEnum.PROGRAM) {
                      finalTargetId = _selectedProgramId;
                    } else if (_targetType ==
                        admin.FinanceFeesPostRequestTargetTypeEnum.STUDENT) {
                      finalTargetId = _studentIdCtrl.text;
                    }

                    if (_titleCtrl.text.isEmpty || _amountCtrl.text.isEmpty)
                      return;

                    final success = await ref
                        .read(financeControllerProvider.notifier)
                        .applyFee(
                          title: _titleCtrl.text,
                          amount: double.tryParse(_amountCtrl.text) ?? 0,
                          targetType: _targetType,
                          targetId: finalTargetId,
                          dueDate: _dueDate,
                        );
                    if (success && mounted) Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecordTransactionDialog extends ConsumerStatefulWidget {
  const RecordTransactionDialog({super.key});
  @override
  ConsumerState<RecordTransactionDialog> createState() =>
      _RecordTransactionDialogState();
}

class _RecordTransactionDialogState
    extends ConsumerState<RecordTransactionDialog> {
  final _amountCtrl = TextEditingController();
  final _refCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  final _studentIdInputCtrl =
      TextEditingController(); // The readable ID (e.g.  2025-CSC-001)
  final _generalTitleCtrl = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  // State for Student Fee Lookup
  bool _isFeePayment = true;
  String? _resolvedPublicId; // The UUID found after lookup
  String?
  _resolvedStudentName; // To confirm to the user we found the right person
  String? _selectedFeeId; // The specific fee selected
  bool _isSearching = false; // Loading state for the lookup button

  admin.FinanceTransactionsPostRequestTypeEnum _type =
      admin.FinanceTransactionsPostRequestTypeEnum.income;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(financeControllerProvider);
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 450),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Record Transaction",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // --- TYPE TOGGLE ---
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      _buildToggleButton("Fee Payment", _isFeePayment, () {
                        setState(() {
                          _isFeePayment = true;
                          _type = admin
                              .FinanceTransactionsPostRequestTypeEnum
                              .income;
                        });
                      }),
                      _buildToggleButton("General Txn", !_isFeePayment, () {
                        setState(() => _isFeePayment = false);
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // --- 1. FEE PAYMENT LOGIC ---
                if (_isFeePayment) ...[
                  // A. Student ID Search Row
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _studentIdInputCtrl,
                          decoration: _decor(
                            "Student ID",
                            icon: Icons.badge_outlined,
                            hint: "e.g.  2025-CSC-001",
                          ),
                          onSubmitted: (_) => _performStudentLookup(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton.filled(
                        onPressed: _isSearching ? null : _performStudentLookup,
                        icon: _isSearching
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.search),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.blue.shade100,
                          foregroundColor: Colors.blue.shade900,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // B. Lookup Result Name Verification
                  if (_resolvedStudentName != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 4),
                      child: Text(
                        "Found: $_resolvedStudentName",
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),

                  const SizedBox(height: 16),

                  // C. Fees Dropdown (Only shows after valid lookup)
                  if (_resolvedPublicId != null)
                    ref
                        .watch(studentFeesProvider(_resolvedPublicId!))
                        .when(
                          loading: () => const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: LinearProgressIndicator()),
                          ),
                          error: (e, _) =>
                              _buildErrorBanner("Could not fetch fees."),
                          data: (fees) {
                            // Filter: Only show fees with positive balance
                            final unpaidFees = fees
                                .where((f) => (f.balance ?? 0) > 0)
                                .toList();

                            if (unpaidFees.isEmpty) {
                              return Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  "Student has no pending fees!",
                                  style: TextStyle(color: Colors.green),
                                ),
                              );
                            }

                            return DropdownButtonFormField<String>(
                              value: _selectedFeeId,
                              decoration: _decor(
                                "Select Fee to Pay",
                                icon: Icons.checklist_rtl_rounded,
                              ),
                              isExpanded: true,
                              items: unpaidFees.map((fee) {
                                final balance = fee.balance ?? 0;
                                return DropdownMenuItem(
                                  value: fee.publicId,
                                  child: Text(
                                    "${fee.title} (Due: $balance)",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  _selectedFeeId = val;
                                  // Amount is NOT auto-filled, admin enters it manually below
                                });
                              },
                            );
                          },
                        ),

                  const SizedBox(height: 16),
                ]
                // --- 2. GENERAL TXN LOGIC ---
                else ...[
                  TextField(
                    controller: _generalTitleCtrl,
                    decoration: _decor(
                      "Transaction Title",
                      icon: Icons.title,
                      hint: "e.g. Staff salaries, Grant",
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // --- 3. SHARED FIELDS ---
                Row(
                  children: [
                    if (!_isFeePayment)
                      Expanded(
                        flex: 2,
                        child:
                            DropdownButtonFormField<
                              admin.FinanceTransactionsPostRequestTypeEnum
                            >(
                              value: _type,
                              decoration: _decor("Type"),
                              items: const [
                                DropdownMenuItem(
                                  value: admin
                                      .FinanceTransactionsPostRequestTypeEnum
                                      .income,
                                  child: Text("Income"),
                                ),
                                DropdownMenuItem(
                                  value: admin
                                      .FinanceTransactionsPostRequestTypeEnum
                                      .expense,
                                  child: Text("Expense"),
                                ),
                              ],
                              onChanged: (v) => setState(() => _type = v!),
                            ),
                      ),
                    if (!_isFeePayment) const SizedBox(width: 12),

                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: _amountCtrl,
                        decoration: _decor("Amount"),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                InkWell(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now().add(const Duration(days: 30)),
                    );
                    if (picked != null) setState(() => _selectedDate = picked);
                  },
                  child: InputDecorator(
                    decoration: _decor("Date", icon: Icons.calendar_today),
                    child: Text(
                      DateFormat('MMM dd, yyyy').format(_selectedDate),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: _refCtrl,
                  decoration: _decor(
                    "Ref / Receipt ID",
                    icon: Icons.receipt_long_rounded,
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: _noteCtrl,
                  decoration: _decor(
                    "Internal Notes",
                    icon: Icons.note_alt_outlined,
                  ),
                  maxLines: 2,
                ),

                const SizedBox(height: 24),

                if (state.hasError) ...[
                  _buildErrorBanner(state.error!),
                  const SizedBox(height: 16),
                ],

                _buildActionButtons(
                  state: state,
                  onConfirm: () async {
                    if (_amountCtrl.text.isEmpty) return;

                    final controller = ref.read(
                      financeControllerProvider.notifier,
                    );
                    bool success = false;

                    if (_isFeePayment) {
                      // Validate Lookup
                      if (_resolvedPublicId == null || _selectedFeeId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please select a student and a fee."),
                          ),
                        );
                        return;
                      }

                      success = await controller.recordFeePayment(
                        studentId:
                            _resolvedPublicId!, // Send the UUID to backend
                        feeId: _selectedFeeId!,
                        amount: double.tryParse(_amountCtrl.text) ?? 0,
                        transactionId: _refCtrl.text,
                        date: _selectedDate,
                        note: _noteCtrl.text,
                      );
                    } else {
                      if (_generalTitleCtrl.text.isEmpty) return;

                      success = await controller.recordGeneralTransaction(
                        title: _generalTitleCtrl.text,
                        amount: double.tryParse(_amountCtrl.text) ?? 0,
                        type: _type,
                        transactionId: _refCtrl.text,
                        date: _selectedDate,
                        note: _noteCtrl.text,
                      );
                    }

                    if (success && mounted) Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- LOOKUP LOGIC ---
  Future<void> _performStudentLookup() async {
    final inputId = _studentIdInputCtrl.text.trim();
    if (inputId.isEmpty) return;

    setState(() {
      _isSearching = true;
      _resolvedPublicId = null; // Reset previous results
      _selectedFeeId = null;
      _resolvedStudentName = null;
    });

    try {
      // 1. Fetch all students (or search if API supports it)
      final allStudents = await ref.read(studentsProvider.future);

      // 2. Find matching Student ID (Case insensitive safe)
      final student = allStudents.firstWhere(
        (s) => (s.studentId ?? "").toLowerCase() == inputId.toLowerCase(),
        orElse: () => throw Exception("Student not found"),
      );

      // 3. Success
      setState(() {
        _resolvedPublicId = student.publicId;
        _resolvedStudentName = "${student.firstName} ${student.lastName}";
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Student '$inputId' not found.")),
        );
      }
    } finally {
      setState(() => _isSearching = false);
    }
  }

  Widget _buildToggleButton(String text, bool isActive, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                color: isActive ? Colors.blue.shade700 : Colors.blueGrey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- SHARED WIDGETS ---
Widget _buildErrorBanner(Object error) {
  final message = error.toString().replaceAll("Exception:", "").trim();
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.red.shade50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(Icons.error_outline, color: Colors.red.shade700, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            message,
            style: TextStyle(color: Colors.red.shade900, fontSize: 13),
          ),
        ),
      ],
    ),
  );
}

Widget _buildActionButtons({
  required dynamic state,
  required VoidCallback onConfirm,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Builder(
        builder: (context) => TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel", style: TextStyle(color: Colors.grey.shade600)),
        ),
      ),
      const SizedBox(width: 12),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: state.isLoading ? null : onConfirm,
        child: Text(state.isLoading ? "Processing..." : "Confirm"),
      ),
    ],
  );
}
