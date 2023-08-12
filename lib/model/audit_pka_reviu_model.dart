class AuditPKAReviuModel {
  String? id;
  String? judul;
  String? langkahKerja;
  String? pelaksana;
  int? waktuhari;
  String? status;
  String? catatan;

  AuditPKAReviuModel({
    this.id,
    this.judul,
    this.langkahKerja,
    this.pelaksana,
    this.waktuhari,
    this.status,
    this.catatan,
  });

  static AuditPKAReviuModel fromJson(Map<String, dynamic> json) {
    return AuditPKAReviuModel(
      id: json["id"],
      judul: json["judul"],
      langkahKerja: json["langkah_kerja"],
      pelaksana: json["pelaksana"],
      waktuhari: json["waktu_hari"],
      status: json["status"],
      catatan: json["catatan"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "judul": judul,
      "langkah_kerja": langkahKerja,
      "pelaksana": pelaksana,
      "waktu_hari": waktuhari,
      "status": status,
      "catatan": catatan,
    };
  }

  static List<AuditPKAReviuModel> dummys() {
    return [
      AuditPKAReviuModel(
        id: "1",
        judul: "A ASET",
        langkahKerja:
            "A.1 Penilaian \n1. Periksa akun biaya perbaikan dan pemeliharaan \n 2. Analisa kewajaran biaya penyusutan berdasarkan nilai \nperolehan aktiva dan tarif depresiasi yang berlaku \n3. Lakukan test penghitungan kembali penyusutan",
        pelaksana: "Agus Mirazul Fajar",
        waktuhari: 5,
        status: null,
        catatan: "",
      ),
      AuditPKAReviuModel(
        id: "2",
        judul: "A ASET",
        langkahKerja:
            "A.2 Kelengkapan\n1. Dapatkan daftar dari aktiva tetap, penambahan, penghapusan dan pergerakan aktiva\nselama tahun berjalan\n2. Periksa penambahan aktiva tetap dalam tahun berjalan\n3. Periksa pengurangan/penghapusan aktiva dalam tahun berjalan",
        pelaksana: "Agus Mirazul Fajar",
        waktuhari: 2,
        status: null,
        catatan: "",
      ),
      AuditPKAReviuModel(
        id: "3",
        judul: "DIVISI BISNIS II",
        langkahKerja:
            "B.1 Identifikasi Kendala\n1. Mengevaluasi kinerja Divisi Bisnis III",
        pelaksana: "Andreas Theodorus Mokodaser",
        waktuhari: 10,
        status: null,
        catatan: "",
      ),
    ];
  }
}
