import 'package:rideme_driver/features/localization/domain/repository/localization_repo.dart';

class ChangeLocale {
  final LocalizationRepository repository;

  ChangeLocale({required this.repository});

  Future<bool> call(String localeName) async {
    return await repository.changeLocale(localeName);
  }
}
