import 'package:flutter/material.dart';
import 'package:flutter_testing_proj/models/cart.dart';
import 'package:flutter_testing_proj/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Cart"),
      ),
      body: Column(
        children: [
          _CardList().p32().expand(),
          Divider(),
          _CartTotal(),
        ],
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  const _CartTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _cart = CartModel();
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          "Rs ${_cart.totalPrice}"
              .text
              .xl5
              .color(context.theme.accentColor)
              .make(),
          30.widthBox,
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: "Buying not supported yet".text.make(),
              ));
            },
            child: "Buy".text.white.make(),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(context.theme.buttonColor)),
          ).w32(context)
        ],
      ),
    );
  }
}

class _CardList extends StatefulWidget {
  const _CardList({Key? key}) : super(key: key);

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<_CardList> {
  final _cart = CartModel();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.done),
        trailing: IconButton(
          icon: Icon(Icons.remove_circle_outline),
          onPressed: () {},
        ),
        title: _cart.items[index].name.text.make(),
      ),
      itemCount: _cart.items.length,
    );
  }
}
