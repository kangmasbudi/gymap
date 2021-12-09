class Listtrainer {
  final int id;
  final String nama;
  final String tarif;
  final String hp;
    final String gambar;

  Listtrainer({this.id, this.nama, this.tarif, this.hp,this.gambar});

  factory Listtrainer.fromJson(Map<String, dynamic> json) {
    return new Listtrainer(
      id: json['id'],
      nama: json['nama'],
      tarif: json['tarif'],
      hp: json['hp'],
      gambar: json['gambar'],
    );
  }
}
