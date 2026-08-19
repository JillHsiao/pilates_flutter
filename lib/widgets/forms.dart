import 'package:flutter/material.dart';
import '../core/utils/formatters.dart';
import '../models/models.dart';
import 'common.dart';

Future<Json?> showStudentForm(
  BuildContext context, {
  Student? student,
  StudentDetail? detail,
}) => showDialog<Json>(
  context: context,
  builder: (_) => _StudentForm(student: student, detail: detail),
);
Future<Json?> showLessonForm(
  BuildContext context, {
  required List<Student> students,
  Lesson? initial,
  int? studentId,
}) => showDialog<Json>(
  context: context,
  builder: (_) => _LessonForm(
    students: students,
    initial: initial,
    presetStudentId: studentId,
  ),
);
Future<Json?> showPurchaseForm(
  BuildContext context, {
  required List<Student> students,
  required List<CoursePackage> packages,
  Purchase? initial,
  int? studentId,
}) => showDialog<Json>(
  context: context,
  builder: (_) => _PurchaseForm(
    students: students,
    packages: packages,
    initial: initial,
    presetStudentId: studentId,
  ),
);
Future<Json?> showPaymentForm(
  BuildContext context, {
  required Purchase purchase,
  Payment? initial,
}) => showDialog<Json>(
  context: context,
  builder: (_) => _PaymentForm(purchase: purchase, initial: initial),
);
Future<Json?> showPackageForm(BuildContext context, {CoursePackage? initial}) =>
    showDialog<Json>(
      context: context,
      builder: (_) => _PackageForm(initial: initial),
    );

class _DialogFrame extends StatelessWidget {
  final String title;
  final Widget child;
  const _DialogFrame(this.title, this.child);
  @override
  Widget build(BuildContext context) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 640, maxHeight: 760),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Flexible(child: SingleChildScrollView(child: child)),
          ],
        ),
      ),
    ),
  );
}

class _StudentForm extends StatefulWidget {
  final Student? student;
  final StudentDetail? detail;
  const _StudentForm({this.student, this.detail});
  @override
  State<_StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<_StudentForm> {
  final key = GlobalKey<FormState>();
  late final name = TextEditingController(
    text: widget.detail?.name ?? widget.student?.name ?? '',
  );
  late final phone = TextEditingController(
    text: widget.detail?.phone ?? widget.student?.phone ?? '',
  );
  late final joinDate = TextEditingController(
    text: widget.detail?.joinDate ?? widget.student?.joinDate ?? today(),
  );
  late final note = TextEditingController(text: widget.detail?.note ?? '');
  late bool active =
      widget.detail?.isActive ?? widget.student?.isActive ?? true;
  @override
  Widget build(BuildContext context) => _DialogFrame(
    widget.student == null && widget.detail == null ? '新增學員' : '編輯學員',
    Form(
      key: key,
      child: Column(
        children: [
          TextFormField(
            controller: name,
            decoration: const InputDecoration(labelText: '姓名 *'),
            validator: requiredText,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: phone,
            decoration: const InputDecoration(labelText: '電話'),
          ),
          const SizedBox(height: 12),
          DateField(
            controller: joinDate,
            label: '加入日期 *',
            validator: requiredText,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: note,
            maxLines: 3,
            decoration: const InputDecoration(labelText: '備註'),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('啟用學員'),
            value: active,
            onChanged: (v) => setState(() => active = v),
          ),
          _submit(
            context,
            key,
            () => {
              'name': name.text.trim(),
              'phone': phone.text.trim(),
              'joinDate': joinDate.text,
              'note': note.text.trim(),
              'isActive': active,
            },
          ),
        ],
      ),
    ),
  );
}

class _LessonForm extends StatefulWidget {
  final List<Student> students;
  final Lesson? initial;
  final int? presetStudentId;
  const _LessonForm({
    required this.students,
    this.initial,
    this.presetStudentId,
  });
  @override
  State<_LessonForm> createState() => _LessonFormState();
}

class _LessonFormState extends State<_LessonForm> {
  final key = GlobalKey<FormState>();
  late int? studentId = widget.initial?.studentId ?? widget.presetStudentId;
  late String status = widget.initial?.status ?? 'Completed';
  late final lessonDate = TextEditingController(
    text: widget.initial?.lessonDate ?? today(),
  );
  late final content = TextEditingController(
    text: widget.initial?.content ?? '',
  );
  late final condition = TextEditingController(
    text: widget.initial?.physicalCondition ?? '',
  );
  late final note = TextEditingController(text: widget.initial?.note ?? '');
  @override
  Widget build(BuildContext context) => _DialogFrame(
    widget.initial == null ? '新增上課紀錄' : '編輯上課紀錄',
    Form(
      key: key,
      child: Column(
        children: [
          DropdownButtonFormField<int>(
            initialValue: studentId,
            decoration: const InputDecoration(labelText: '學員 *'),
            items: widget.students
                .map((s) => DropdownMenuItem(value: s.id, child: Text(s.name)))
                .toList(),
            onChanged: (v) => studentId = v,
            validator: (v) => v == null ? '請選擇學員' : null,
          ),
          const SizedBox(height: 12),
          DateField(
            controller: lessonDate,
            label: '日期 *',
            validator: requiredText,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: status,
            decoration: const InputDecoration(labelText: '狀態 *'),
            items: lessonLabels.entries
                .map(
                  (e) => DropdownMenuItem(value: e.key, child: Text(e.value)),
                )
                .toList(),
            onChanged: (v) => status = v ?? status,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: content,
            maxLines: 2,
            decoration: const InputDecoration(labelText: '課程內容'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: condition,
            maxLines: 2,
            decoration: const InputDecoration(labelText: '身體狀況 / 提醒'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: note,
            maxLines: 2,
            decoration: const InputDecoration(labelText: '備註'),
          ),
          _submit(
            context,
            key,
            () => {
              'studentId': studentId,
              'lessonDate': lessonDate.text,
              'status': status,
              'content': content.text.trim(),
              'physicalCondition': condition.text.trim(),
              'note': note.text.trim(),
            },
          ),
        ],
      ),
    ),
  );
}

class _PurchaseForm extends StatefulWidget {
  final List<Student> students;
  final List<CoursePackage> packages;
  final Purchase? initial;
  final int? presetStudentId;
  const _PurchaseForm({
    required this.students,
    required this.packages,
    this.initial,
    this.presetStudentId,
  });
  @override
  State<_PurchaseForm> createState() => _PurchaseFormState();
}

class _PurchaseFormState extends State<_PurchaseForm> {
  final key = GlobalKey<FormState>();
  late int? studentId = widget.initial?.studentId ?? widget.presetStudentId;
  late int? packageId = widget.initial?.coursePackageId;
  late final purchaseDate = TextEditingController(
    text: widget.initial?.purchaseDate ?? today(),
  );
  late final packageName = TextEditingController(
    text: widget.initial?.packageName ?? '',
  );
  late final lessons = TextEditingController(
    text: (widget.initial?.purchasedLessons ?? 10).toString(),
  );
  late final total = TextEditingController(
    text: (widget.initial?.totalAmount ?? 0).toString(),
  );
  late final note = TextEditingController(text: widget.initial?.note ?? '');
  final initialAmount = TextEditingController(text: '0');
  final paymentDate = TextEditingController(text: today());
  String method = 'Transfer';
  void choosePackage(int? id) {
    setState(() => packageId = id);
    final p = widget.packages.where((x) => x.id == id).firstOrNull;
    if (p != null) {
      packageName.text = p.name;
      lessons.text = p.lessons.toString();
      total.text = p.price.toString();
    }
  }

  @override
  Widget build(BuildContext context) => _DialogFrame(
    widget.initial == null ? '新增購課' : '編輯購課',
    Form(
      key: key,
      child: Column(
        children: [
          DropdownButtonFormField<int>(
            initialValue: studentId,
            decoration: const InputDecoration(labelText: '學員 *'),
            items: widget.students
                .map((s) => DropdownMenuItem(value: s.id, child: Text(s.name)))
                .toList(),
            onChanged: (v) => studentId = v,
            validator: (v) => v == null ? '請選擇學員' : null,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<int?>(
            initialValue: packageId,
            decoration: const InputDecoration(labelText: '課程方案'),
            items: [
              const DropdownMenuItem<int?>(value: null, child: Text('自訂方案')),
              ...widget.packages
                  .where((p) => p.isActive)
                  .map(
                    (p) => DropdownMenuItem(value: p.id, child: Text(p.name)),
                  ),
            ],
            onChanged: choosePackage,
          ),
          const SizedBox(height: 12),
          DateField(
            controller: purchaseDate,
            label: '購買日期 *',
            validator: requiredText,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: packageName,
            decoration: const InputDecoration(labelText: '方案名稱 *'),
            validator: requiredText,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: lessons,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: '購買堂數 *'),
                  validator: positiveInt,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: total,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: '總額 *'),
                  validator: nonNegative,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: note,
            maxLines: 2,
            decoration: const InputDecoration(labelText: '備註'),
          ),
          if (widget.initial == null) ...[
            const SizedBox(height: 18),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '本次付款（可留 0 稍後收款）',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: initialAmount,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: '付款金額'),
              validator: (v) {
                final amount = int.tryParse(v ?? '');
                final totalValue = int.tryParse(total.text) ?? 0;
                if (amount == null || amount < 0) return '金額不可小於 0';
                if (amount > totalValue) return '付款不可超過課程總額';
                return null;
              },
            ),
            const SizedBox(height: 12),
            DateField(controller: paymentDate, label: '付款日'),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: method,
              decoration: const InputDecoration(labelText: '付款方式'),
              items: paymentLabels.entries
                  .map(
                    (e) => DropdownMenuItem(value: e.key, child: Text(e.value)),
                  )
                  .toList(),
              onChanged: (v) => method = v ?? method,
            ),
          ],
          _submit(context, key, () {
            final amount = int.parse(initialAmount.text);
            return {
              'studentId': studentId,
              'coursePackageId': packageId,
              'purchaseDate': purchaseDate.text,
              'packageName': packageName.text.trim(),
              'purchasedLessons': int.parse(lessons.text),
              'totalAmount': int.parse(total.text),
              'note': note.text.trim(),
              if (widget.initial == null)
                'initialPayment': amount > 0
                    ? {
                        'amount': amount,
                        'paymentDate': paymentDate.text,
                        'paymentMethod': method,
                      }
                    : null,
            };
          }),
        ],
      ),
    ),
  );
}

class _PaymentForm extends StatefulWidget {
  final Purchase purchase;
  final Payment? initial;
  const _PaymentForm({required this.purchase, this.initial});
  @override
  State<_PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<_PaymentForm> {
  final key = GlobalKey<FormState>();
  late final date = TextEditingController(
    text: widget.initial?.paymentDate ?? today(),
  );
  late final amount = TextEditingController(
    text: (widget.initial?.amount ?? widget.purchase.outstandingAmount)
        .toString(),
  );
  late final note = TextEditingController(text: widget.initial?.note ?? '');
  late String method = widget.initial?.paymentMethod ?? 'Transfer';
  @override
  Widget build(BuildContext context) {
    final limit =
        widget.purchase.outstandingAmount + (widget.initial?.amount ?? 0);
    return _DialogFrame(
      widget.initial == null ? '新增付款' : '編輯付款',
      Form(
        key: key,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _metric('課程總額', money(widget.purchase.totalAmount)),
                  _metric('已付款', money(widget.purchase.paidAmount)),
                  _metric('尚欠', money(widget.purchase.outstandingAmount)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            DateField(
              controller: date,
              label: '付款日期 *',
              validator: requiredText,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: amount,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: '金額 *'),
              validator: (v) {
                final n = int.tryParse(v ?? '');
                if (n == null || n <= 0) return '付款金額需大於 0';
                if (n > limit) return '付款後不可超過課程總額';
                return null;
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: method,
              decoration: const InputDecoration(labelText: '付款方式'),
              items: paymentLabels.entries
                  .map(
                    (e) => DropdownMenuItem(value: e.key, child: Text(e.value)),
                  )
                  .toList(),
              onChanged: (v) => method = v ?? method,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: note,
              maxLines: 2,
              decoration: const InputDecoration(labelText: '備註'),
            ),
            _submit(
              context,
              key,
              () => {
                'paymentDate': date.text,
                'amount': int.parse(amount.text),
                'paymentMethod': method,
                'note': note.text.trim(),
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _metric(String l, String v) => Column(
    children: [
      Text(l, style: const TextStyle(fontSize: 12)),
      const SizedBox(height: 4),
      Text(v, style: const TextStyle(fontWeight: FontWeight.w800)),
    ],
  );
}

class _PackageForm extends StatefulWidget {
  final CoursePackage? initial;
  const _PackageForm({this.initial});
  @override
  State<_PackageForm> createState() => _PackageFormState();
}

class _PackageFormState extends State<_PackageForm> {
  final key = GlobalKey<FormState>();
  late final name = TextEditingController(text: widget.initial?.name ?? '');
  late final lessons = TextEditingController(
    text: (widget.initial?.lessons ?? 1).toString(),
  );
  late final price = TextEditingController(
    text: (widget.initial?.price ?? 0).toString(),
  );
  late final sort = TextEditingController(
    text: (widget.initial?.sortOrder ?? 0).toString(),
  );
  late bool active = widget.initial?.isActive ?? true;
  @override
  Widget build(BuildContext context) => _DialogFrame(
    widget.initial == null ? '新增課程方案' : '編輯課程方案',
    Form(
      key: key,
      child: Column(
        children: [
          TextFormField(
            controller: name,
            decoration: const InputDecoration(labelText: '名稱 *'),
            validator: requiredText,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: lessons,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: '堂數 *'),
            validator: positiveInt,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: price,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: '售價 *'),
            validator: nonNegative,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: sort,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: '排序 *'),
            validator: integer,
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('啟用方案'),
            value: active,
            onChanged: (v) => setState(() => active = v),
          ),
          _submit(
            context,
            key,
            () => {
              'name': name.text.trim(),
              'lessons': int.parse(lessons.text),
              'price': int.parse(price.text),
              'sortOrder': int.parse(sort.text),
              'isActive': active,
            },
          ),
        ],
      ),
    ),
  );
}

Widget _submit(
  BuildContext context,
  GlobalKey<FormState> key,
  Json Function() data,
) => Padding(
  padding: const EdgeInsets.only(top: 18),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('取消'),
      ),
      const SizedBox(width: 8),
      ElevatedButton(
        onPressed: () {
          if (key.currentState!.validate()) Navigator.pop(context, data());
        },
        child: const Text('儲存'),
      ),
    ],
  ),
);
String? requiredText(String? v) =>
    v == null || v.trim().isEmpty ? '此欄位為必填' : null;
String? positiveInt(String? v) {
  final n = int.tryParse(v ?? '');
  return n == null || n <= 0 ? '數值需大於 0' : null;
}

String? nonNegative(String? v) {
  final n = int.tryParse(v ?? '');
  return n == null || n < 0 ? '數值不可小於 0' : null;
}

String? integer(String? v) => int.tryParse(v ?? '') == null ? '請輸入整數' : null;
