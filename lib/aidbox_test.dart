import 'dart:convert';

import 'package:fhir/fhir_r4.dart';
import 'package:http/http.dart' as http;

Future getResponse() async {
  var server = 'https://testhospipal.aidbox.app/';
  var headers = {'Content-type': 'application/json'};
  var identifier = 'test-client';
  var secret = 'verysecret';
  var grantType = 'client_credentials';
  var response1 = await http.post(
      '$server/auth/token?client_id=$identifier&grant_type=$grantType&client_secret=$secret',
      headers: headers);
  if (response1.statusCode == 200) {
    var parsedbody = json.decode(response1.body);
    print("here");
    print(parsedbody);
    var token = parsedbody['token_type'] + ' ' + parsedbody['access_token'];
    print(token);
    headers.putIfAbsent('Authorization', () => token);
  }

  var response2 = await http.get('$server/fhir/Patient/c81c85b8-a48c-41b4-a6d4-07cbdbb60c51', headers: headers);
  var test = json.decode(response2.body);
  print("Patient from aidbox: "+test);
  var patient = Patient.fromJson(json.decode(response2.body));
  print(patient);
  //print(bundle.id);
  print('');


  var response3 = await http.get('$server/metadata', headers: headers);
  var test2 = json.decode(response3.body);
  print(test2);
  var capStatement = CapabilityStatement.fromJson(json.decode(response3.body));

//  print(capStatement);
//  var response4 = await http.get(
//         '$server/fhir/Observation?patient=test123&category=vital-signs',
//         headers: headers);
//  var test3 = json.decode(response4.body);
//  print(test3);
}

void main(List<String> arguments) {
  print(getResponse());
}
