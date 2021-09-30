import 'package:flutter/material.dart';
import 'package:flutter_testing_proj/models/mobile.dart';
import 'package:flutter_testing_proj/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class ViewDetail extends StatelessWidget {
  final Mobiles mobiles;

  const ViewDetail({Key? key, required this.mobiles})
      : assert(mobiles != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: Container(
        color: context.cardColor,
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          buttonPadding: EdgeInsets.zero,
          children: [
            "Rs ${mobiles.price}".text.bold.xl4.red800.make(),
            ElevatedButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, "/mobiles_detail");
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(context.theme.buttonColor),
                        shape: MaterialStateProperty.all(StadiumBorder())),
                    child: "Add to cart".text.make())
                .wh(120, 50)
          ],
        ).p32(),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Hero(
                        tag: Key(mobiles.id.toString()),
                        child: Image.network(mobiles.image))
                    .h24(context),
              ),
            ),
            Expanded(
                child: VxArc(
              height: 30.0,
              arcType: VxArcType.CONVEY,
              edge: VxEdge.TOP,
              child: Container(
                width: context.screenWidth,
                color: context.cardColor,
                child: Column(
                  children: [
                    mobiles.name.text.xl4
                        .color(context.accentColor)
                        .bold
                        .make(),
                    mobiles.desc.text.color(Colors.grey).xl.make(),
                    10.heightBox,
                    "Lorem ipsum sit dollor amit Lorem ipsum sit dollor Lorem ipsum sit dollor amit Lorem ipsum sit dollor amit Lorem ipsum sit dollor amit Lorem ipsum sit dollor amit Lorem ipsum sit dollor amit Lorem ipsum sit dollor amit Lorem ipsum sit dollor amit"
                        .text
                        .color(Colors.grey)
                        .make()
                        .p16()
                  ],
                ).py64(),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
