class User {

  int? id;
  String? name;
  String? email;
  String? password;

  User({this.id, this.name, this.email, this.password});

  User.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'] ?? 0;
    name = map['name'] ?? '';
    email = map['email'] ?? '';
    password = map['password'] ?? '';
  }

  Map<String, Object?> toMap() {
    Map<String, Object?> map = {
      "id": id,
      "name": name,
      "email": email,
      "password": password
    };
    if(id != null) {
      map['userId'] = id;
    }
    return map;
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, password: $password}';
  }
}