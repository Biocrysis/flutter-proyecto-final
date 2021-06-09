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

//get data del json
  factory Personaje.fromJsonMap(Map<String, dynamic> json) {
    return Personaje(
        int.parse(json['char_id'].toString()),
        json['name'],
        json['birthday'],
        json['occupation'],
        json['img'],
        json['satus'],
        json['nickname'],
        json['appearance'].cast<int>(),
        json['portrayed'],
        json['category'],
        json['better_call_saul_appearance']);
    /*  charId = json['char_id'],
      name = json['name'],
      birthday = json['birthday'],
      occupation = json['occupation'],
      img = json['img'],
      status = json['satus'];
      nickname = json['nickname'];
      appearance = json['appearance'].cast<int>();
      portrayed = json['portrayed'];
      category = json['category'];
      betterCallSaulAppearance = json['better_call_saul_appearance']; */
  }

  getImgPersonaje() {
    if (img != null) {
      return img;
    }
  }
}
