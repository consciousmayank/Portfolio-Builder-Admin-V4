// To parse this JSON data, do
//
//     final educationDetails = educationDetailsFromJson(jsonString);

import 'dart:convert';

EducationDetails educationDetailsFromJson(String str) => EducationDetails.fromJson(json.decode(str));

String educationDetailsToJson(EducationDetails data) => json.encode(data.toJson());

class EducationDetails {
    final List<Item> items;
    final int page;
    final int perPage;
    final int totalItems;
    final int totalPages;

    EducationDetails({
        required this.items,
        required this.page,
        required this.perPage,
        required this.totalItems,
        required this.totalPages,
    });

    EducationDetails copyWith({
        List<Item>? items,
        int? page,
        int? perPage,
        int? totalItems,
        int? totalPages,
    }) => 
        EducationDetails(
            items: items ?? this.items,
            page: page ?? this.page,
            perPage: perPage ?? this.perPage,
            totalItems: totalItems ?? this.totalItems,
            totalPages: totalPages ?? this.totalPages,
        );

    factory EducationDetails.fromJson(Map<String, dynamic> json) => EducationDetails(
        items: json["items"] != null ? List<Item>.from(json["items"].map((x) => Item.fromJson(x))) : [],
        page: json["page"],
        perPage: json["perPage"],
        totalItems: json["totalItems"],
        totalPages: json["totalPages"],
    );

    Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "page": page,
        "perPage": perPage,
        "totalItems": totalItems,
        "totalPages": totalPages,
    };
}

class Item {
    final String? city;
    final String? collectionId;
    final String? collectionName;
    final DateTime? created;
    final DateTime? from;
    final String? id;
    final String? institute;
    final String? title;
    final DateTime? to;
    final DateTime? updated;
    final String? userid;

    Item({
        required this.city,
        required this.collectionId,
        required this.collectionName,
        required this.created,
        required this.from,
        required this.id,
        required this.institute,
        required this.title,
        required this.to,
        required this.updated,
        required this.userid,
    });

    Item copyWith({
        String? city,
        String? collectionId,
        String? collectionName,
        DateTime? created,
        DateTime? from,
        String? id,
        String? institute,
        String? title,
        DateTime? to,
        DateTime? updated,
        String? userid,
    }) => 
        Item(
            city: city ?? this.city,
            collectionId: collectionId ?? this.collectionId,
            collectionName: collectionName ?? this.collectionName,
            created: created ?? this.created,
            from: from ?? this.from,
            id: id ?? this.id,
            institute: institute ?? this.institute,
            title: title ?? this.title,
            to: to ?? this.to,
            updated: updated ?? this.updated,
            userid: userid ?? this.userid,
        );

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        city: json["city"],
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: json["created"] != null ? DateTime.parse(json["created"]) : null,
        from: json["from"] != null ? DateTime.parse(json["from"]) : null,
        id: json["id"],
        institute: json["institute"],
        title: json["title"],
        to: json["to"] != null ? DateTime.parse(json["to"]) : null,
        updated: json["updated"] != null ? DateTime.parse(json["updated"]) : null,
        userid: json["userid"],
    );

    Map<String, dynamic> toJson() => {
        "city": city,
        "collectionId": collectionId,
        "collectionName": collectionName,
        "created": created?.toIso8601String(),
        "from": from?.toIso8601String(),
        "id": id,
        "institute": institute,
        "title": title,
        "to": to?.toIso8601String(),
        "updated": updated?.toIso8601String(),
        "userid": userid,
    };
}
