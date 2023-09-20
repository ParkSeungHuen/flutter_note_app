import 'package:flutter/material.dart';
import 'package:flutter_note_app/presentation/notes/notes_screen.dart';
import 'package:flutter_note_app/router.dart';
import 'package:flutter_note_app/ui/colors.dart';
import 'package:provider/provider.dart';

import 'di/di_setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 플랫폼 채널의 위젯 바인딩을 보장, 화면 띄우기 전에 이게 작동되어야 함

  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      theme: ThemeData(
          unselectedWidgetColor: Colors.white,
          primaryColor: Colors.white,
          canvasColor: darkGray,
          floatingActionButtonTheme:
              Theme.of(context).floatingActionButtonTheme.copyWith(
                    backgroundColor: lightBlue,
                    foregroundColor: darkGray,
                  ),
          // floatingActionButtonTheme를 사용해서 속성의 일부분을 바꿀 수 있다

          appBarTheme: Theme.of(context).appBarTheme.copyWith(
                backgroundColor: darkGray,
              ),
          // appBarTheme도 마찬가지, icon 및 text들도 일부분만 바꾸고 싶으면 해도 됨
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
              )),

    );
  }
}
