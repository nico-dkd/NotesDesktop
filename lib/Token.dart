class Token {

final String bearer;

  Token({bearer}): this.bearer = "Bearer " + bearer;
    Token.fromJson(Map<String, dynamic> json)
    : bearer = "Bearer " + json['token'];
}