// To parse this JSON data, do
//
//     final LeadModel = LeadModelFromJson(jsonString);

class LeadModel {
  LeadModel({
    this.id,
    this.agentId,
    this.mobile,
    this.addedBy,
    this.clientId,
    this.nextFollowUp,
    this.salutation,
    this.clientName,
    this.companyName,
    this.statusName,
    this.statusId,
    this.source,
    this.agentName,
    this.image,
    this.nextFollowUpDate,
    this.imageUrl,
    this.leadAgent,
  });

  int? id;
  int? agentId;
  String? mobile;
  int? addedBy;
  dynamic clientId;
  String? nextFollowUp;
  String? salutation;
  String? clientName;
  dynamic companyName;
  String? statusName;
  int? statusId;
  String? source;
  String? agentName;
  String? image;
  dynamic nextFollowUpDate;
  String? imageUrl;
  LeadAgent? leadAgent;

  factory LeadModel.fromJson(Map<String, dynamic> json) => LeadModel(
        id: json["id"],
        agentId: json["agent_id"],
        mobile: json["mobile"],
        addedBy: json["added_by"],
        clientId: json["client_id"],
        nextFollowUp: json["next_follow_up"],
        salutation: json["salutation"],
        clientName: json["client_name"],
        companyName: json["company_name"],
        statusName: json["statusName"],
        statusId: json["status_id"],
        source: json["source"],
        agentName: json["agent_name"],
        image: json["image"],
        nextFollowUpDate: json["next_follow_up_date"],
        imageUrl: json["image_url"],
        leadAgent: json["lead_agent"] == null
            ? null
            : LeadAgent.fromJson(json["lead_agent"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "agent_id": agentId,
        "mobile": mobile,
        "added_by": addedBy,
        "client_id": clientId,
        "next_follow_up": nextFollowUp,
        "salutation": salutation,
        "client_name": clientName,
        "company_name": companyName,
        "statusName": statusName,
        "status_id": statusId,
        "source": source,
        "agent_name": agentName,
        "image": image,
        "next_follow_up_date": nextFollowUpDate,
        "image_url": imageUrl,
        "lead_agent": leadAgent?.toJson(),
      };
}

class LeadAgent {
  LeadAgent({
    this.id,
    this.userId,
    this.status,
    this.addedBy,
    this.lastUpdatedBy,
    this.user,
  });

  int? id;
  int? userId;
  String? status;
  int? addedBy;
  int? lastUpdatedBy;
  User? user;

  factory LeadAgent.fromJson(Map<String, dynamic> json) => LeadAgent(
        id: json["id"],
        userId: json["user_id"],
        status: json["status"],
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "status": status,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
        "user": user?.toJson(),
      };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.imageUrl,
    this.employeeDetail,
  });

  int? id;
  String? name;
  String? email;
  String? imageUrl;
  EmployeeDetail? employeeDetail;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        imageUrl: json["image_url"],
        employeeDetail: json["employee_detail"] == null
            ? null
            : EmployeeDetail.fromJson(json["employee_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "image_url": imageUrl,
        "employee_detail": employeeDetail?.toJson(),
      };
}

class EmployeeDetail {
  EmployeeDetail({
    this.id,
    this.userId,
    this.employeeId,
  });

  int? id;
  int? userId;
  String? employeeId;

  factory EmployeeDetail.fromJson(Map<String, dynamic> json) => EmployeeDetail(
        id: json["id"],
        userId: json["user_id"],
        employeeId: json["employee_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "employee_id": employeeId,
      };
}
