library logmaster;
import 'dart:async';

class Logmaster {

  bool throw_exceptions = true; // if set to true, after reports have been sent, raises errors
  List report_adapters = [];
  List report_futures  = [];

  static const int DEBUG = 0; 
  static const int INFO  = 1; 
  static const int WARN  = 2; 
  static const int ERROR = 3; 
  static const int FATAL = 4; 

  Logmaster(this.report_adapters) {}

  capture(message, { log_level: null }) {

    if(log_level == null)
      if(message is Exception)
        log_level = ERROR;
      else
        log_level = INFO;

    report(message, log_level);

    if(message is Exception && throw_exceptions)
      throw(message);
  }

  /** Uses report adapters to send log messages to various targets */
  report(report, log_level) {

    // clean up from the  previous report() call
    report_futures = [];

    report_adapters.forEach((ra) {
      if(ra.log_level <= log_level)
        report_futures.add(new Future(() => ra.post(report)));
    });
  }

}
