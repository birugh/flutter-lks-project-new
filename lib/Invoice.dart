import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class InvoiceScreen extends StatefulWidget {
  final String token;
  final Map<String, dynamic> product;
  final int quantity;
  final String userId;

  const InvoiceScreen({
    super.key, 
    required this.token,
    required this.product,
    required this.quantity,
    required this.userId,
  });

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  bool isSaving = false;
  String? errorMessage;
  bool isSuccess = false;

  Future<void> saveInvoice() async {
    setState(() {
      isSaving = true;
      errorMessage = null;
      isSuccess = false;
    });

    try {
      var headers = {
        'Authorization': 'Bearer ${widget.token}',
        'Cookie': 'XSRF-TOKEN=eyJpdiI6InZsQ09RRHhEVkVrOE9aVE5LUzlqQVE9PSIsInZhbHVlIjoiZWdSaDlONnJhcVhJT09ZUktXYnk5NU14NEY1Y2JBU1dSK0ZxTVFkZFVLUkgrUmRzK3FzMG5heWdmVkFZTHJGbHYrSnhORmd1em5aakpWZ0xlSVhCU2dwSjBsZGZBVnJPRTZ1ajE1ZzhGWm9Lb0IwWWZPUCtUUFZLcWNVU3RaUkMiLCJtYWMiOiJkYzE4Y2NmMDY0MmY0YTBiZDQ1NWM2MjQ1YzExNGFjOGYzOWVkNDg5Y2QzNTU4ZmRkOGVhNmFlMDZmYjZlY2YyIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IkNLU3BYSlR0b3ZqLytVSmNnKzBYYUE9PSIsInZhbHVlIjoiWVJhUjFqQ01zUlhHT1dmeUFQZmRRcnBFRkhDbWg4UFlaYTdkRG9Xcm9KSld4WnppM0hmZ1JLaGw3bUFMUFBOUVJFcUhCSTdjTFVlMTQ3SEUvYmJKTzdnd0ZKanQwaTM3R1NGUzd6N3JWRmFLRDJSSGJHNXJIYkh6T2hSQkYxU1EiLCJtYWMiOiI0ZTNkYWU0MzlkOGY0MzQxOTA1NjliNjNmNWQzMWMwZDdmMjFlMThiMDE2NmNlNzU2MGFiNTY4NjlhYjVlZWRiIiwidGFnIjoiIn0%3D'
      };
      
      var data = FormData.fromMap({
        'product_id': widget.product['id'].toString(),
        'user_id': widget.userId,
        'qty': widget.quantity.toString(),
      });

      var dio = Dio();
      var response = await dio.request(
        'https://flaminggo.my.id/api/cart',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        setState(() {
          isSuccess = true;
        });
        print(json.encode(response.data));
      } else {
        setState(() {
          errorMessage = response.statusMessage ?? 'Failed to save invoice';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      setState(() {
        isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalAmount = (widget.product['mp_price'] as num) * widget.quantity;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Details
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[200],
                      ),
                      child: widget.product['mp_photo'] != null
                          ? Image.network(
                              "https://flaminggo.my.id/${widget.product['mp_photo']}",
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.image_not_supported),
                            )
                          : const Icon(Icons.image_not_supported),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product['mp_name'] ?? 'Product Name',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Price: Rp ${widget.product['mp_price']}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Quantity: ${widget.quantity}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Order Summary
            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal:'),
                        Text('Rp ${widget.product['mp_price']}'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Quantity:'),
                        Text('${widget.quantity}'),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Rp $totalAmount',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Status Messages
            if (errorMessage != null)
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),

            if (isSuccess)
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Order successfully saved!',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 24),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isSaving || isSuccess ? null : saveInvoice,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: isSaving
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Confirm Order',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
