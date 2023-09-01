class UserConnected {
  final String auth_token;
  final UserOfLogin user;

  const UserConnected({required this.auth_token, required this.user});

  factory UserConnected.fromJson(Map<String, dynamic> json) {
    return UserConnected(
      auth_token: json['auth_token'],
      user: UserOfLogin.fromJson(json['user']),
    );
  }
}

class User {
  final int employeeId;
  final String uuid;

  final String firstname;
  final String lastname;
  final String phone;

  final String email;

  final String profile;
  final String organizationName;
  final String groupName;

  const User({
    required this.employeeId,
    required this.uuid,
    required this.organizationName,
    required this.groupName,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.email,
    required this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      employeeId: json["employeeId"],
      organizationName: json["organizationName"],
      uuid: json["uuid"],
      groupName: json["groupName"],
      firstname: json["firstname"],
      lastname: json["lastname"],
      phone: json["phone"],
      email: json["email"],
      profile: json["profile"],
    );
  }
}

class UserOfLogin {
  final int id;
  final String uuid;
  final String roleId;

  final String firstname;
  final String lastname;
  final String phone;
  final String phone_verified_at;

  final String email;
  final String email_verified_at;

  final String profile;
  final String status;
  final String created_at;
  final String updated_at;

  const UserOfLogin(
      {required this.id,
      required this.uuid,
      required this.email_verified_at,
      required this.created_at,
      required this.firstname,
      required this.lastname,
      required this.phone,
      required this.email,
      required this.profile,
      required this.phone_verified_at,
      required this.roleId,
      required this.status,
      required this.updated_at});

  factory UserOfLogin.fromJson(Map<String, dynamic> json) {
    return UserOfLogin(
      id: json["id"],
      uuid: json["uuid"],
      roleId: json["roleId"],
      firstname: json["firstname"],
      lastname: json["lastname"],
      phone: json["phone"],
      email: json["email"],
      profile: json["profile"],
      phone_verified_at: json["phone_verified_at"],
      email_verified_at: json["email_verified_at"],
      status: json["status"],
      created_at: json["created_at"],
      updated_at: json["updated_at"],
    );
  }
}
