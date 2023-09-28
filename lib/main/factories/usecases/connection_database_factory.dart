import 'package:frequency_app/data/database/database.dart';

import '../../../infra/database/database.dart';

Connection makeConnectionDatabaseFactory() => ConnectionDatabaseAdapter(
      host: 'ec2-54-83-138-228.compute-1.amazonaws.com',
      dbName: 'd5vsn8dl6eiaa1',
      port: 5432,
      username: 'tlxbjsdclpnssy',
      password: '46b5ea3e6560828909c57d1364ef7ac55ea2ac02520a49df3f3679bec8884886',
    );
