class KomentarModel {
  DateTime? tanggal;
  String? name;
  String? komentar;

  KomentarModel({
    this.tanggal,
    this.name,
    this.komentar,
  });

  static KomentarModel fromJson(Map<String, dynamic> json) {
    return KomentarModel(
      tanggal: DateTime.parse(json["tanggal"]),
      name: json["name"],
      komentar: json["komentar"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "tanggal": tanggal?.toIso8601String(),
      "name": name,
      "komentar": komentar,
    };
  }

  static List<KomentarModel> dummy() {
    return [
      KomentarModel(
        tanggal: DateTime.now().add(const Duration(days: -1)),
        name: "Rocy",
        komentar: "Komentar 1",
      ),
      KomentarModel(
        tanggal: DateTime.now().add(const Duration(hours: -9)),
        name: "Dudung",
        komentar: "Komentar 2",
      ),
      KomentarModel(
        tanggal: DateTime.now().add(const Duration(minutes: -34)),
        name: "Yoman",
        komentar: "Komentar 3",
      ),
    ];
  }
}
