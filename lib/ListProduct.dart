import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lks_project_new/navigation_bar.dart';

class ListProductStateful extends StatefulWidget {
  final String token;
  const ListProductStateful({super.key, required this.token});

  @override
  State<ListProductStateful> createState() => _ListProductStatefulState();
}

class _ListProductStatefulState extends State<ListProductStateful> {
  final List<int> quantities = [0, 0, 0, 0];

  List<dynamic> products = [];
  List<dynamic> dataBaru = [];
  List<dynamic> dummyData = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    GetDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                HeaderTitle(context),
              ],
            ),
            const SizedBox(height: 20),
            SearchingProduct(context),
            ListViewProduct(context)
          ],
        ),
      ),
      bottomNavigationBar: NavigationBarStateful(token: widget.token),
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

  Widget ListViewProduct(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          if (quantities.length < products.length) {
            quantities.add(0);
          }

          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: product['mp_photo'] != null
                        ? Image.network(
                            "https://flaminggo.my.id/${product['mp_photo']}",
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.image_not_supported),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['mp_name'] ?? '-',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Price: Rp ${product['mp_price'] ?? 0}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                setState(
                                  () {
                                    if (quantities[index] > 0) {
                                      quantities[index]--;
                                    }
                                  },
                                );
                              },
                            ),
                            Text(
                              quantities[index].toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(
                                  () {
                                    quantities[index]++;
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          Text(product['mp_rate'] ?? '0'),
                        ],
                      ),
                      const SizedBox(height: 30),
                      IconButton(
                        icon: const Icon(Icons.shopping_cart),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {},
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget SearchingProduct(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Text(
            'Products',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 150),
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 5),
              ),
              onChanged: (value) {
                if (value.isEmpty) {
                  setState(
                    () {
                      products = List.from(dummyData);
                    },
                  );
                } else {
                  setState(
                    () {
                      products = dataBaru.where((product) {
                        final name =
                            product['mp_name']?.toString().toLowerCase() ?? '';
                        final searchLower = value.toLowerCase();
                        return name.contains(searchLower);
                      }).toList();
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget HeaderTitle(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await GetDataList();
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(top: 50, left: 0),
        decoration: BoxDecoration(
          color: Colors.grey,
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Image.asset(
              'assets/images/Logo.png',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 20),
            const Text(
              'LKS Mart',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}