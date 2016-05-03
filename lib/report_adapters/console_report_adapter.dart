class ConsoleReportAdapter {

  var logmaster;
  int log_level = 1;

  post(r, level) {
    // Only print this message into the console if it's not an Error,
    // in which case logmaster would've already thrown it!
    if(!(r is Exception) || level < 3)
      print("${this.logmaster.log_level_as_string(level)}: $r");
  }

}
