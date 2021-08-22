library correiostracking;

import 'package:correiostracking/correios.dart';
import 'package:correiostracking/parser.dart';
import 'package:correiostracking/trackinfo_model.dart';

class CorreiosTracking {
  static Future<List<TrackInfoModel>?> track(String code) async {
    if (code.isEmpty) return null;

    final html = await Correios.getTrackInfo(code);

    if (html == null || html.isEmpty) return null;

    return Parser.run(html);
  }
}
