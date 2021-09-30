import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter_testing_proj/models/catalog.dart';
import 'package:flutter_testing_proj/widgets/drawer.dart';
import 'package:flutter_testing_proj/widgets/item_widget.dart';
import 'package:flutter_testing_proj/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 2));
    final data = await rootBundle.loadString("assets/files/data.json");
    final decodedData = jsonDecode(data);
    var productsData = decodedData["products"];
    CatalogModel.items = List.from(productsData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, "/cart"),
        backgroundColor: context.theme.buttonColor,
        child: const Icon(
          CupertinoIcons.cart,
          color: Colors.white,
        ),
      ),
      backgroundColor: context.canvasColor,
      body: SafeArea(
        child: Container(
          padding: Vx.m32,
          child: Column(
            children: [
              const CatalogHeader(),
              if (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
                const CatalogList().py16().expand()
              else
                const Center(
                  child: CircularProgressIndicator(),
                )
            ],
          ),
        ),
      ),
      // appBar: AppBar(
      //   title: Text("Home"),
      // ),
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: CatalogModel.items != null && CatalogModel.items.isNotEmpty
      //       ?
      //       // ListView.builder(
      //       //     itemCount: CatalogModel.items.length,
      //       //     itemBuilder: (context, index) {
      //       //       return ItemWidget(
      //       //         item: CatalogModel.items[index],
      //       //       );
      //       //     })
      //       GridView.builder(
      //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //               crossAxisCount: 2,
      //               mainAxisSpacing: 16,
      //               crossAxisSpacing: 16),
      //           itemBuilder: (context, index) {
      //             final item = CatalogModel.items[index];
      //             return Card(
      //                 clipBehavior: Clip.antiAlias,
      //                 shape: RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(10)),
      //                 child: GridTile(
      //                   child: Image.network(item.image),
      //                   header: Container(
      //                     child: Text(
      //                       item.name,
      //                       style: TextStyle(color: Colors.white),
      //                     ),
      //                     padding: EdgeInsets.all(12),
      //                     decoration: const BoxDecoration(color: Colors.blue),
      //                   ),
      //                   footer: Container(
      //                     child: Text(
      //                       item.price.toString(),
      //                       style: TextStyle(color: Colors.white),
      //                     ),
      //                     padding: EdgeInsets.all(12),
      //                     decoration: const BoxDecoration(color: Colors.black
      //                     ),
      //                   ),
      //                 ));
      //           },
      //           itemCount: CatalogModel.items.length,
      //         )
      //       : const Center(
      //           child: CircularProgressIndicator(),
      //         ),
      // ),
      // drawer: MyDrawer(),
    );
  }
}

class CatalogHeader extends StatelessWidget {
  const CatalogHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Catalog App".text.xl5.bold.color(context.theme.accentColor).make(),
        "Trending products".text.xl2.make(),
      ],
    );
  }
}

class CatalogList extends StatelessWidget {
  const CatalogList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final catalog = CatalogModel.items[index];
          return CatalogItem(catalog: catalog);
        },
        itemCount: CatalogModel.items.length);
  }
}

class CatalogItem extends StatelessWidget {
  final Item catalog;

  const CatalogItem({Key? key, required this.catalog})
      : assert(catalog != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
        child: Row(
      children: [
        CatalogImage(image: catalog.image),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            catalog.name.text.lg.color(context.accentColor).bold.make(),
            catalog.desc.text.color(Colors.grey).make(),
            10.heightBox,
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              buttonPadding: EdgeInsets.zero,
              children: [
                "Rs ${catalog.price}".text.bold.xl.make(),
                _AddToCart()
              ],
            ).pOnly(right: 8)
          ],
        ))
      ],
    )).color(context.theme.cardColor).rounded.square(150).make().py16();
  }
}

class CatalogImage extends StatelessWidget {
  final String image;

  const CatalogImage({Key? key, required this.image})
      : assert(image != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(image)
        .box
        .rounded
        .p8
        .color(context.canvasColor)
        .make()
        .p16()
        .w40(context);
  }
}

class _AddToCart extends StatefulWidget {
  const _AddToCart({Key? key}) : super(key: key);

  @override
  State<_AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<_AddToCart> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, "/mobiles_detail");
        },
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(context.theme.buttonColor),
            shape: MaterialStateProperty.all(StadiumBorder())),
        child: "A2C".text.make());
  }
}
