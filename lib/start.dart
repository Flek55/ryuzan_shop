///Основной файл в приложении, работает с сервером и пользователем
import 'package:flutter/material.dart';

import 'db.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => StartState();
}

class StartState extends State<Start> {
  static List<Map<String, dynamic>> productData = [];
  static double w = 400;
  static double h = 150;

  @override
  void initState() {
    productData = ProductInfo.data;
    super.initState();
  }

  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    SingleChildScrollView(
      child: Column(children: [
        const Padding(padding: EdgeInsets.only(top: 10)),
        ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                child: InkWell(
                  onTap: (){},
                    child: Container(
                        height: 110,
                        child: Container(
                          width: w * 0.94,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            color: Colors.white70,
                            elevation: 10,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: w * 0.28,
                                      maxHeight: h * 0.28,
                                    ),
                                    child: Image.network(
                                        productData[index]["link"],
                                        fit: BoxFit.fill),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: w * 0.5,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 10, 0, 0),
                                        child: Text(
                                          '${productData[index]["name"]}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: w * 0.5,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 10, 0, 0),
                                        child: Text("${productData[index]["description"]}",
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 40, 0, 0),
                                      child: Text(
                                        '\₽ ${productData[index]["price"]}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ))));
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Padding(padding: EdgeInsets.only(top: 10));
          },
          itemCount: ProductInfo.data.length,
          shrinkWrap: true,
        ),
      ]),
    ),
    Text(
      'Index 1: Business',
    ),
    Text(
      'Index 2: School',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("dsd"),
                accountEmail: Text("dsd"),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.asset('assets/user_pic.jpg'),
                  ),
                ),
                decoration: const BoxDecoration(color: Colors.black38),
              ),
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ]),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Ryuzan",
          style: TextStyle(fontFamily: "Roboto", fontSize: 35),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: _widgetOptions[_selectedIndex],
      )),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
      );

  Widget buildMenuItems(BuildContext context) => Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: const Icon(
              Icons.home,
              size: 31,
            ),
            title: const Text(
              "Главная",
              style: TextStyle(fontSize: 23),
            ),
            onTap: () {
              _onItemTapped(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.shopping_cart,
              size: 31,
            ),
            title: const Text(
              "Корзина",
              style: TextStyle(fontSize: 23),
            ),
            onTap: () {
              _onItemTapped(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.info_outline_rounded,
              size: 31,
            ),
            title: const Text(
              "О нас",
              style: TextStyle(fontSize: 23),
            ),
            onTap: () {
              _onItemTapped(2);
              Navigator.pop(context);
            },
          ),
        ],
      );
}
