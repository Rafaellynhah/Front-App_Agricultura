import 'dart:convert';
import 'package:http/http.dart' as http;

class ExpensesServices {
  dynamic id;
  dynamic mes;
  dynamic qtdMensal;
  dynamic tp_gasto;

  ExpensesServices({this.id, this.mes, this.qtdMensal, this.tp_gasto});

  factory ExpensesServices.fromJson(Map<String, dynamic> json) {
    return ExpensesServices(
      id: json['id'] as int,
      mes: json['mes'] as String,
      qtdMensal: json['qtd_mensal'] as double,
      tp_gasto: json['tp_gasto'] as int,
    );
  }

  static const baseUrl = "http://10.0.2.2:8090";

  static Future<List<ExpensesServices>> getExpenses() async {
    try{
      var url = baseUrl + "/gasto";
      final response =
      await http.get(url, headers: {"Content-Type": "application/json"});
      if (200 == response.statusCode) {
        List<ExpensesServices> list = parseResponse(response.body);
        return list;
      } else {
        return List<ExpensesServices>();
      }
    }catch(e) {
      return List<ExpensesServices>();
    }
  }

  static List<ExpensesServices> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<ExpensesServices>((json) => ExpensesServices.fromJson(json))
        .toList();
  }

  static Future<dynamic> deletarGasto(String id) async {
    try {
      var url = baseUrl + "/gasto/deletar/$id";
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
