import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> fetchWpPosts() async {
  final response = await http.get(
      Uri.parse('https://www.divinafm.it/wp-json/wp/v2/posts?_embed'),
      headers: {"Accept": "application/json"});
  var convertDatatoJson = await json.decode(response.body);
  print(convertDatatoJson);
  return convertDatatoJson;
}
