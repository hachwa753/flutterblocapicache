import 'package:flutterapiecommerce/core/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

// run to generate inject.config file
//flutter pub run build_runner build --delete-conflicting-outputs
final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() {
  getIt.init();
}
