import 'dart:convert';
import 'package:advicer/0_data/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;
import '../models/advice_model.dart';

abstract class AdviceRemoteDatasource {
  /// requests a random advice from api
  /// returns [AdviceModel] if successful
  /// throws a server-Exception if status code is not 200
  Future<AdviceModel> getRandomAdviceFromApi(int? id);
}

//  https://www.flutter-community.de/
class AdviceRemoteDatasourceImpl implements AdviceRemoteDatasource {
  final http.Client client;
  AdviceRemoteDatasourceImpl({required this.client});
  // ! final client = http.Client();
  @override
  Future<AdviceModel> getRandomAdviceFromApi(int? id) async {
    String advice = id == null ? 'advice' : 'advice/$id';
    final response = await client.get(
      Uri.parse('https://api.flutter-community.com/api/v1/$advice'),
      headers: {
        // 'accept': 'application/json',
        'content-type': 'application/json'
      },
    );
    if (response.statusCode != 200) {
      throw ServerException(
         message: 'status code: ${response.statusCode.toString()}');
    } else {
      //  parse the string and return a json object
      try {
        final responseBody = json.decode(response.body);
        return AdviceModel.fromJson(responseBody);
      } catch (e) {
        //  print(e.toString());
        throw DataExceptions(message: e.toString());
      }
    }
  }
}
