class Listpaket {
  final int id;
  final String namapaket;
  final String tarif;
  final String jumlahhari;
  final String deskripsi;
  final String gambar;

  Listpaket({this.id, this.namapaket, this.tarif, this.jumlahhari,this.deskripsi,this.gambar});

  factory Listpaket.fromJson(Map<String, dynamic> json) {
    return new Listpaket(
      id: json['id'],
      namapaket: json['namapaket'],
      tarif: json['tarif'],
      jumlahhari: json['jumlahhari'],
      deskripsi: json['deskripsi'],
      gambar: json['gambar'],
    );
  }
}
