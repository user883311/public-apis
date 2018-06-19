import 'dart:html'; // works client side (!= http, server-side)
import 'dart:convert';

main() async {
  var path = 'https://api.publicapis.org/entries';
  HttpRequest.getString(path).then((String fileContents) {
    var jsonResponse = new Map();
    jsonResponse = JSON.decode(fileContents);
    var apiList = new List();
    apiList = jsonResponse["entries"];

    // build headers
    var h = new List();
    var headers = new List();
    h = apiList[0].keys;
    for (var item in h) {
      headers.add(item);
    }

    // build rows
    var rowElements = new List();
    for (var item in apiList) {
      for (var value in item.values) {
        rowElements.add(value);
      }
    }

    DivElement table = document.getElementById("table");
    addTableRow(table, headers, "headers");
    addTableRow(table, rowElements, "rows");
  }).catchError((Error error) {
    print(error.toString());
  });
}

void addTableRow(Element parent, List l,
    [String className = "", String idName = ""]) {
  for (var text in l) {
    var child1 = new DivElement();
    parent.children.add(child1);
    child1.text = text == "" ? "n/a" : text;
    if (className.isNotEmpty) child1.attributes["class"] = className;
    if (idName.isNotEmpty) child1.attributes["id"] = idName;
    child1.attributes["href"] = l[5].toString();
  }
}
