import 'package:rideme_driver/features/localization/data/datasources/localds.dart';
import 'package:rideme_driver/features/localization/domain/repository/localization_repo.dart';

class LocalizationRepositoryImpl implements LocalizationRepository {
  final LocalizationLocalDataSource localDataSource;

  LocalizationRepositoryImpl({required this.localDataSource});

  //CHANGE LOCALE
  @override
  Future<bool> changeLocale(String localeName) async {
    return await localDataSource.changeLocale(localeName);
  }

  @override
  String getCurrentLocale() {
    return localDataSource.getCurrentLocale();
  }
}
