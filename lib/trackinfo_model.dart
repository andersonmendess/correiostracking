class TrackInfoModel {
  late String date;
  late String time;
  late String location;
  late String status;
  late String to;
  late String from;
  late String observation;

  TrackInfoModel({
    required this.date,
    required this.time,
    required this.observation,
    required this.from,
    required this.location,
    required this.status,
    required this.to,
  });

  @override
  String toString() {
    // ignore: prefer_single_quotes
    return """
    location: $location
    date: $date,
    time: $time,
    from: $from,
    to: $to,
    title: $status,
    observation: $observation
    """;
  }
}
