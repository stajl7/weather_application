class Coord {
  double? lon;
  double? lat;

  Coord({this.lon, this.lat});

  Coord.fromJson(Map<String, dynamic> json) {
    lon = (json['coord']['lon'] as num?)?.toDouble() ?? 0.0;
    lat = (json['coord']['lat'] as num?)?.toDouble() ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['lon'] = lon;
    data['lat'] = lat;
    return data;
  }
}