typedef Json = Map<String, dynamic>;

class PagedResult<T> {
  final List<T> items;
  final int page, pageSize, totalCount, totalPages;
  const PagedResult(
    this.items,
    this.page,
    this.pageSize,
    this.totalCount,
    this.totalPages,
  );
}

class Student {
  final int id;
  final String name, joinDate;
  final String? phone;
  final int totalPurchasedLessons,
      usedLessons,
      remainingLessons,
      outstandingAmount;
  final bool isActive;
  const Student({
    required this.id,
    required this.name,
    this.phone,
    required this.joinDate,
    required this.totalPurchasedLessons,
    required this.usedLessons,
    required this.remainingLessons,
    required this.outstandingAmount,
    required this.isActive,
  });
}

class StudentStatistics {
  final int totalPurchasedLessons,
      usedLessons,
      remainingLessons,
      outstandingAmount;
  const StudentStatistics(
    this.totalPurchasedLessons,
    this.usedLessons,
    this.remainingLessons,
    this.outstandingAmount,
  );
}

class Lesson {
  final int id, studentId;
  final String studentName, lessonDate, status;
  final String? content, physicalCondition, note, warning;
  const Lesson({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.lessonDate,
    required this.status,
    this.content,
    this.physicalCondition,
    this.note,
    this.warning,
  });
}

class Payment {
  final int id;
  final String paymentDate, paymentMethod;
  final int amount;
  final String? note;
  const Payment({
    required this.id,
    required this.paymentDate,
    required this.amount,
    required this.paymentMethod,
    this.note,
  });
}

class Purchase {
  final int id, studentId;
  final String studentName, purchaseDate, packageName, paymentStatus;
  final int? coursePackageId;
  final String? note;
  final int purchasedLessons, totalAmount, paidAmount, outstandingAmount;
  final List<Payment> payments;
  const Purchase({
    required this.id,
    required this.studentId,
    required this.studentName,
    this.coursePackageId,
    required this.purchaseDate,
    required this.packageName,
    required this.purchasedLessons,
    required this.totalAmount,
    required this.paidAmount,
    required this.outstandingAmount,
    required this.paymentStatus,
    this.note,
    required this.payments,
  });
}

class StudentDetail {
  final int id;
  final String name, joinDate;
  final String? phone, note;
  final bool isActive;
  final StudentStatistics statistics;
  final List<Lesson> recentLessons;
  final List<Purchase> purchases;
  const StudentDetail({
    required this.id,
    required this.name,
    this.phone,
    required this.joinDate,
    this.note,
    required this.isActive,
    required this.statistics,
    required this.recentLessons,
    required this.purchases,
  });
}

class CoursePackage {
  final int id;
  final String name;
  final int lessons, price, sortOrder;
  final bool isActive;
  const CoursePackage({
    required this.id,
    required this.name,
    required this.lessons,
    required this.price,
    required this.isActive,
    required this.sortOrder,
  });
}

class TrendPoint {
  final String month;
  final int value;
  const TrendPoint(this.month, this.value);
}

class LowLessonStudent {
  final int id;
  final String name;
  final int remainingLessons;
  final String? lastLessonDate;
  const LowLessonStudent(
    this.id,
    this.name,
    this.remainingLessons,
    this.lastLessonDate,
  );
}

class DashboardData {
  final int monthlyRevenue,
      monthlyCompletedLessons,
      activeStudents,
      outstandingAmount;
  final List<LowLessonStudent> lowLessonStudents;
  final List<Lesson> recentLessons;
  final List<TrendPoint> revenueTrend, lessonTrend;
  const DashboardData({
    required this.monthlyRevenue,
    required this.monthlyCompletedLessons,
    required this.activeStudents,
    required this.outstandingAmount,
    required this.lowLessonStudents,
    required this.recentLessons,
    required this.revenueTrend,
    required this.lessonTrend,
  });
}

class MonthlyReportRow {
  final String month;
  final int revenue, completedLessons, purchasedLessons, newStudents;
  const MonthlyReportRow(
    this.month,
    this.revenue,
    this.completedLessons,
    this.purchasedLessons,
    this.newStudents,
  );
}

class ReportData {
  final int revenue, completedLessons, purchasedLessons, newStudents;
  final List<MonthlyReportRow> months;
  const ReportData(
    this.revenue,
    this.completedLessons,
    this.purchasedLessons,
    this.newStudents,
    this.months,
  );
}
