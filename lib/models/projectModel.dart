class ProjectModel {
  ProjectModel({
    this.id,
    this.projectName,
    this.projectSummary,
    this.projectAdmin,
    this.startDate,
    this.deadline,
    this.notes,
    this.categoryId,
    this.clientId,
    this.teamId,
    this.feedback,
    this.manualTimelog,
    this.clientViewTask,
    this.allowClientNotification,
    this.completionPercent,
    this.calculateTaskProgress,
    this.deletedAt,
    this.projectBudget,
    this.currencyId,
    this.hoursAllocated,
    this.status,
    this.addedBy,
    this.lastUpdatedBy,
    this.hash,
    this.public,
    this.isProjectAdmin,
  });

  int? id;
  String? projectName;
  dynamic projectSummary;
  dynamic projectAdmin;
  DateTime? startDate;
  dynamic deadline;
  String? notes;
  int? categoryId;
  dynamic clientId;
  int? teamId;
  dynamic feedback;
  String? manualTimelog;
  String? clientViewTask;
  String? allowClientNotification;
  int? completionPercent;
  String? calculateTaskProgress;
  dynamic deletedAt;
  dynamic projectBudget;
  int? currencyId;
  dynamic hoursAllocated;
  String? status;
  int? addedBy;
  int? lastUpdatedBy;
  String? hash;
  int? public;
  bool? isProjectAdmin;

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        id: json["id"],
        projectName: json["project_name"],
        projectSummary: json["project_summary"],
        projectAdmin: json["project_admin"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        deadline: json["deadline"],
        notes: json["notes"],
        categoryId: json["category_id"],
        clientId: json["client_id"],
        teamId: json["team_id"],
        feedback: json["feedback"],
        manualTimelog: json["manual_timelog"],
        clientViewTask: json["client_view_task"],
        allowClientNotification: json["allow_client_notification"],
        completionPercent: json["completion_percent"],
        calculateTaskProgress: json["calculate_task_progress"],
        deletedAt: json["deleted_at"],
        projectBudget: json["project_budget"],
        currencyId: json["currency_id"],
        hoursAllocated: json["hours_allocated"],
        status: json["status"],
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
        hash: json["hash"],
        public: json["public"],
        isProjectAdmin: json["isProjectAdmin"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "project_name": projectName,
        "project_summary": projectSummary,
        "project_admin": projectAdmin,
        "start_date": startDate?.toIso8601String(),
        "deadline": deadline,
        "notes": notes,
        "category_id": categoryId,
        "client_id": clientId,
        "team_id": teamId,
        "feedback": feedback,
        "manual_timelog": manualTimelog,
        "client_view_task": clientViewTask,
        "allow_client_notification": allowClientNotification,
        "completion_percent": completionPercent,
        "calculate_task_progress": calculateTaskProgress,
        "deleted_at": deletedAt,
        "project_budget": projectBudget,
        "currency_id": currencyId,
        "hours_allocated": hoursAllocated,
        "status": status,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
        "hash": hash,
        "public": public,
        "isProjectAdmin": isProjectAdmin,
      };
}
