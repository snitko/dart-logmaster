import 'dart:html';

class HttpReportAdapter {

  var    logmaster;
  int    log_level = 2;
  String url;

  HttpReportAdapter(this.url) {}

  post(r, level, [stack_trace=""]) {

    var data = {
      'message'   : r,
      'log_level' : log_level.toString(),
    };

    if(this.logmaster != null)
      data['log_level_string'] = this.logmaster.log_level_as_string(level);
    
    return makeAjaxRequest({ "error": "${data["message"]}\nStack trace:\n$stack_trace" });

  }

  makeAjaxRequest(data) {
    return HttpRequest.postFormData(this.url, data);
  }

}
