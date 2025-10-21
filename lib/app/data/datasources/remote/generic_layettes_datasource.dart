import 'dart:convert';
import 'dart:developer';
import 'package:enxoval_baby/app/config/app_network.dart';
import 'package:enxoval_baby/app/core/failures/app_failure.dart';
import 'package:enxoval_baby/app/core/result/result.dart';
import 'package:enxoval_baby/app/domain/entities/layette_profile_entity.dart';
import 'package:http/http.dart' as http;


class GenericLayettesDatasource {
 static const String _baseUrl = AppNetwork.urlBaseVercel;
  final http.Client _client = http.Client();


  Future<Result<Map<String, dynamic>>> fetchGenericLayette(LayetteProfileEntity profile) async {
    try {
      final response = await _client.get(Uri.parse('$_baseUrl/generic_layette_${profile.climate.toCode()}.json'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Result.ok(data);
      } else {
        log('Erro ao executar fetchGenericLayette! statusCode: ${response.statusCode} - body: ${response.body}');
        return Result.error(ClientException(errorMessage: 'Erro ao gerar a lista de enxoval', statusCode: response.statusCode));
      }
    } on Exception catch (e, stackTrace) {
      log('Erro logout: $e\nStackTrace: $stackTrace');
      rethrow;
    }  catch (e, stackTrace) {
     log('Erro inesperado: $e\nStackTrace: $stackTrace');
      rethrow;
    }
    
  }
}