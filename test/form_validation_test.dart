import 'package:flutter_test/flutter_test.dart';
import 'package:pilates_flutter/widgets/forms.dart';

void main() {
  test('本機表單使用整數金額與堂數驗證', () {
    expect(requiredText(''), isNotNull);
    expect(requiredText('蕭宇筑'), isNull);
    expect(positiveInt('0'), isNotNull);
    expect(positiveInt('10'), isNull);
    expect(nonNegative('-1'), isNotNull);
    expect(nonNegative('1900'), isNull);
    expect(nonNegative('19.5'), isNotNull);
  });
}
