class Personaje {
  int? charId;
  String? name;
  String? birthday;
  List<String>? occupation;
  String? img;
  String? status;
  String? nickname;
  List<int>? appearance;
  String? portrayed;
  String? category;
  List<int>? betterCallSaulAppearance;

  Personaje(
    this.charId,
    this.name,
    this.birthday,
    this.occupation,
    this.img,
    this.status,
    this.nickname,
    this.appearance,
    this.portrayed,
    this.category,
    this.betterCallSaulAppearance,
  );

  //get
  get getCharId => this.charId;
  get getName => this.name;
  get getBirthday => this.birthday;
  get getOccupation => this.occupation;
  get getImg => this.img;
  get getStatus => this.status;
  get getNickName => this.nickname;
  get getApparence => this.appearance;
  get getPortrayed => this.portrayed;
  get getCategory => this.category;
  get getbetterCallSaulAppearance => this.betterCallSaulAppearance;

//get data del json
  factory Personaje.fromJSON(Map<String, dynamic> json) {
    return new Personaje(
        int.parse(json['char_id'].toString()),
        json['name'].toString(),
        json['birthday'].toString(),
        json['occupation'],
        json['img'].toString(),
        json['satus'].toString(),
        json['nickname'].toString(),
        json['appearance'],
        json['portrayed'].toString(),
        json['category'].toString(),
        json['better_call_saul_appearance']);
  }
}
