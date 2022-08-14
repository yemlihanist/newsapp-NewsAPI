import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:newsapp/Model/object.dart';
import 'package:newsapp/Page/WebVievPage.dart';
import 'package:newsapp/Provider/DataProvider.dart';
import 'package:provider/provider.dart';

class Detailpage extends StatefulWidget {
  Nesne nesne;

  Detailpage({Key? key, required this.nesne}) : super(key: key);

  @override
  State<Detailpage> createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios)),
                Spacer(),
                IconButton(
                    onPressed: () async {
                      await FlutterShare.share(
                          title: widget.nesne.title,
                          text: widget.nesne.content,
                          linkUrl: widget.nesne.url,
                          chooserTitle: widget.nesne.title);
                    },
                    icon: Icon(Icons.share)),
                IconButton(
                    onPressed: () {
                      if (context
                          .read<DataProvider>()
                          .isFavorite(widget.nesne)) {
                        context
                            .read<DataProvider>()
                            .removeFavorite(widget.nesne);
                      } else {
                        context.read<DataProvider>().addFavorite(widget.nesne);
                      }
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.favorite,
                      color:
                          context.read<DataProvider>().isFavorite(widget.nesne)
                              ? Colors.red
                              : Colors.grey,
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                widget.nesne.urlToImage,
                width: size.width,
                height: 200,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 5, left: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.nesne.title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 5, left: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.nesne.content,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: size.width / 2,
        height: 60,
        child: Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => WebVievPage(url: widget.nesne.url)));
                },
                child: Text("News Source"))),
      ),
    );
  }
}
