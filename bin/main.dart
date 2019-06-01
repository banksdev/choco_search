import 'package:choco_search/choco_search.dart' as choco_search;

import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'package:http/http.dart' as http;

const String QueryURL = "https://chocolatey.org/search?q=";

main(List<String> arguments) {
  if (arguments.isEmpty) {
    print("Too few arguments...");
    return;
  }

  if (arguments.length > 1) {
    print("Too many arguments...");
    return;
  }

  var query = arguments[0];
  var searchResultListRegex = RegExp(
    r'<ol id=\"searchResults\">[\s\S]*<\/ol>', 
    caseSensitive: false,
    multiLine: true,
  );

  print("fetching results...");
  http.get(QueryURL + query).then((response) {
    print("parsing expression...");
    var searchResultList = searchResultListRegex.allMatches(response.body);
    
    

    print(searchResultList);
  });


}
