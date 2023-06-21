import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'package:shooping_card/cart_model.dart';
import 'package:shooping_card/cart_provider.dart';
import 'package:shooping_card/cart_screen.dart';
import 'package:shooping_card/db_helper.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  DBHelper? dbHelper = DBHelper();

  List<String> productName = [
    'Mango',
    'Orange',
    'Grapes',
    'Banana',
    'Chery',
    'Peach',
    'Mixed Fruit Basket'
  ];
  List<String> productUnit = ['Kg', 'Dozen', 'Kg', 'Dozen', 'Kg', 'Kg', 'Kg'];

  List<int> productPrice = [10, 20, 30, 40, 50, 60, 70];

  List<String> productImage = [
    'https://dryfruitsmandy.com/wp-content/uploads/2021/04/mango-medium.jpg',
    'https://tse2.mm.bing.net/th?id=OIP.a7pHxxnUScjVp9MPF4mWoAHaFi&pid=Api&P=0',
    'https://tse3.mm.bing.net/th?id=OIP.KNHJ3Zj5fMpWo1Hhs97uDwHaF7&pid=Api&P=0',
    'https://tse2.mm.bing.net/th?id=OIP.4VlM4J-A3N0Eo9sUNmWXlAHaFp&pid=Api&P=0',
    'https://tse2.mm.bing.net/th?id=OIP.baF3qXJgauQwizZMcBUpBgHaGZ&pid=Api&P=0',
    'https://tse1.mm.bing.net/th?id=OIP.lJYLQVuxpMnigk8NPjulDAHaGA&pid=Api&P=0',
    'https://tse3.mm.bing.net/th?id=OIP.JeF2KAZviinPMn8Vv62VEQHaHa&pid=Api&P=0'
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Proudct List"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const CartScreen();
              }));
            },
            child: Center(
              child: badges.Badge(
                badgeContent:
                    Consumer<CartProvider>(builder: (context, value, child) {
                  return Text(
                    value.getCounter().toString(),
                    style: const TextStyle(color: Colors.white),
                  );
                }),
                child: const Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: productName.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Image(
                                  height: 100,
                                  width: 100,
                                  image: NetworkImage(
                                      productImage[index].toString())),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productName[index].toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      productUnit[index].toString() +
                                          " " +
                                          r"$" +
                                          productPrice[index].toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () {
                                          dbHelper!
                                              .insert(
                                            Cart(
                                                id: index,
                                                productId: index.toString(),
                                                productName: productName[index]
                                                    .toString(),
                                                initalPrice:
                                                    productPrice[index],
                                                productPrice:
                                                    productPrice[index],
                                                qunatitiy: 1,
                                                unitStage: productUnit[index]
                                                    .toString(),
                                                image: productImage[index]
                                                    .toString()),
                                          )
                                              .then((value) {
                                            // ignore: avoid_print
                                            print("Product is Add to Cart");
                                            cart.addTotalPrice(double.parse(
                                                productPrice[index]
                                                    .toString()));
                                            cart.addCounter();
                                          }).onError((error, stackTrace) {
                                            // ignore: avoid_print
                                            print(error.toString());
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          child: const Center(
                                            child: Text(
                                              "Add to Cart",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
