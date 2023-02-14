// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

class UserModel {
  UserModel({
    required this.token,
    required this.user,
    required this.expires,
    required this.expiresIn,
  });

  String? token;
  User? user;
  String? expires;
  int? expiresIn;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        token: json["token"],
        user: User.fromJson(json["user"]),
        expires: json["expires"],
        expiresIn: json["expires_in"],
      );

  Map<String, dynamic> toJson() => {
        "token": token!,
        "user": user!.toJson(),
        "expires": expires!,
        "expires_in": expiresIn!,
      };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.twoFactorSecret,
    required this.twoFactorRecoveryCodes,
    required this.twoFactorConfirmed,
    required this.twoFactorEmailConfirmed,
    required this.image,
    required this.mobile,
    required this.gender,
    required this.salutation,
    required this.locale,
    required this.status,
    required this.login,
    required this.onesignalPlayerId,
    required this.lastLogin,
    required this.emailNotifications,
    required this.countryId,
    required this.darkTheme,
    required this.rtl,
    required this.twoFaVerifyVia,
    required this.twoFactorCode,
    required this.twoFactorExpiresAt,
    required this.adminApproval,
    required this.permissionSync,
    required this.imageUrl,
    required this.role,
    required this.clientDetails,
    required this.session,
    required this.employeeDetail,
  });

  int? id;
  String? name;
  String? email;
  String? twoFactorSecret;
  String? twoFactorRecoveryCodes;
  int? twoFactorConfirmed;
  int? twoFactorEmailConfirmed;
  String? image;
  String? mobile;
  String? gender;
  dynamic salutation;
  String? locale;
  String? status;
  String? login;
  dynamic onesignalPlayerId;
  String? lastLogin;
  int? emailNotifications;
  int? countryId;
  int? darkTheme;
  int? rtl;
  String? twoFaVerifyVia;
  dynamic twoFactorCode;
  dynamic twoFactorExpiresAt;
  int? adminApproval;
  int? permissionSync;
  String? imageUrl;
  List<Role?> role;
  dynamic clientDetails;
  dynamic session;
  EmployeeDetail? employeeDetail;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        twoFactorSecret: json["two_factor_secret"],
        twoFactorRecoveryCodes: json["two_factor_recovery_codes"],
        twoFactorConfirmed: json["two_factor_confirmed"],
        twoFactorEmailConfirmed: json["two_factor_email_confirmed"],
        image: json["image"],
        mobile: json["mobile"],
        gender: json["gender"],
        salutation: json["salutation"],
        locale: json["locale"],
        status: json["status"],
        login: json["login"],
        onesignalPlayerId: json["onesignal_player_id"],
        lastLogin: json["last_login"],
        emailNotifications: json["email_notifications"],
        countryId: json["country_id"],
        darkTheme: json["dark_theme"],
        rtl: json["rtl"],
        twoFaVerifyVia: json["two_fa_verify_via"],
        twoFactorCode: json["two_factor_code"],
        twoFactorExpiresAt: json["two_factor_expires_at"],
        adminApproval: json["admin_approval"],
        permissionSync: json["permission_sync"],
        imageUrl: json["image_url"],
        role: List<Role>.from(json["role"].map((x) => Role.fromJson(x))),
        clientDetails: json["client_details"],
        session: json["session"],
        employeeDetail: EmployeeDetail.fromJson(json["employee_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "two_factor_secret": twoFactorSecret,
        "two_factor_recovery_codes": twoFactorRecoveryCodes,
        "two_factor_confirmed": twoFactorConfirmed,
        "two_factor_email_confirmed": twoFactorEmailConfirmed,
        "image": image,
        "mobile": mobile,
        "gender": gender,
        "salutation": salutation,
        "locale": locale,
        "status": status,
        "login": login,
        "onesignal_player_id": onesignalPlayerId,
        "last_login": lastLogin,
        "email_notifications": emailNotifications,
        "country_id": countryId,
        "dark_theme": darkTheme,
        "rtl": rtl,
        "two_fa_verify_via": twoFaVerifyVia,
        "two_factor_code": twoFactorCode,
        "two_factor_expires_at": twoFactorExpiresAt,
        "admin_approval": adminApproval,
        "permission_sync": permissionSync,
        "image_url": imageUrl,
        "role": List<dynamic>.from(role.map((x) => x!.toJson())),
        "client_details": clientDetails,
        "session": session,
        "employee_detail": employeeDetail!.toJson(),
      };
}

class EmployeeDetail {
  EmployeeDetail({
    required this.id,
    required this.userId,
    required this.employeeId,
    required this.address,
    required this.hourlyRate,
    required this.slackUsername,
    required this.departmentId,
    required this.designationId,
    required this.joiningDate,
    required this.lastDate,
    required this.addedBy,
    required this.lastUpdatedBy,
    required this.attendanceReminder,
    required this.dateOfBirth,
    required this.designation,
  });

  int id;
  int userId;
  String employeeId;
  dynamic address;
  dynamic hourlyRate;
  dynamic slackUsername;
  int departmentId;
  int designationId;
  String joiningDate;
  dynamic lastDate;
  int addedBy;
  int lastUpdatedBy;
  DateTime attendanceReminder;
  String dateOfBirth;
  Designation designation;

  factory EmployeeDetail.fromJson(Map<String, dynamic> json) => EmployeeDetail(
        id: json["id"],
        userId: json["user_id"],
        employeeId: json["employee_id"],
        address: json["address"],
        hourlyRate: json["hourly_rate"],
        slackUsername: json["slack_username"],
        departmentId: json["department_id"],
        designationId: json["designation_id"],
        joiningDate: json["joining_date"],
        lastDate: json["last_date"],
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
        attendanceReminder: DateTime.parse(json["attendance_reminder"]),
        dateOfBirth: json["date_of_birth"],
        designation: Designation.fromJson(json["designation"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "employee_id": employeeId,
        "address": address,
        "hourly_rate": hourlyRate,
        "slack_username": slackUsername,
        "department_id": departmentId,
        "designation_id": designationId,
        "joining_date": joiningDate,
        "last_date": lastDate,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
        "attendance_reminder":
            "${attendanceReminder.year.toString().padLeft(4, '0')}-${attendanceReminder.month.toString().padLeft(2, '0')}-${attendanceReminder.day.toString().padLeft(2, '0')}",
        "date_of_birth": dateOfBirth,
        "designation": designation.toJson(),
      };
}

class Designation {
  Designation({
    required this.id,
    required this.name,
    required this.addedBy,
    required this.lastUpdatedBy,
  });

  int id;
  String name;
  dynamic addedBy;
  dynamic lastUpdatedBy;

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
        id: json["id"],
        name: json["name"],
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
      };
}

class Role {
  Role({
    required this.userId,
    required this.roleId,
  });

  int userId;
  int roleId;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        userId: json["user_id"],
        roleId: json["role_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "role_id": roleId,
      };
}
