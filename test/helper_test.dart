import 'package:flutter_test/flutter_test.dart';
import 'package:itinerary/helper/helper.dart';

void main() {
  test('format date from iso8601 to readable date', () {
    final date = DateTime(2025, 12, 24, 11, 34, 12);
    final formattedDate = Helper.formatDate(date);

    expect(formattedDate, "24 December 2025");
  });
}
