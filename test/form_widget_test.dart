import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pilates_flutter/models/models.dart';
import 'package:pilates_flutter/widgets/forms.dart';

const student = Student(
  id: 7,
  name: '蕭宇筑',
  joinDate: '2026-08-18',
  totalPurchasedLessons: 0,
  usedLessons: 0,
  remainingLessons: 0,
  outstandingAmount: 0,
  isActive: true,
);

const purchase = Purchase(
  id: 3,
  studentId: 7,
  studentName: '蕭宇筑',
  purchaseDate: '2026-08-18',
  packageName: '1堂',
  purchasedLessons: 1,
  totalAmount: 1900,
  paidAmount: 0,
  outstandingAmount: 1900,
  paymentStatus: 'Unpaid',
  payments: [],
);

Widget harness(Future<dynamic> Function(BuildContext) open) => MaterialApp(
  home: Builder(
    builder: (context) => Scaffold(
      body: ElevatedButton(
        onPressed: () => open(context),
        child: const Text('開啟'),
      ),
    ),
  ),
);

Future<void> openAndSubmit(WidgetTester tester, Widget widget) async {
  await tester.pumpWidget(widget);
  await tester.tap(find.text('開啟'));
  await tester.pumpAndSettle();
  await tester.ensureVisible(find.text('儲存'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('儲存'));
  await tester.pump();
}

void main() {
  testWidgets('Student Form 姓名必填', (tester) async {
    await openAndSubmit(
      tester,
      harness((context) async => showStudentForm(context)),
    );
    expect(find.text('此欄位為必填'), findsOneWidget);
  });

  testWidgets('Lesson Form 學員必選且 value 是 int', (tester) async {
    await openAndSubmit(
      tester,
      harness(
        (context) async => showLessonForm(context, students: const [student]),
      ),
    );
    expect(find.text('請選擇學員'), findsOneWidget);
    final field = tester.widget<DropdownButtonFormField<int>>(
      find.byType(DropdownButtonFormField<int>),
    );
    expect(field.initialValue, isNull);
  });

  testWidgets('Purchase Form 學員必選且 value 是 int', (tester) async {
    await openAndSubmit(
      tester,
      harness(
        (context) async => showPurchaseForm(
          context,
          students: const [student],
          packages: const [],
        ),
      ),
    );
    expect(find.text('請選擇學員'), findsOneWidget);
  });

  testWidgets('Payment Form 金額必須大於零', (tester) async {
    await tester.pumpWidget(
      harness((context) async => showPaymentForm(context, purchase: purchase)),
    );
    await tester.tap(find.text('開啟'));
    await tester.pumpAndSettle();
    final amountField = find.byType(TextFormField).at(1);
    await tester.enterText(amountField, '0');
    await tester.tap(find.text('儲存'));
    await tester.pump();
    expect(find.text('付款金額需大於 0'), findsOneWidget);
  });
}
