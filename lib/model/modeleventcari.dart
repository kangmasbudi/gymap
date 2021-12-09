class Listevent {
  final int id;
  final String nama;
  final String deskripsi;
  final String tanggalmulai;
  final String tanggalselesai;
  final String jam;
  final String jamselesai;
  final String gambar;

  Listevent(
      {this.id,
      this.nama,
      this.deskripsi,
      this.tanggalmulai,
      this.tanggalselesai,
      this.gambar,this.jam,this.jamselesai});

  factory Listevent.fromJson(Map<String, dynamic> json) {
    return new Listevent(
        id: json['id'],
        nama: json['nama'],
        deskripsi: json['deskripsi'],
        tanggalmulai: json['tanggalmulai'],
        tanggalselesai: json['tanggalselesai'],
        gambar: json['gambar'],
        jam: json['jam'],
        jamselesai: json['jamselesai']
        );
  }
}
