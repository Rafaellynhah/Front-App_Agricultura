import 'dart:convert';
import 'package:http/http.dart' as http;

class tiporecurso_service {
  dynamic id;
  dynamic nome;

  tiporecurso_service({this.id, this.nome});

  factory tiporecurso_service.fromJson(Map<String, dynamic> json) {
    return tiporecurso_service(
      id: json['id'] as int,
      nome: json['nome'] as String,
    );
  }

  static const baseUrl = "http://10.0.2.2:8090";

  static Future<List<tiporecurso_service>> getExpenses() async {
    try{
      var url = baseUrl + "/tiporecurso";
      final response =
      await http.get(url, headers: {"Content-Type": "application/json"});
      if (200 == response.statusCode) {
        List<tiporecurso_service> list = parseResponse(response.body);
        return list;
      } else {
        return List<tiporecurso_service>();
      }
    }catch(e) {
      return List<tiporecurso_service>();
    }
  }

  static List<tiporecurso_service> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<tiporecurso_service>((json) => tiporecurso_service.fromJson(json))
        .toList();
  }

  static Future<dynamic> deletarTipoRecurso(String id) async {
    try {
      var url = baseUrl + "/tiporecurso/deletar/$id";
      final response =
      await http.delete(url, headers: {"Content-Type": "application/json"});
      if (200 == response.statusCode) {
        return response.statusCode;
      } else {
        return 'error';
      }
    } catch (e) {
      return 'error';
    }
  }


}
