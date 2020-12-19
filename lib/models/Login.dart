class Login{
  int role_id;
  String role_name;
  String access_token;
  String token_type;
  String expires_at;

  Login(this.role_id, this.role_name, this.access_token, this.token_type, this.expires_at);

  factory Login.fromJson(dynamic json) {
    return Login(
        json['role_id'] as int,
        json['role_name'] as String,
        json['access_token'] as String,
        json['token_type'] as String,
        json['expires_at'] as String);
  }

  @override
  String toString() {
    return '{ ${this.role_id}, ${this.role_name}, ${this.access_token}, ${this.token_type}, ${this.expires_at} }';
  }
}