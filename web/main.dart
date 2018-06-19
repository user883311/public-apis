import 'dart:html'; // works client side (!= http, server-side)
import 'dart:convert';

main() async {
  var path = 'https://api.publicapis.org/entries';
  HttpRequest.getString(path).then((String fileContents) {
    var jsonResponse = new Map();
    jsonResponse = JSON.decode(fileContents);
    var apiList = new List();
    apiList = jsonResponse["entries"];
    
    var headers = new DivElement();
    document.body.children.add(headers);
    addTableRow(headers, apiList[0].keys);

    for (var api in apiList) {
      var a = new Element.a();
      document.body.children.add(a);
      a.attributes["href"] = api["Link"];

      var row = new DivElement();
      a.children.add(row);
      addTableRow(row, api.values);
    }
  }).catchError((Error error) {
    print(error.toString());
  });
}

void addTableRow(Element parent, List l) {
  for (var text in l) {
    var child1 = new DivElement();
    parent.children.add(child1);
    child1.text = text;
  }
}
