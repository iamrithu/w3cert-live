class TaskDetailsModel {
  TaskDetailsModel({
    this.id,
    this.heading,
    this.description,
    this.dueDate,
    this.startDate,
    this.projectId,
    this.taskCategoryId,
    this.priority,
    this.status,
    this.completedOn,
    this.createdBy,
    this.recurringTaskId,
    this.dependentTaskId,
    this.milestoneId,
    this.isPrivate,
    this.billable,
    this.estimateHours,
    this.estimateMinutes,
    this.addedBy,
    this.lastUpdatedBy,
    this.hash,
    this.repeat,
    this.repeatComplete,
    this.repeatCount,
    this.repeatType,
    this.repeatCycles,
    this.eventId,
    this.taskUsers,
    this.dueOn,
    this.createOn,
    this.project,
    this.users,
  });

  int? id;
  String? heading;
  String? description;
  DateTime? dueDate;
  DateTime? startDate;
  int? projectId;
  dynamic taskCategoryId;
  String? priority;
  String? status;
  dynamic completedOn;
  int? createdBy;
  dynamic recurringTaskId;
  dynamic dependentTaskId;
  dynamic milestoneId;
  int? isPrivate;
  int? billable;
  int? estimateHours;
  int? estimateMinutes;
  int? addedBy;
  int? lastUpdatedBy;
  String? hash;
  int? repeat;
  int? repeatComplete;
  dynamic repeatCount;
  String? repeatType;
  dynamic repeatCycles;
  dynamic eventId;
  List<int>? taskUsers;
  String? dueOn;
  String? createOn;
  Project? project;
  List<User>? users;

  factory TaskDetailsModel.fromJson(Map<String, dynamic> json) =>
      TaskDetailsModel(
        id: json["id"],
        heading: json["heading"],
        description: json["description"],
        dueDate:
            json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        projectId: json["project_id"],
        taskCategoryId: json["task_category_id"],
        priority: json["priority"],
        status: json["status"],
        completedOn: json["completed_on"],
        createdBy: json["created_by"],
        recurringTaskId: json["recurring_task_id"],
        dependentTaskId: json["dependent_task_id"],
        milestoneId: json["milestone_id"],
        isPrivate: json["is_private"],
        billable: json["billable"],
        estimateHours: json["estimate_hours"],
        estimateMinutes: json["estimate_minutes"],
        addedBy: json["added_by"],
        lastUpdatedBy: json["last_updated_by"],
        hash: json["hash"],
        repeat: json["repeat"],
        repeatComplete: json["repeat_complete"],
        repeatCount: json["repeat_count"],
        repeatType: json["repeat_type"],
        repeatCycles: json["repeat_cycles"],
        eventId: json["event_id"],
        taskUsers: json["taskUsers"] == null
            ? []
            : List<int>.from(json["taskUsers"]!.map((x) => x)),
        dueOn: json["due_on"],
        createOn: json["create_on"],
        project:
            json["project"] == null ? null : Project.fromJson(json["project"]),
        users: json["users"] == null
            ? []
            : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "heading": heading,
        "description": description,
        "due_date": dueDate?.toString(),
        "start_date": startDate?.toString(),
        "project_id": projectId,
        "task_category_id": taskCategoryId,
        "priority": priority,
        "status": status,
        "completed_on": completedOn,
        "created_by": createdBy,
        "recurring_task_id": recurringTaskId,
        "dependent_task_id": dependentTaskId,
        "milestone_id": milestoneId,
        "is_private": isPrivate,
        "billable": billable,
        "estimate_hours": estimateHours,
        "estimate_minutes": estimateMinutes,
        "added_by": addedBy,
        "last_updated_by": lastUpdatedBy,
        "hash": hash,
        "repeat": repeat,
        "repeat_complete": repeatComplete,
        "repeat_count": repeatCount,
        "repeat_type": repeatType,
        "repeat_cycles": repeatCycles,
        "event_id": eventId,
        "taskUsers": taskUsers == null
            ? []
            : List<dynamic>.from(taskUsers!.map((x) => x)),
        "due_on": dueOn,
        "create_on": createOn,
        "project": project?.toJson(),
        "users": users == null
            ? []
            : List<dynamic>.from(users!.map((x) => x.toJson())),
      };
}

class Project {
  Project({
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
  dynamic categoryId;
  dynamic clientId;
  dynamic teamId;
  dynamic feedback;
  String? manualTimelog;
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

  factory Project.fromJson(Map<String, dynamic> json) => Project(
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
        "project_name": projectName!,
        "project_summary": projectSummary,
        "project_admin": projectAdmin,
        "start_date": startDate?.toString(),
        "deadline": deadline,
        "notes": notes,
        "category_id": categoryId,
        "client_id": clientId,
        "team_id": teamId,
        "feedback": feedback,
        "manual_timelog": manualTimelog,
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
        "id": id,
        "name": name,
        "email": email,
        "image_url": imageUrl,
      };
}
