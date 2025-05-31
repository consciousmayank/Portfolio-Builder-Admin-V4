// To parse this JSON data, do
//
//     final personalInfo = personalInfoFromJson(jsonString);

import 'dart:convert';

PersonalInfo personalInfoFromJson(String str) => PersonalInfo.fromJson(json.decode(str));

String personalInfoToJson(PersonalInfo data) => json.encode(data.toJson());

class PersonalInfo {
    final List<Item> items;
    final int page;
    final int perPage;
    final int totalItems;
    final int totalPages;

    PersonalInfo({
        required this.items,
        required this.page,
        required this.perPage,
        required this.totalItems,
        required this.totalPages,
    });

    PersonalInfo copyWith({
        List<Item>? items,
        int? page,
        int? perPage,
        int? totalItems,
        int? totalPages,
    }) => 
        PersonalInfo(
            items: items ?? this.items,
            page: page ?? this.page,
            perPage: perPage ?? this.perPage,
            totalItems: totalItems ?? this.totalItems,
            totalPages: totalPages ?? this.totalPages,
        );

    factory PersonalInfo.fromJson(Map<String, dynamic> json) => PersonalInfo(
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
    final List<String> aboutMe;
    final String address;
    final String avatar;
    final String collectionId;
    final String collectionName;
    final DateTime created;
    final String emailId;
    final Expand expand;
    final String id;
    final String name;
    final String oneLiner;
    final String phoneNumber;
    final List<String> soceialMedia;
    final List<String> typewriteOptions;
    final DateTime updated;
    final String userid;

    Item({
        required this.aboutMe,
        required this.address,
        required this.avatar,
        required this.collectionId,
        required this.collectionName,
        required this.created,
        required this.emailId,
        required this.expand,
        required this.id,
        required this.name,
        required this.oneLiner,
        required this.phoneNumber,
        required this.soceialMedia,
        required this.typewriteOptions,
        required this.updated,
        required this.userid,
    });

    Item copyWith({
        List<String>? aboutMe,
        String? address,
        String? avatar,
        String? collectionId,
        String? collectionName,
        DateTime? created,
        String? emailId,
        Expand? expand,
        String? id,
        String? name,
        String? oneLiner,
        String? phoneNumber,
        List<String>? soceialMedia,
        List<String>? typewriteOptions,
        DateTime? updated,
        String? userid,
    }) => 
        Item(
            aboutMe: aboutMe ?? this.aboutMe,
            address: address ?? this.address,
            avatar: avatar ?? this.avatar,
            collectionId: collectionId ?? this.collectionId,
            collectionName: collectionName ?? this.collectionName,
            created: created ?? this.created,
            emailId: emailId ?? this.emailId,
            expand: expand ?? this.expand,
            id: id ?? this.id,
            name: name ?? this.name,
            oneLiner: oneLiner ?? this.oneLiner,
            phoneNumber: phoneNumber ?? this.phoneNumber,
            soceialMedia: soceialMedia ?? this.soceialMedia,
            typewriteOptions: typewriteOptions ?? this.typewriteOptions,
            updated: updated ?? this.updated,
            userid: userid ?? this.userid,
        );

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        aboutMe: List<String>.from(json["about_me"].map((x) => x)),
        address: json["address"],
        avatar: json["avatar"],
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: DateTime.parse(json["created"]),
        emailId: json["email_id"],
        expand: json["expand"] != null ? Expand.fromJson(json["expand"]) : Expand(soceialMedia: [], userid: Userid(avatar: '', collectionId: '', collectionName: '', created: DateTime.now(), email: '', emailVisibility: false, id: '', name: '', updated: DateTime.now(), verified: false)),
        id: json["id"],
        name: json["name"],
        oneLiner: json["one_liner"],
        phoneNumber: json["phone_number"],
        soceialMedia: List<String>.from(json["soceial_media"].map((x) => x)),
        typewriteOptions: List<String>.from(json["typewrite_options"].map((x) => x)),
        updated: DateTime.parse(json["updated"]),
        userid: json["userid"],
    );

    Map<String, dynamic> toJson() => {
        "about_me": List<dynamic>.from(aboutMe.map((x) => x)),
        "address": address,
        "avatar": avatar,
        "collectionId": collectionId,
        "collectionName": collectionName,
        "created": created.toIso8601String(),
        "email_id": emailId,
        "expand": expand.toJson(),
        "id": id,
        "name": name,
        "one_liner": oneLiner,
        "phone_number": phoneNumber,
        "soceial_media": List<dynamic>.from(soceialMedia.map((x) => x)),
        "typewrite_options": List<dynamic>.from(typewriteOptions.map((x) => x)),
        "updated": updated.toIso8601String(),
        "userid": userid,
    };
}

class Expand {
    final List<SoceialMedia> soceialMedia;
    final Userid userid;

    Expand({
        required this.soceialMedia,
        required this.userid,
    });

    Expand copyWith({
        List<SoceialMedia>? soceialMedia,
        Userid? userid,
    }) => 
        Expand(
            soceialMedia: soceialMedia ?? this.soceialMedia,
            userid: userid ?? this.userid,
        );

    factory Expand.fromJson(Map<String, dynamic> json) => Expand(
        soceialMedia: List<SoceialMedia>.from(json["soceial_media"].map((x) => SoceialMedia.fromJson(x))),
        userid: Userid.fromJson(json["userid"]),
    );

    Map<String, dynamic> toJson() => {
        "soceial_media": List<dynamic>.from(soceialMedia.map((x) => x.toJson())),
        "userid": userid.toJson(),
    };
}

class SoceialMedia {
    final String collectionId;
    final String collectionName;
    final DateTime created;
    final String id;
    final String link;
    final String name;
    final DateTime updated;
    final String userid;

    SoceialMedia({
        required this.collectionId,
        required this.collectionName,
        required this.created,
        required this.id,
        required this.link,
        required this.name,
        required this.updated,
        required this.userid,
    });

    SoceialMedia copyWith({
        String? collectionId,
        String? collectionName,
        DateTime? created,
        String? id,
        String? link,
        String? name,
        DateTime? updated,
        String? userid,
    }) => 
        SoceialMedia(
            collectionId: collectionId ?? this.collectionId,
            collectionName: collectionName ?? this.collectionName,
            created: created ?? this.created,
            id: id ?? this.id,
            link: link ?? this.link,
            name: name ?? this.name,
            updated: updated ?? this.updated,
            userid: userid ?? this.userid,
        );

    factory SoceialMedia.fromJson(Map<String, dynamic> json) => SoceialMedia(
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: DateTime.parse(json["created"]),
        id: json["id"],
        link: json["link"],
        name: json["name"],
        updated: DateTime.parse(json["updated"]),
        userid: json["userid"],
    );

    Map<String, dynamic> toJson() => {
        "collectionId": collectionId,
        "collectionName": collectionName,
        "created": created.toIso8601String(),
        "id": id,
        "link": link,
        "name": name,
        "updated": updated.toIso8601String(),
        "userid": userid,
    };
}

class Userid {
    final String avatar;
    final String collectionId;
    final String collectionName;
    final DateTime created;
    final String email;
    final bool emailVisibility;
    final String id;
    final String name;
    final DateTime updated;
    final bool verified;

    Userid({
        required this.avatar,
        required this.collectionId,
        required this.collectionName,
        required this.created,
        required this.email,
        required this.emailVisibility,
        required this.id,
        required this.name,
        required this.updated,
        required this.verified,
    });

    Userid copyWith({
        String? avatar,
        String? collectionId,
        String? collectionName,
        DateTime? created,
        String? email,
        bool? emailVisibility,
        String? id,
        String? name,
        DateTime? updated,
        bool? verified,
    }) => 
        Userid(
            avatar: avatar ?? this.avatar,
            collectionId: collectionId ?? this.collectionId,
            collectionName: collectionName ?? this.collectionName,
            created: created ?? this.created,
            email: email ?? this.email,
            emailVisibility: emailVisibility ?? this.emailVisibility,
            id: id ?? this.id,
            name: name ?? this.name,
            updated: updated ?? this.updated,
            verified: verified ?? this.verified,
        );

    factory Userid.fromJson(Map<String, dynamic> json) => Userid(
        avatar: json["avatar"],
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        created: DateTime.parse(json["created"]),
        email: json["email"],
        emailVisibility: json["emailVisibility"],
        id: json["id"],
        name: json["name"],
        updated: DateTime.parse(json["updated"]),
        verified: json["verified"],
    );

    Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "collectionId": collectionId,
        "collectionName": collectionName,
        "created": created.toIso8601String(),
        "email": email,
        "emailVisibility": emailVisibility,
        "id": id,
        "name": name,
        "updated": updated.toIso8601String(),
        "verified": verified,
    };
}
