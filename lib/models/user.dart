class UserModel {
  String uid;
  String name;
  String email;
  String profilePic;
  String phone;
  bool isVerified;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.profilePic = "",
    this.phone = "",
    this.isVerified = false,
  });

  // Convert UserModel to JSON (for Firestore)
  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "profilePic": profilePic,
      "phone": phone,
      "isVerified": isVerified,
    };
  }

  // Convert Firestore JSON to UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"],
      name: json["name"],
      email: json["email"],
      profilePic: json["profilePic"] ?? "",
      phone: json["phone"] ?? "",
      isVerified: json["isVerified"] ?? false,
    );
  }
}