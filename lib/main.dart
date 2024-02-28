import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

import 'controllers/provider/user_details_provider.dart';
import 'services/db_services/hive_db.dart';
import 'views/home_screen/user_detail_screen.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDir = await getApplicationDocumentsDirectory();
  Hive
    ..init(appDocDir.path)
    ..registerAdapter(UserModelAdapter())
    ..registerAdapter(AddressAdapter())
    ..registerAdapter(GeoAdapter())
    ..registerAdapter(CompanyAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserDataProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.expletusSansTextTheme(
            Theme.of(context).textTheme.apply(
                  fontFamily: 'ExpletusSans',
                ),
          ),
        ),
        home: const UserDetailsScreen(),
      ),
    );
  }
}
