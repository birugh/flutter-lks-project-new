import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lks_project_new/navigation_bar.dart';

class ListProductStateful extends StatefulWidget {
  const ListProductStateful({super.key, required this.token});
  final token;

  @override
  State<ListProductStateful> createState() => _ListProductStatefulState();
}

class _ListProductStatefulState extends State<ListProductStateful> {
  List<dynamic> products = [];
  List<dynamic> dataBaru = [];
  List<dynamic> dummyData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          HeaderApp(context),
          SubHeader(context),
          ListViewProduct(context),
          // Products(context),
        ],
      ),
      bottomNavigationBar: NavigationBarStateful(initialIndex: 0, token: widget.token),
    );
  }

  Future<void> GetDataList() async {
    var headers = {
      'Authorization':
          'Bearer ${widget.token}',
    };
    var data = {};
    var dio = Dio();
    var response = await dio.request(
      'https://flaminggo.my.id/api/products',
      options: Options(method: 'GET', headers: headers),
      data: data,
    );

    if (response.data != null &&
        response.data['data'] != null &&
        response.data['data']['data'] != null) {
      dataBaru = response.data['data']['data'];
      dummyData = dataBaru;
      products = dataBaru;
      setState(() {});
    } else {
      print(response.statusMessage);
    }
  }
}

Widget ListViewProduct(BuildContext context) {
  return Expanded(child: ListView.builder(
    itemCount: 4,
    itemBuilder: (context, index) {
      return ListTile(
        
      );
    },
  ));
}

Widget Products(BuildContext context) {
  return Container(
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            SizedBox(width: 10),
            Image.asset(
              '',
              errorBuilder: (context, error, stackTrace) {
                return SizedBox(
                  child: Icon(Icons.image, color: Colors.grey, size: 50),
                );
              },
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Fanta Orange',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 180),
                    Icon(Icons.star, size: 14, color: Color(0xFFfede2e)),
                    Text(
                      '4.9',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Rp. 7.000',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        //
                      },
                      icon: Icon(
                        Icons.remove_circle,
                        size: 20,
                        color: Color(0xFF747474),
                      ),
                    ),
                    Text(
                      '0',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        //
                      },
                      icon: Icon(
                        Icons.add_circle,
                        size: 20,
                        color: Color(0xFF747474),
                      ),
                    ),
                    SizedBox(width: 160),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFF88c8fd),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: IconButton(
                        onPressed: () {
                          //
                        },
                        icon: Icon(Icons.shopping_cart_rounded, size: 20, color: Colors.white,),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget HeaderApp(BuildContext context) {
  return Container(
    width: 320,
    height: 90,
    decoration: BoxDecoration(
      color: Color(0xFFd8d8d8),
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
    ),
    child: Row(
      children: [
        SizedBox(width: 40),
        Image.asset('assets/Logo.png', height: 70),
        Text(
          'LKS Mart',
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3f6585),
          ),
        ),
      ],
    ),
  );
}

Widget SubHeader(BuildContext context) {
  final searchController = TextEditingController();
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: SizedBox(
      height: 40,
      child: Row(
        children: [
          Text(
            'Produk',
            style: TextStyle(
              color: Color(0xFF456889),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 150),
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ),
        ],
      ),
    ),
  );
}
