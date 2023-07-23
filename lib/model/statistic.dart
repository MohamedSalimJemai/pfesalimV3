class Statistic {
  int id;
  int value;

  Statistic({
    this.id = -1,
    required this.value,
  });

  factory Statistic.fromJson(Map<String, dynamic> json) {
    return Statistic(
      id: json['id'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
    };
  }
}
