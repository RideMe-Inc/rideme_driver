import 'package:equatable/equatable.dart';

//SUPPORT DATA

class SupportData extends Equatable {
  final List<SocialsContact> socials;
  final List<WhatsAppContact> whatsapp;

  const SupportData({required this.socials, required this.whatsapp});

  @override
  List<Object?> get props => [
        socials,
        whatsapp,
      ];
}

//SOCIALS CONTACT
class SocialsContact extends Equatable {
  final String handle, link, type;

  const SocialsContact(
      {required this.handle, required this.link, required this.type});

  @override
  List<Object?> get props => [
        handle,
        link,
        type,
      ];
}

//WHATSAPP CONTACT
class WhatsAppContact extends Equatable {
  final String serviceType, contact;

  const WhatsAppContact({required this.serviceType, required this.contact});

  @override
  List<Object?> get props => [
        serviceType,
        contact,
      ];
}
