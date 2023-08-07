class ActionModel {
  String? label;
  String? value;
  String? description;

  ActionModel({
    this.label,
    this.value,
    this.description,
  });

  ActionModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'value': value,
      'description': description,
    };
  }

  static List<ActionModel> actionReviuKKA() {
    return [
      ActionModel(
        label: "Setujui",
        value: "Disetujui",
        description: "menyetujui",
      ),
      ActionModel(
        label: "Tolak KKA",
        value: "Ditolak",
        description: "Menolak",
      ),
    ];
  }
}
