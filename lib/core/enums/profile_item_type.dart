import 'package:rideme_driver/assets/svgs/svg_name_constants.dart';

enum ProfileItemType {
  logout(svg: SvgNameConstants.logoutSVG),
  earnings(svg: SvgNameConstants.earningsSVG),
  editProfile(svg: SvgNameConstants.userSVG),
  deleteAccount(svg: SvgNameConstants.deleteAccountSVG),
  safety(svg: SvgNameConstants.safetySVG),
  trips(svg: SvgNameConstants.carTypeSVG),
  aboutRideMe(svg: SvgNameConstants.aboutSVG);

  final String svg;

  const ProfileItemType({required this.svg});
}
