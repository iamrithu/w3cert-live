class NotificationModel {
  NotificationModel({
    this.id,
    this.type,
    this.typecase,
    this.notifiableType,
    this.notifiableId,
    this.subject,
    this.text,
    this.image,
    this.link,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? type;
  String? typecase;
  String? notifiableType;
  int? notifiableId;
  String? subject;
  String? text;
  String? image;
  String? link;
  dynamic readAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        type: json["type"],
        typecase: json["typecase"],
        notifiableType: json["notifiable_type"],
        notifiableId: json["notifiable_id"],
        subject: json["subject"],
        text: json["text"],
        image: json["image"],
        link: json["link"],
        readAt: json["read_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "typecase": typecase,
        "notifiable_type": notifiableType,
        "notifiable_id": notifiableId,
        "subject": subject,
        "text": text,
        "image": image,
        "link": link,
        "read_at": readAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
