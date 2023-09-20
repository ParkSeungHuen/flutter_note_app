import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di_setup.config.dart';

final getIt = GetIt.instance;

const dev = Environment('dev'); // 개발
const prod = Environment('prod'); // 실제 배포

@InjectableInit()
Future<void> configureDependencies() => getIt.init(environment: Environment.prod);