// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

class TaskModel {
  TaskModel({
    this.id,
    this.addedBy,
    this.projectName,
    this.heading,
    this.clientName,
    this.createdBy,
    this.createdImage,
    this.boardColumnId,
    this.dueDate,
    this.boardColumn,
    this.labelColor,
    this.projectId,
    this.isPrivate,
    this.activeTimerAllCount,
    this.dueOn,
    this.createOn,
    this.users,
    this.activeTimerAll,
    this.activeTimer,
    this.timeLogged,
  });

  int? id;
  int? addedBy;
  String? projectName;
  String? heading;
  dynamic clientName;
  String? createdBy;
  String? createdImage;
  int? boardColumnId;
  DateTime? dueDate;
  BoardColumn? boardColumn;
  String? labelColor;
  int? projectId;
  int? isPrivate;
  int? activeTimerAllCount;
  String? dueOn;
  String? createOn;
  List<User>? users;
  List<dynamic>? activeTimerAll;
  dynamic activeTimer;
  List<dynamic>? timeLogged;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        addedBy: json["added_by"],
        projectName: json["project_name"],
        heading: json["heading"],
        clientName: json["clientName"],
        createdBy: json["created_by"],
        createdImage: json["created_image"],
        boardColumnId: json["board_column_id"],
        dueDate:
            json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
        boardColumn: json["board_column"] == null
            ? null
            : BoardColumn.fromJson(json["board_column"]),
        labelColor: json["label_color"],
        projectId: json["project_id"],
        isPrivate: json["is_private"],
        activeTimerAllCount: json["active_timer_all_count"],
        dueOn: json["due_on"],
        createOn: json["create_on"],
        users: json["users"] == null
            ? []
            : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
        activeTimerAll: json["active_timer_all"] == null
            ? []
            : List<dynamic>.from(json["active_timer_all"]!.map((x) => x)),
        activeTimer: json["active_timer"],
        timeLogged: json["time_logged"] == null
            ? []
            : List<dynamic>.from(json["time_logged"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "added_by": addedBy,
        "project_name": projectName,
        "heading": heading,
        "clientName": clientName,
        "created_by": createdBy,
        "created_image": createdImage,
        "board_column_id": boardColumnId,
        "due_date": dueDate?.toString(),
        "board_column": boardColumn?.toJson(),
        "label_color": labelColor,
        "project_id": projectId,
        "is_private": isPrivate,
        "active_timer_all_count": activeTimerAllCount,
        "due_on": dueOn,
        "create_on": createOn,
        "users": users == null
            ? []
            : List<dynamic>.from(users!.map((x) => x.toJson())),
        "active_timer_all": activeTimerAll == null
            ? []
            : List<dynamic>.from(activeTimerAll!.map((x) => x)),
        "active_timer": activeTimer,
        "time_logged": timeLogged == null
            ? []
            : List<dynamic>.from(timeLogged!.map((x) => x)),
      };
}

class BoardColumn {
  BoardColumn({
    this.id,
    this.columnName,
    this.slug,
    this.labelColor,
    this.priority,
  });

  int? id;
  String? columnName;
  String? slug;
  String? labelColor;
  int? priority;

  factory BoardColumn.fromJson(Map<String, dynamic> json) => BoardColumn(
        id: json["id"],
        columnName: json["column_name"],
        slug: json["slug"],
        labelColor: json["label_color"],
        priority: json["priority"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "column_name": columnName,
        "slug": slug,
        "label_color": labelColor,
        "priority": priority,
      };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.imageUrl,
  });

  int? id;
  String? name;
  String? email;

  String? imageUrl;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id!,
        "name": name!,
        "email": email!,
        "image_url": imageUrl,
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
  String? address;
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
        "joining_date": joiningDate?.toString(),
        "last_date": lastDate,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
        "attendance_reminder":
            "${attendanceReminder!.year.toString().padLeft(4, '0')}-${attendanceReminder!.month.toString().padLeft(2, '0')}-${attendanceReminder!.day.toString().padLeft(2, '0')}",
        "date_of_birth": dateOfBirth?.toString(),
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

class Pivot {
  Pivot({
    this.taskId,
    this.userId,
  });

  int? taskId;
  int? userId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        taskId: json["task_id"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "task_id": taskId,
        "user_id": userId,
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
