import 'package:rideme_driver/features/localization/domain/repository/localization_repo.dart';

class GetCurrentLocale {
  final LocalizationRepository repository;

  GetCurrentLocale({required this.repository});

  String call() {
    return repository.getCurrentLocale();
  }
}
