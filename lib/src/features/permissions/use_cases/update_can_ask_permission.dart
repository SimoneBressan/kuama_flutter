import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:kuama_flutter/src/features/permissions/entities/permission.dart';
import 'package:kuama_flutter/src/features/permissions/repositories/permission_preferences_repository.dart';
import 'package:kuama_flutter/src/shared/feature_structure/failure.dart';
import 'package:kuama_flutter/src/shared/feature_structure/use_case.dart';

class UpdateCanAskPermissionParams extends ParamsBase {
  final Permission permission;
  final bool canAsk;

  UpdateCanAskPermissionParams(this.permission, this.canAsk) : super([permission, canAsk]);
}

/// Update if the permit can be requested
abstract class UpdateCanAskPermission extends UseCase<UpdateCanAskPermissionParams, bool> {
  UpdateCanAskPermission();

  factory UpdateCanAskPermission.preferences() = _PreferencesUpdateCanAskPermission;
}

/// [UpdateCanAskPermission] Use the repository [PermissionPreferencesRepository]
class _PreferencesUpdateCanAskPermission extends UpdateCanAskPermission {
  final PermissionPreferencesRepository prefRepo = GetIt.I();

  @override
  Stream<Either<Failure, bool>> tryCall(UpdateCanAskPermissionParams params) async* {
    yield* prefRepo.setCanAsk(params.permission, params.canAsk).toRight();
  }
}
