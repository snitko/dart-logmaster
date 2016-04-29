import '../lib/logmaster.dart';
import "package:test/test.dart";

var reports = [];

class ReportAdapter1 {
  var log_level = 1;
  ReportAdapter1() {}
  post(r) => reports.add("report for $r added to ReportAdapter1");
}

class ReportAdapter2 {
  var log_level = 2;
  ReportAdapter1() {}
  post(r) => reports.add("report for $r added to ReportAdapter2");
}

void main() {

  var logmaster;

  setUp(() {
    var report_adapters = [new ReportAdapter1(), new ReportAdapter2()];
    logmaster = new Logmaster(report_adapters);
  });

  test("raises error if exception is passed", () {
    expect(() => logmaster.capture(new Exception("hello world")), throwsException);
    expect(() => logmaster.capture("Just a message"), returnsNormally);
  });

  test("reports error to all of the adapters with the log levels above or equal to the reported one", () {
    logmaster.capture("INFO message", log_level: 1);
    logmaster.capture("WARN message", log_level: 2);
    logmaster.report_futures[1].then((v) {
      expect(reports, equals([
        "report for INFO message added to ReportAdapter1",
        "report for WARN message added to ReportAdapter1",
        "report for WARN message added to ReportAdapter2"
      ]));
    });

  });

}
