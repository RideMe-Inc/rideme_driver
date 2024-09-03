import 'package:rideme_driver/features/user/domain/entities/user.dart';
import 'package:rideme_driver/features/user/domain/repositories/user_repository.dart';

class GetCachedUserWithoutSafety {
  final UserRepository repository;

  GetCachedUserWithoutSafety({required this.repository});

  User call() {
    return repository.getCachedUserWithoutSafety();
  }
}
