import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_testing_proj/models/mobile.dart';
import 'package:flutter_testing_proj/pages/view_mobile_detail.dart';
import 'package:flutter_testing_proj/widgets/themes.dart';
import 'package:velocity_x/src/extensions/context_ext.dart';

class MobileDetail extends StatefulWidget {
  const MobileDetail({Key? key}) : super(key: key);

  @override
  _MobileDetailState createState() => _MobileDetailState();
}

class _MobileDetailState extends State<MobileDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 2));
    final data = await rootBundle.loadString("assets/files/data.json");
    final decodeData = jsonDecode(data);
    var productsData = decodeData["products"];
    MobileModel.mobiles = List.of(productsData)
        .map<Mobiles>((mobiles) => Mobiles.fromMap(mobiles))
        .toList();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                const HeaderDetail(),
                if (MobileModel.mobiles != null &&
                    MobileModel.mobiles.isNotEmpty)
                  const MobilesList()
                else
                  const Center(
                    child: CircularProgressIndicator(),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HeaderDetail extends StatelessWidget {
  const HeaderDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
      child: Text(
        "Mobile Detail",
        style: TextStyle(
          color: context.theme.accentColor,
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),
      ),
    );
  }
}

class MobilesList extends StatelessWidget {
  const MobilesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 16, crossAxisSpacing: 16),
      itemCount: MobileModel.mobiles.length,
      itemBuilder: (context, index) {
        final mobile = MobileModel.mobiles[index];
        return GridItem(mobile: mobile);
      },
    );
  }
}

class GridItem extends StatelessWidget {
  final Mobiles mobile;

  const GridItem({Key? key, required this.mobile})
      : assert(mobile != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewDetail(mobiles: mobile),
          )),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: GridTile(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Hero(
                tag: Key(mobile.id.toString()),
                child: Image.network(mobile.image)),
          ),
          header: Container(
            child: Text(
              mobile.name,
              style: TextStyle(
                  // backgroundColor: MyThemes.darkBluishColor,
                  color: MyThemes.creamColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(color: MyThemes.darkBluishColor),
          ),
          footer: Container(
            child: Text(
              "Rs ${mobile.price}",
              style: TextStyle(
                  color: context.theme.accentColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
