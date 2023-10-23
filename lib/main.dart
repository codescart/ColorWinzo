import 'package:ColorWinzo/widgets/launcherapi.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ColorWinzo/login_directory/splash_page.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();


  if(kIsWeb){
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAAwKUZg21Bz4zAHwdrtWA_p_COPP8JliA",
        appId: "1:470004766738:web:e94dbbf0bd742858ec20cb",
        messagingSenderId: "470004766738",
        projectId: "hope-gaming", ), );

  }else{
     await Firebase.initializeApp();
  }
  runApp(const MyApp());
  setPathUrlStrategy();
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
   // fetchlauncherdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Color Winzo',
          theme: ThemeData(
            primarySwatch: Colors.blue,

          ),
          // theme: lightTheme,
          // darkTheme: darkTheme,
          home: child,
        );
      },
      child: splash(),
    );
  }
}

