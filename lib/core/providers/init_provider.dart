import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tubebuddy_3/features/presentation/home/provider/home_provider.dart';

List<dynamic> get initProviders {
  return [
    ChangeNotifierProvider<HomeProvider>(create: (context) => HomeProvider()),
  ];
}
