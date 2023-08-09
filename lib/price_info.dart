import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' show jsonDecode;

String? strresponce='';
Map mapresponse='a:b' as Map;
Map datarar ='' as Map;

Future<String> getdata(String s) async {
  http.Response response;

  // Needs internet to work.

  response = await http
      .get(Uri.parse('https://blockchain.info/ticker'));
  mapresponse= jsonDecode(response.body);
  datarar = mapresponse[s];
  return (datarar['15m'].toString());

}

