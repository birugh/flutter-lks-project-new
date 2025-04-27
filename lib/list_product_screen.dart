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
          ListViewProduct(context, products),
          // Products(context),
          ElevatedButton(onPressed: GetDataList, child: Text('Debug'))
        ],
      ),
      bottomNavigationBar: NavigationBarStateful(initialIndex: 0, token: widget.token),
    );
  }

  Future<void> GetDataList() async {
    try {
      var headers = {
        'Authorization': 'Bearer ${widget.token}',
      };
      var data = {};
      var dio = Dio();
      var response = await dio.request(
        'https://flaminggo.my.id/api/products',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
        data: data,
      );
      print(response.data);
      if (response.data != null &&
          response.data['data'] != null &&
          response.data['data']['data'] != null) {
        dataBaru = response.data['data']['data'];
        dummyData = List.from(dataBaru);
        products = List.from(dataBaru);
        setState(() {});
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print(e);
    }
  }
}

Widget ListViewProduct(BuildContext context, List<dynamic> products) {
  return Expanded(
    child: ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        var product = products[index];
        return Products(context, product);
      },
    ),
  );
}

Widget Products(BuildContext context, Map<String, dynamic> product) {
  String imageUrl = product['mp_photo'] != null
      ? 'https://flaminggo.my.id/${product['mp_photo']}'
      : '';
  String name = product['mp_name'] ?? 'No Name';
  String price = product['mp_price'] != null ? 'Rp. ${product['mp_price']}' : 'No Price';
  String rate = product['mp_rate'] != null ? product['mp_rate'].toString() : '0';

  return Container(
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            SizedBox(width: 10),
            imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    width: 70,
                    height: 70,
                    errorBuilder: (context, error, stackTrace) {
                      return SizedBox(
                        width: 70,
                        height: 70,
                        child: Icon(Icons.image, color: Colors.grey, size: 50),
                      );
                    },
                  )
                : SizedBox(
                    width: 70,
                    height: 70,
                    child: Icon(Icons.image, color: Colors.grey, size: 50),
                  ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.star, size: 14, color: Color(0xFFfede2e)),
                      SizedBox(width: 4),
                      Text(
                        rate,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    price,
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
                          // TODO: Implement decrement quantity
                        },
                        icon: Icon(
                          Icons.remove_circle,
                          size: 20,
                          color: Color(0xFF747474),
                        ),
                      ),
                      Text(
                        '0', // TODO: Replace with actual quantity
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // TODO: Implement increment quantity
                        },
                        icon: Icon(
                          Icons.add_circle,
                          size: 20,
                          color: Color(0xFF747474),
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFF88c8fd),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: IconButton(
                          onPressed: () {
                            // TODO: Implement add to cart
                          },
                          icon: Icon(
                            Icons.shopping_cart_rounded,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
