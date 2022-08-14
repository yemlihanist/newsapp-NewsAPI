import 'package:flutter/material.dart';
import 'package:newsapp/Provider/DataProvider.dart';
import 'package:provider/provider.dart';

import '../Model/object.dart';
import 'Detailpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var textConttroler = TextEditingController();
  bool search = false;
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
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Appcent NewsApp",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: SizedBox(
                        height: 50,
                        width: size.width,
                        child: TextField(
                          controller: textConttroler,
                          onSubmitted: (text) {
                            context.read<DataProvider>().getData(text.trim());
                          },
                          onChanged: (v) {
                            if (v.isEmpty) {
                              search = false;
                            } else {
                              search = true;
                            }
                            setState(() {});
                          },
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: search
                                ? IconButton(
                                    onPressed: () {
                                      textConttroler.clear();
                                    },
                                    icon: Icon(Icons.cancel_outlined),
                                  )
                                : null,
                            border: const OutlineInputBorder(),
                            hintMaxLines: 1,
                            labelText: "Search",
                            hintStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            Expanded(
              flex: 5,
              child: Consumer<DataProvider>(builder: (_, dataProvider, child) {
                List<Nesne> liste = dataProvider.getQuery();
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
    ));
  }
}
