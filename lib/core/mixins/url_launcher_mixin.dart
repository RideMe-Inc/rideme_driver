import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

mixin UrlLauncherMixin {
  //LAUNCH LINK
  launchLink(String link) async => await launchUrl(
        Uri.parse(link),
        mode: LaunchMode.externalApplication,
      );

  //LAUNCH CALL
  launchCallUrl(String phoneNumber) => launchUrl(
        Uri(scheme: "tel", host: phoneNumber),
      );

  //Share
  share() async => await Share.share('Share');
}
