import 'package:flutter/material.dart';
import 'package:newsapp/Page/HomePage.dart';
import 'package:provider/provider.dart';

import 'Page/RootPage.dart';
import 'Provider/DataProvider.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Rootpage(),
      ),
    );
  }
}
