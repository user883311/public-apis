import 'dart:html'; // works client side (!= http, server-side)
import 'dart:convert';

main() async {
  var path = 'https://api.publicapis.org/entries';
  HttpRequest.getString(path).then((String fileContents) {
    var jsonResponse = new Map();
    jsonResponse = JSON.decode(fileContents);
    var apiList = new List();
    apiList = jsonResponse["entries"];

    // List headers = apiList[0].keys;
    var rowElements = new List();
    for (var item in apiList) {
      for (var value in item.values) {
        rowElements.add(value);
      }
    }
    DivElement table = document.getElementById("table");
    // addTableRow(table, headers, "headers");
    addTableRow(table, rowElements);
    
  }).catchError((Error error) {
    print(error.toString());
  });
}

void addTableRow(Element parent, List l) {
  for (var text in l) {
    var child1 = new DivElement();
    parent.children.add(child1);
    child1.text = text == "" ? "n/a" : text;
    // if (!className.isEmpty) child1.attributes["class"] = className;
    // if (!idName.isEmpty) child1.attributes["id"] = idName;
    child1.attributes["href"] = l[5].toString();
  }
}
