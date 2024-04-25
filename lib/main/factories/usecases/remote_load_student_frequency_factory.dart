import '../../../data/data.dart';
import '../../../domain/domain.dart';
import '../factories.dart';

LoadStudentFrequency makeRemoteLoadStudentFrequency() => RemoteLoadStudentFrequency(getDatabase: makeConnectionDatabaseAdapter());
