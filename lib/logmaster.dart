library logmaster;
import 'dart:async';

class Logmaster {

  bool throw_exceptions = true; // if set to true, after reports have been sent, raises errors
  List report_adapters = [];
  List report_futures  = [];

  static Map LOG_LEVELS = {
    'DEBUG': 0,
    'INFO' : 1,
    'WARN' : 2,
    'ERROR': 3,
    'FATAL': 4
  };

  Logmaster(this.report_adapters) {
    // Backreference to the object, which is going to be using those adapters.
    // Helps it with determining the LOG_LEVEL string version, for instance.
    this.report_adapters.forEach((ra) => ra.logmaster = this);
  }

  capture(message, { log_level: null }) {

    if(log_level == null)
      if(message is Exception)
        log_level = LOG_LEVELS['ERROR'];
      else
        log_level = LOG_LEVELS['INFO'];

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
        report_futures.add(new Future(() => ra.post(report, log_level)));
    });
  }
  
  log_level_as_string(int level) {
    for(var k in LOG_LEVELS.keys) {
      if(LOG_LEVELS[k] == level)
        return k;
    }
  }

}
