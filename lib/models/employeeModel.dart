// To parse this JSON data, do
//
//     final employeeModel = employeeModelFromJson(jsonString);

class EmployeeModel {
  EmployeeModel({
    this.id,
    this.name,
    this.email,
    this.image,
    this.designationName,
    this.emailNotifications,
    this.mobile,
    this.countryId,
    this.imageUrl,
    this.role,
    this.clientDetails,
    this.session,
    this.employeeDetail,
  });

  int? id;
  String? name;
  String? email;
  String? image;
  String? designationName;
  int? emailNotifications;
  String? mobile;
  int? countryId;
  String? imageUrl;
  List<Role>? role;
  dynamic clientDetails;
  dynamic session;
  EmployeeDetail? employeeDetail;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        image: json["image"],
        designationName: json["designation_name"],
        emailNotifications: json["email_notifications"],
        mobile: json["mobile"],
        countryId: json["country_id"],
        imageUrl: json["image_url"],
        role: json["role"] == null
            ? []
            : List<Role>.from(json["role"]!.map((x) => Role.fromJson(x))),
        clientDetails: json["client_details"],
        session: json["session"],
        employeeDetail: json["employee_detail"] == null
            ? null
            : EmployeeDetail.fromJson(json["employee_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "image": image,
        "designation_name": designationName,
        "email_notifications": emailNotifications,
        "mobile": mobile,
        "country_id": countryId,
        "image_url": imageUrl,
        "role": role == null
            ? []
            : List<dynamic>.from(role!.map((x) => x.toJson())),
        "client_details": clientDetails,
        "session": session,
        "employee_detail": employeeDetail?.toJson(),
      };
}

class EmployeeDetail {
  EmployeeDetail({
    this.id,
    this.userId,
    this.employeeId,
    this.address,
    this.hourlyRate,
    this.slackUsername,
    this.departmentId,
    this.designationId,
    this.joiningDate,
    this.lastDate,
    this.addedBy,
    this.lastUpdatedBy,
    this.attendanceReminder,
    this.dateOfBirth,
    this.designation,
  });

  int? id;
  int? userId;
  String? employeeId;
  dynamic address;
  dynamic hourlyRate;
  dynamic slackUsername;
  int? departmentId;
  int? designationId;
  DateTime? joiningDate;
  dynamic lastDate;
  int? addedBy;
  int? lastUpdatedBy;
  DateTime? attendanceReminder;
  DateTime? dateOfBirth;
  Designation? designation;

  factory EmployeeDetail.fromJson(Map<String, dynamic> json) => EmployeeDetail(
        id: json["id"],
        userId: json["user_id"],
        employeeId: json["employee_id"],
        address: json["address"],
        hourlyRate: json["hourly_rate"],
        slackUsername: json["slack_username"],
        departmentId: json["department_id"],
        designationId: json["designation_id"],
        joiningDate: json["joining_date"] == null
            ? null
            : DateTime.parse(json["joining_date"]),
        lastDate: json["last_date"],
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
        attendanceReminder: json["attendance_reminder"] == null
            ? null
            : DateTime.parse(json["attendance_reminder"]),
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        designation: json["designation"] == null
            ? null
            : Designation.fromJson(json["designation"]),
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
        "joining_date": joiningDate?.toIso8601String(),
        "last_date": lastDate,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
        "attendance_reminder":
            "${attendanceReminder!.year.toString().padLeft(4, '0')}-${attendanceReminder!.month.toString().padLeft(2, '0')}-${attendanceReminder!.day.toString().padLeft(2, '0')}",
        "date_of_birth": dateOfBirth?.toIso8601String(),
        "designation": designation?.toJson(),
      };
}

class Designation {
  Designation({
    this.id,
    this.name,
    this.addedBy,
    this.lastUpdatedBy,
  });

  int? id;
  String? name;
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
    this.userId,
    this.roleId,
  });

  int? userId;
  int? roleId;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        userId: json["user_id"],
        roleId: json["role_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "role_id": roleId,
      };
}
