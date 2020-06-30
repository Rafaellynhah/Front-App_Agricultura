import 'dart:convert';
import 'package:http/http.dart' as http;

class ResourseServices {
  dynamic id;
  dynamic nome;
  dynamic qtdInicial;
  dynamic qtdFinal;
  dynamic produtividadeEsperada;
  dynamic produtividade;
  dynamic problema;
  dynamic tipoRecurso;

  ResourseServices({
    this.id,
    this.nome,
    this.qtdInicial,
    this.qtdFinal,
    this.produtividadeEsperada,
    this.produtividade,
    this.problema,
    this.tipoRecurso,
  });

  factory ResourseServices.fromJson(Map<String, dynamic> json) {
    return ResourseServices(
      id: json['id'] as int,
      nome: json['nome'] as String,
      qtdInicial: json['qtd_inicial'] as int,
      qtdFinal: json['qtd_final'] as int,
      produtividadeEsperada: json['produtividade_esperada'] as int,
      produtividade: json['produtividade'] as double,
      problema: json['problema'] as String,
      tipoRecurso: json['tp_recurso_id'] as int,
    );
  }

  static const baseUrl = "http://10.0.2.2:8090";

  static Future<List<ResourseServices>> getResources() async {
    try {
      var url = baseUrl + "/recursos";
      final response =
          await http.get(url, headers: {"Content-Type": "application/json"});
      if (200 == response.statusCode) {
        List<ResourseServices> listResources = parseResponse(response.body);
        return listResources;
      } else {
        return List<ResourseServices>();
      }
    } catch (e) {
      return List<ResourseServices>();
    }
  }

  static List<ResourseServices> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<ResourseServices>((json) => ResourseServices.fromJson(json))
        .toList();
  }
}
