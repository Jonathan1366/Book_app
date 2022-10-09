import 'dart:convert';
import 'package:book_app/controllers/book_controller.dart';
import 'package:book_app/models/book_list_response.dart';
import 'package:book_app/views/detail_book_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  BookController? bookController;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    bookController = Provider.of<BookController>(context, listen: false);
    bookController!.fetchBookApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Play Books",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: Consumer<BookController>(
        child: const Center(child: CircularProgressIndicator()),
        builder: (contex, controller, child) => Container(
            child: bookController!.bookList == null
                ? child
                : ListView.builder(
                    itemCount: bookController!.bookList!.books!.length,
                    itemBuilder: (context, index) {
                      final currentBook =
                          bookController!.bookList!.books![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailBookPage(isbn: currentBook.isbn13!),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Image.network(
                              currentBook.image!,
                              height: 200,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 0, right: 24, top: 3),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(currentBook.title!),
                                    Text(currentBook.subtitle!),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Align(
                                        alignment: Alignment.topRight,
                                        child: Text(currentBook.price!)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
      ),
    );
  }
}
