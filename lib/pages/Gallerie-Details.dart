import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:voyage/menu/drawer.widget.dart';
import 'package:http/http.dart' as http;

class GallerieDetailspage extends StatefulWidget {
  String keyword = "";

  GallerieDetailspage(this.keyword);

  @override
  State<GallerieDetailspage> createState() => _GallerieDetailspageState();
}

class _GallerieDetailspageState extends State<GallerieDetailspage> {
  int currentPage = 1;
  int size = 10;
  late int totalPages;
  ScrollController _scrollController = ScrollController();
  List<dynamic> hits = [];

  @override
  void initState() {
    super.initState();
    getGalleryData(widget.keyword);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (currentPage < totalPages) {
          currentPage++;
          getGalleryData(widget.keyword);
        }
      }
    });
  }

  void getGalleryData(String keyword) {
    print("Météo de la ville de " + keyword);
    String url =
        "https://pixabay.com/api/?key=15646595-375eb91b3408e352760ee72c8&q=${keyword}&page=${currentPage}&per_page=${size}";

    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        var galleryData = json.decode(resp.body);
        hits.addAll(galleryData['hits']);
        totalPages = (galleryData['totalHits'] / size).ceil();
        print(hits);
      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: totalPages == 0
            ? Text('Pas de résultats')
            : Text("${widget.keyword}, Page ${currentPage}/${totalPages}"),
      ),
      backgroundColor: Colors.blue,
      body: (hits.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: hits.length,
        controller: _scrollController,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                child: Card(
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${hits[index]['tags']}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Card(
                  child: Image.network(
                    hits[index]['largeImageURL'],
                    fit: BoxFit.fitWidth,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ],
          );
        },
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
