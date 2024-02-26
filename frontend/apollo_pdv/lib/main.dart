import 'package:apollo_pdv/providers/company_provider.dart';
import 'package:apollo_pdv/providers/products_provider.dart';
import 'package:apollo_pdv/providers/sales_provider.dart';
import 'package:apollo_pdv/providers/tasks_provider.dart';
import 'package:apollo_pdv/screens/dashboard/dashboard_screen.dart';
import 'package:apollo_pdv/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    fullScreen: false,
    // windowButtonVisibility: false
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final AppTheme _theme = AppTheme();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductsProvider()),
        ChangeNotifierProvider(create: (context) => SalesProvider()),
        ChangeNotifierProvider(create: (context) => TasksProvider()),
        ChangeNotifierProvider(create: (context) => CompanyProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: _theme.primaryColor,
            elevation: 0,
          ),
          useMaterial3: false,
        ),
        title: "Pdv",
        home: DashboardScreen(),
      ),
    );
  }
}
