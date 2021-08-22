import 'package:correiostracking/trackinfo_model.dart';
import 'package:html/parser.dart' show parse;

class Parser {
  static List<TrackInfoModel>? run(String html) {
    var list = <TrackInfoModel>[];
    final doc = parse(html);

    final tables = doc.querySelectorAll('table');

    tables.forEach((table) {
      final datetime = table
          .getElementsByClassName('sroDtEvent')
          .first
          .innerHtml
          .split('<br>')
          .map((e) => e.trim())
          .where((element) => element.isNotEmpty)
          .toList();

      if (datetime[2].contains('style')) {
        final d = parse(datetime[2]);
        datetime[2] = d.getElementsByTagName('label').first.text;
      }

      final body = table.getElementsByClassName('sroLbEvent').first;
      final status = body.getElementsByTagName('strong').first.innerHtml;
      final locations = body.text.replaceFirst(status, '').trim();

      var from = '';
      var to = '';

      try {
        final splitlocation = locations.split('\n');

        from = (splitlocation[0].trimLeft() + splitlocation[1])
            .replaceAll('	', '');
        to = (splitlocation[2].trimLeft() + splitlocation[3])
            .replaceAll('	', '');
      } catch (err) {
        from = locations;
      }

      final track = TrackInfoModel(
        date: datetime[0],
        time: datetime[1],
        location: datetime[2],
        status: status.trim(),
        from: to.isEmpty ? '' : from.trimRight(),
        to: to.trim(),
        observation: to.isEmpty ? from.trimRight() : '',
      );

      list.add(track);
    });

    return list;
  }
}
