import 'package:choco_search/choco_search.dart' as choco_search;

import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'package:http/http.dart' as http;

const String queryURL = "https://chocolatey.org/search?q=";
const double version = 0.1;
const String helpMessage = 
"""
Possible uses:
  choco_search [query] ([option])
  choco_search --help
  choco_search --version

Possible options:
  [1..]     | When given a number, the query will return that many results. Default is 5.
  [--desc]  | Returns detailed information about one specific package
  [--open]  | Opens the page for the given package
""";

var packageRegex = RegExp(
    r'<section class=\"package\s\">[\s\S]*?<\/section>',
    caseSensitive: false,
    multiLine: true,
  );

main(List<String> arguments) {
  if (arguments.isEmpty) {
    print("Too few arguments... use --help for help");
    return;
  }

  if (arguments.length > 2) {
    print("Too many arguments...");
    return;
  }

  String option = null;
  if (arguments.length == 2) {
    if (validOption(arguments[1])) {
          option = arguments[1];
    }
    else {
      print("Invalid option provided... Use --help to see valid options");
      return;
    }
  }

  if (option == null)
    simpleQuery(arguments[0]);
  else
    optionQuery(arguments[0], option);

}
    
bool validOption(String option) {

  // A number is a valid argument
  try {
    if (int.parse(option) != null) return true;
  } on FormatException catch(e) {
    
  }

  switch (option) {
    case "--desc": return true;
    case "--open": return true;
  }

  return false;
}

void simpleQuery(String query) {
   http.get(queryURL + query).then((response) {

    var res = packageRegex.allMatches(response.body);
    res.take(5).forEach((m) {
      var title = getTitle(m);
      var packageVersion = getVersion(m);
      var downloads = getDownloads(m);
      var installPhrase = getInstallPhrase(m);

      print("Package: $title | Version: $packageVersion | Downloads: $downloads\nInstall: '$installPhrase'\n");
    });

  });
}

void optionQuery(String argument, String option) {
}

var titleVersionRegex = RegExp(
  r'<a href="\/packages\/([\s\S]+?)\/([\d|\.]+)',
  caseSensitive: false,
  multiLine: true,
);
String getTitle(Match match) {
  var matchString = match.input.substring(match.start, match.end + 1);
  var titleVersionMatch = titleVersionRegex.firstMatch(matchString);
  return titleVersionMatch.group(1).trim();
}

String getVersion(Match match) {
  var matchString = match.input.substring(match.start, match.end + 1);
  var titleVersionMatch = titleVersionRegex.firstMatch(matchString);
  return titleVersionMatch.group(2).trim();
}

var downloadsRegex = RegExp(
  r'<p class="downloads">([\s\S]+)<\/p>',
  caseSensitive: false,
  multiLine: true,
);
String getDownloads(Match match) {
  var matchString = match.input.substring(match.start, match.end + 1);
  var downloadsMatch = downloadsRegex.firstMatch(matchString);
  return downloadsMatch.group(1).trim();
}

var descriptionRegex = RegExp(
  r'<p>([\s\S]+?)<\/p>',
  caseSensitive: false,
  multiLine: true,
);
String getDescription(Match match) {
  var matchString = match.input.substring(match.start, match.end + 1);
  var descriptionMatch = descriptionRegex.firstMatch(matchString);
  return descriptionMatch.group(1).trim();
}

var installRegex = RegExp(
  r'(choco install [\s\S]+?)<\/code>',
  caseSensitive: false,
  multiLine: true,
);
String getInstallPhrase(Match match) {
  var matchString = match.input.substring(match.start, match.end + 1);
  var installPhraseMatch = installRegex.firstMatch(matchString);
  return installPhraseMatch.group(1).trim();
}