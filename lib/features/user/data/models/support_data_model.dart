//SOCIAL DATA
import 'package:rideme_driver/features/user/domain/entities/support_data.dart';

class SupportDataModel extends SupportData {
  const SupportDataModel({required super.socials, required super.whatsapp});

  //fromJson
  factory SupportDataModel.fromJson(Map<String, dynamic> json) =>
      SupportDataModel(
        socials: json['socials']
            .map<SocialsContactModel>((e) => SocialsContactModel.fromJson(e))
            .toList(),
        whatsapp: json['whatsapp']
            .map<WhatsAppContactModel>((e) => WhatsAppContactModel.fromJson(e))
            .toList(),
      );
}

//SOCIALS CONTACT
class SocialsContactModel extends SocialsContact {
  const SocialsContactModel(
      {required super.handle, required super.link, required super.type});

  //fromJson
  factory SocialsContactModel.fromJson(Map<String, dynamic> json) =>
      SocialsContactModel(
        handle: json['handle'],
        link: json['link'],
        type: json['type'],
      );
}

//WHATSAPP CONTACT
class WhatsAppContactModel extends WhatsAppContact {
  const WhatsAppContactModel(
      {required super.serviceType, required super.contact});
//fromJson
  factory WhatsAppContactModel.fromJson(Map<String, dynamic> json) =>
      WhatsAppContactModel(
        serviceType: json['service_type'],
        contact: json['contact'],
      );
}
