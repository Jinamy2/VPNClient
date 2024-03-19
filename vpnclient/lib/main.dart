import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vpnclient/common/app_constants/app_routes.dart';
import 'package:vpnclient/common/app_constants/theme.dart';
import 'package:vpnclient/common/utils/getit_globals.dart';
import 'package:vpnclient/common/utils/navigator_key.dart';
import 'package:vpnclient/features/authorization/controllers/auth.provider.dart';

void main() {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingleton<AuthProvider>(AuthProvider());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => getIt<AuthProvider>()),
        ],
        builder: (_, __) => MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Vpn Client',
          theme: appTheme,
          routes: Routes.routes,
          initialRoute: Routes.auth,
        ),
      );
}
