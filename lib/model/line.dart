import 'package:pfe_salim/model/user.dart';

class Line {
  int id;
  int quantity;
  User user;

  Line({
    this.id = -1,
    required this.quantity,
    required this.user,
  });

  factory Line.fromJson(Map<String, dynamic> json) {
    return Line(
      id: json['id'],
      quantity: json['quantity'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "quantity": quantity,
      "user": user.toJson(),
    };
  }
}
