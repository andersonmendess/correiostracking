import 'package:correiostracking/parser.dart';
import 'package:http/http.dart' as http;

class Correios {
  static Future<String?> getTrackInfo(String code) async {
    final _consultUrl =
        'https://www2.correios.com.br/sistemas/rastreamento/ctrl/ctrlRastreamento.cfm?';
    final _resultUrl =
        'https://www2.correios.com.br/sistemas/rastreamento/resultado.cfm';

    final consultResponse = await http.post(
      Uri.parse(_consultUrl),
      body: {
        'content-type': 'multipart/form-data',
        'acao': 'track',
        'objetos': code,
      },
    );

    final cookie = consultResponse.headers['set-cookie'];

    if (cookie == null || cookie.isEmpty) return null;

    final resultResponse = await http.get(Uri.parse(_resultUrl), headers: {
      'cookie': cookie,
      'host': 'www2.correios.com.br',
      'referer':
          'https://www2.correios.com.br/sistemas/rastreamento/default.cfm'
    });

    return resultResponse.body;
  }
}
