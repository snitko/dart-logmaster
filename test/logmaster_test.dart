import '../lib/logmaster.dart';
import '../lib/report_adapters/console_report_adapter.dart';
import "package:test/test.dart";

var reports = [];

class ReportAdapter1 {
  var logmaster;
  var log_level = 1;
  post(r, level) => reports.add("report for log level $level added to ReportAdapter1");
}

class ReportAdapter2 {
  var logmaster;
  var log_level = 2;
  post(r, level) => reports.add("report for log level $level added to ReportAdapter2");
}

void main() {

  var logmaster;

  setUp(() {
    reports = [];
    var report_adapters = [new ReportAdapter1(), new ReportAdapter2(), new ConsoleReportAdapter()];
    logmaster = new Logmaster(report_adapters);
  });

  test("raises error if exception is passed", () async {
    expect(() => logmaster.capture(new Exception("hello world")), throws);
    expect(() => logmaster.capture("Just a message"), returnsNormally);
  });

  test("reports error to all of the adapters with the log levels above or equal to the reported one", () async {
    logmaster.capture("info message", log_level: 1);
    logmaster.capture("warn message", log_level: 2);
    logmaster.report_futures[1].then((v) {
      expect(reports, equals([
        "report for log level 1 added to ReportAdapter1",
        "report for log level 2 added to ReportAdapter1",
        "report for log level 2 added to ReportAdapter2"
      ]));
    });
  });

}
