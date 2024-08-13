import 'package:rideme_driver/assets/svgs/svg_name_constants.dart';

enum ProfileItemType {
  faq(svg: SvgNameConstants.faqSVG),
  logout(svg: SvgNameConstants.logoutSVG),
  payment(svg: SvgNameConstants.paymentSVG),
  editProfile(svg: SvgNameConstants.userSVG),
  appLanguage(svg: SvgNameConstants.appLanguageSVG),
  privacyAndData(svg: SvgNameConstants.privacyDataPolicySVG),
  contactSupport(svg: SvgNameConstants.supportSVG),
  accountSettings(svg: SvgNameConstants.settingsSVG),
  deleteAccount(svg: SvgNameConstants.deleteAccountSVG),
  safety(svg: SvgNameConstants.safetySVG),
  notification(svg: SvgNameConstants.notificationSVG),
  aboutRideMe(svg: SvgNameConstants.aboutSVG);

  final String svg;

  const ProfileItemType({required this.svg});
}
