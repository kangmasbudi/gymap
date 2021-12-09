class Listprodukcari {
  final int idproduc;
  final String nama;
  final String harga;
  final String deskripsi;
  final String gambar;

  Listprodukcari({this.idproduc, this.nama,this.harga, this.deskripsi, this.gambar});

  factory Listprodukcari.fromJson(Map<String, dynamic> json) {
    return new Listprodukcari(
      idproduc: json['idproduc'],
      nama: json['nama'],
      harga: json['harga'],
      deskripsi: json['deskripsi'],
      gambar: json['gambar'],
    );
  }
}
