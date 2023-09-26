import 'package:frequency_app/data/usecases/authentication/remote_authentication.dart';
import 'package:frequency_app/domain/domain.dart';

import '../factories.dart';

Authentication makeRemoteAuthentication() => RemoteAuthentication(url: makeApiUrl('auth/login'), httpClient: makeHttpAdapter());
