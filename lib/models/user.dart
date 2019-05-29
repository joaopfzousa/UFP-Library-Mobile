class User {
  String number = '';
  String password = '';
  String token = '';

  User({this.number, this.password});
  User.authenticatedUser({this.number, this.token});

  factory User.fromJson(Map<String, dynamic> json) => new User.authenticatedUser (
    number: json['number'],
    token: json['token']
  );

  Map toMap() {
    var map = new Map<String, dynamic>();
    
    map["number"] = number;
    map["password"] = password;

    return map;
  }
}