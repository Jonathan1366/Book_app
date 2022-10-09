import 'package:book_app/controllers/book_controller.dart';
import 'package:book_app/views/image_view_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' show canLaunchUrl, launchUrl;

class DetailBookPage extends StatefulWidget {
  const DetailBookPage({super.key, required this.isbn});
  final String isbn;

  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  BookController? controller;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    controller = Provider.of<BookController>(context, listen: false);
    controller!.fetchDetailBookApi(widget.isbn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Detail Book "),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      body: Consumer<BookController>(builder: (context, controller, child) {
        return controller.detailBook == null
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageViewsScreen(
                                    imageUrl: controller.detailBook!.image!),
                              ),
                            );
                          },
                          child: Image.network(
                            controller.detailBook!.image!,
                            height: 180,
                            width: 160,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 19),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.detailBook!.title!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.5,
                                  ),
                                ),
                                Text(
                                  controller.detailBook!.authors!,
                                  style: const TextStyle(
                                      fontSize: 12.1,
                                      color:
                                          Color.fromARGB(255, 117, 116, 116)),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: List.generate(
                                    5,
                                    (index) => Icon(
                                      Icons.star,
                                      color: index <
                                              int.parse(controller
                                                  .detailBook!.rating!)
                                          ? const Color.fromARGB(
                                              255, 255, 213, 0)
                                          : const Color.fromARGB(
                                              255, 90, 90, 90),
                                    ),
                                  ),
                                ),
                                Text(
                                  controller.detailBook!.subtitle!,
                                  style: const TextStyle(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 450,
                      child: ElevatedButton(
                        onPressed: () async {
                          ("url");
                          Uri uri = Uri.parse(controller.detailBook!.url!);
                          try {
                            (await canLaunchUrl(uri))
                                ? launchUrl(uri)
                                : ("navigation doesnt work");
                          } catch (e) {
                            ("Error");
                            (e);
                          }
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11.5),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Buy  ${controller.detailBook!.price!}",
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text("About this book",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14.5)),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      controller.detailBook!.desc!,
                      style: const TextStyle(fontSize: 12.4),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Year: ${controller.detailBook!.year!}",
                          style: const TextStyle(fontSize: 12.4),
                        ),
                        Text(
                          "ISBN: ${controller.detailBook!.isbn13!}",
                          style: const TextStyle(fontSize: 12.4),
                        ),
                        Text(
                          "${controller.detailBook!.pages!} Page",
                          style: const TextStyle(fontSize: 12.4),
                        ),
                        Text(
                            style: const TextStyle(fontSize: 12.4),
                            "Publisher:  ${controller.detailBook!.publisher!}"),
                        Text(
                            style: const TextStyle(fontSize: 12.4),
                            "Language:  ${controller.detailBook!.language!}"),
                        //Text(detailBook!.rating!),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text("Similiar Books",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                      ],
                    ),
                    controller.similiarBooks == null
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: 2000,
                            height: 210,
                            child: ListView.builder(
                              //shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  controller.similiarBooks!.books!.length,
                              //physics: NeverScrollableScrollPhysics(),

                              itemBuilder: (context, index) {
                                final current =
                                    controller.similiarBooks!.books![index];
                                return SizedBox(
                                  width: 120,
                                  child: Column(children: [
                                    Image.network(
                                      current.image!,
                                      height: 150,
                                    ),
                                    const SizedBox(
                                      height: 0,
                                    ),
                                    Text(
                                      current.title!,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.clip,
                                      style: const TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      controller.detailBook!.price!,
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ]),
                                );
                              },
                            ),
                          )
                  ],
                ),
              );
      }),
    );
  }
}
