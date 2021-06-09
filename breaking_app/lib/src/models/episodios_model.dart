// Generated by https://quicktype.io
class Episodios {
  List<Episodio> items = [];

  Episodios.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final pelicula = new Episodio.fromJsonMap(item);
      items.add(pelicula);
    }
  }
}

class Episodio {
  int? episodeId;
  String? title;
  String? season;
  String? airDate;
  List<String>? characters;
  String? episode;
  String? series;

  Episodio({
    this.episodeId,
    this.title,
    this.season,
    this.airDate,
    this.characters,
    this.episode,
    this.series,
  });

  Episodio.fromJsonMap(Map<String, dynamic> json) {
    episodeId = json['episode_id'].cast<int>();
    title = json['title'];
    season = json['season'];
    airDate = json['air_date'];
    characters = json['characters'];
    episode = json['episode'];
    series = json['series'];
  }
}
