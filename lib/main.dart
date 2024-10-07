import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tubebuddy_3/features/presentation/home/page/home_page.dart';
import 'package:tubebuddy_3/features/presentation/home/provider/home_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(
            create: (context) => HomeProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
