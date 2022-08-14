import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/object.dart';
import '../Provider/DataProvider.dart';
import 'Detailpage.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              const Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Favorites",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child:
                    Consumer<DataProvider>(builder: (_, dataProvider, child) {
                  List<Nesne> liste = dataProvider.getFavorite();
                  return ListView.builder(
                      itemCount: liste.length,
                      itemBuilder: (context, index) {
                        Nesne nesne = liste[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => Detailpage(
                                          nesne: nesne,
                                        )));
                          },
                          child: Card(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 10, top: 5, left: 5),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            nesne.title,
                                            style: TextStyle(fontSize: 18),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                            nesne.content.substring(0, 100) +
                                                "..."),
                                      )
                                    ],
                                  ),
                                ),
                                if (nesne.urlToImage.isNotEmpty)
                                  Expanded(
                                      flex: 1,
                                      child: Image.network(nesne.urlToImage)),
                              ],
                            ),
                          ),
                        );
                      });
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
