import '../lib/report_adapters/http_report_adapter.dart';
import "package:test/test.dart";
import 'dart:html';

void main() {

  var adapter;

  setUp(() {
    adapter = new HttpReportAdapter("https://cors-test.appspot.com/test");
  });

  test("sends an ajax request and acknowledges a 200 response from the server", () {
    return adapter.post("message", 2).then((resp) {
      expect(resp.response, equals('{"status":"ok"}'));
    });
  });

}
