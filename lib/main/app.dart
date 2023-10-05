import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'factories/factories.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      getPages: [
        GetPage(name: '/', page: makeSplashPage),
        GetPage(name: '/login', page: makeLoginPage),
        GetPage(name: '/home', page: makeHomePage, transition: Transition.noTransition),
        GetPage(name: '/classroom', page: makeClassroomPage, transition: Transition.noTransition),
      ],
    );
  }
}
