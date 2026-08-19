import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/formatters.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../widgets/common.dart';
import '../../widgets/forms.dart';

class LessonsPage extends ConsumerStatefulWidget {
  const LessonsPage({super.key});
  @override
  ConsumerState<LessonsPage> createState() => _LessonsPageState();
}

class _LessonsPageState extends ConsumerState<LessonsPage> {
  DateTime? fromDate, toDate;
  String? status;
  int? studentId;
  String? get from => fromDate == null ? null : apiDate(fromDate!);
  String? get to => toDate == null ? null : apiDate(toDate!);
  LessonQuery get query =>
      (from: from, to: to, studentId: studentId, status: status);
  Future<void> save({Lesson? lesson}) async {
    try {
      final students = await ref.read(allStudentsProvider.future);
      if (!mounted) return;
      final data = await showLessonForm(
        context,
        students: students,
        initial: lesson,
      );
      if (data == null) return;
      final repo = ref.read(lessonRepositoryProvider);
      final result = lesson == null
          ? await repo.create(data)
          : await repo.update(lesson.id, data);
      refreshBusinessData(ref);
      if (mounted) {
        showMessage(context, lesson == null ? '新增成功' : '修改成功');
        if (result.warning?.isNotEmpty == true) {
          showMessage(context, result.warning!);
        }
      }
    } catch (e) {
      if (mounted) showMessage(context, errorText(e), error: true);
    }
  }

  Future<void> remove(Lesson lesson) async {
    final ok = await confirmDelete(
      context,
      title: '刪除上課紀錄',
      message: '確定刪除 ${lesson.studentName} ${uiDate(lesson.lessonDate)} 的紀錄？',
    );
    if (!ok) return;
    try {
      await ref.read(lessonRepositoryProvider).delete(lesson.id);
      refreshBusinessData(ref);
      if (mounted) showMessage(context, '刪除成功');
    } catch (e) {
      if (mounted) showMessage(context, errorText(e), error: true);
    }
  }

  Future<void> pick(bool isFrom) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: (isFrom ? fromDate : toDate) ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selected != null) {
      setState(() {
        if (isFrom) {
          fromDate = selected;
        } else {
          toDate = selected;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final students = ref.watch(allStudentsProvider).value ?? [];
    final state = ref.watch(lessonsProvider(query));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageTitle(
          '上課紀錄',
          '記錄課程內容與每次身體狀況。',
          action: ElevatedButton.icon(
            onPressed: () => save(),
            icon: const Icon(Icons.add),
            label: const Text('新增上課紀錄'),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final fields = <Widget>[
                  InkWell(
                    onTap: () => pick(true),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: '開始日期',
                        suffixIcon: Icon(Icons.calendar_month),
                      ),
                      child: Text(
                        fromDate == null ? '—' : uiDate(apiDate(fromDate!)),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => pick(false),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: '結束日期',
                        suffixIcon: Icon(Icons.calendar_month),
                      ),
                      child: Text(
                        toDate == null ? '—' : uiDate(apiDate(toDate!)),
                      ),
                    ),
                  ),
                  DropdownButtonFormField<int?>(
                    initialValue: studentId,
                    decoration: const InputDecoration(labelText: '學員'),
                    items: [
                      const DropdownMenuItem<int?>(
                        value: null,
                        child: Text('全部學員'),
                      ),
                      ...students.map(
                        (s) =>
                            DropdownMenuItem(value: s.id, child: Text(s.name)),
                      ),
                    ],
                    onChanged: (v) => setState(() => studentId = v),
                  ),
                  DropdownButtonFormField<String?>(
                    initialValue: status,
                    decoration: const InputDecoration(labelText: '狀態'),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('全部狀態')),
                      ...lessonLabels.entries.map(
                        (e) => DropdownMenuItem(
                          value: e.key,
                          child: Text(e.value),
                        ),
                      ),
                    ],
                    onChanged: (v) => setState(() => status = v),
                  ),
                ];
                final clear = IconButton(
                  tooltip: '清除篩選',
                  onPressed:
                      fromDate != null ||
                          toDate != null ||
                          studentId != null ||
                          status != null
                      ? () => setState(() {
                          fromDate = null;
                          toDate = null;
                          studentId = null;
                          status = null;
                        })
                      : null,
                  icon: const Icon(Icons.filter_alt_off),
                );
                if (constraints.maxWidth >= 760) {
                  return Row(
                    children: [
                      for (var i = 0; i < fields.length; i++) ...[
                        Expanded(child: fields[i]),
                        if (i != fields.length - 1) const SizedBox(width: 12),
                      ],
                      const SizedBox(width: 4),
                      clear,
                    ],
                  );
                }
                final width = constraints.maxWidth >= 500
                    ? (constraints.maxWidth - 12) / 2
                    : constraints.maxWidth;
                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    ...fields.map(
                      (field) => SizedBox(width: width, child: field),
                    ),
                    clear,
                  ],
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 18),
        state.when(
          loading: () => const LoadingState(),
          error: (e, _) => ErrorState(
            error: e,
            onRetry: () => ref.invalidate(lessonsProvider(query)),
          ),
          data: (data) => data.isEmpty
              ? const EmptyState()
              : ResponsiveTable(
                  minWidth: 820,
                  columnSpacing: 26,
                  columns: const [
                    DataColumn(label: Text('日期')),
                    DataColumn(label: Text('學員')),
                    DataColumn(label: Text('狀態')),
                    DataColumn(label: Text('課程內容')),
                    DataColumn(label: Text('身體狀況')),
                    DataColumn(label: Text('操作')),
                  ],
                  rows: data
                      .map(
                        (x) => DataRow(
                          cells: [
                            DataCell(Text(uiDate(x.lessonDate))),
                            DataCell(Text(x.studentName)),
                            DataCell(StatusChip.lesson(x.status)),
                            DataCell(Text(x.content ?? '—')),
                            DataCell(Text(x.physicalCondition ?? '—')),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    tooltip: '編輯',
                                    onPressed: () => save(lesson: x),
                                    icon: const Icon(Icons.edit_outlined),
                                  ),
                                  IconButton(
                                    tooltip: '刪除',
                                    color: Colors.red,
                                    onPressed: () => remove(x),
                                    icon: const Icon(Icons.delete_outline),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
        ),
      ],
    );
  }
}
