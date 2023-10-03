import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../factories.dart';

ClassroomUsecase makeRemoteLoadAula() => RemoteLoadAula(postDatabase: makeConnectionDatabaseAdapter(), getDatabase: makeConnectionDatabaseAdapter());
