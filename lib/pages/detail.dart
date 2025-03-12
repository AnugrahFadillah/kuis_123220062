import 'package:flutter/material.dart';
import 'package:quiztpm/data/clothes_data.dart';

class DetailScreen extends StatefulWidget {
  final int index;

  const DetailScreen({super.key, required this.index});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isAddedToCart = false; // Status apakah produk telah ditambahkan ke cart

  void _toggleCartStatus() {
    setState(() {
      isAddedToCart = !isAddedToCart;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isAddedToCart
              ? "${clothesList[widget.index].name} added to cart"
              : "${clothesList[widget.index].name} removed from cart",
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final clothes = clothesList[widget.index];

    return Scaffold(
      appBar: AppBar(
        title: Text(clothes.name),
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: isAddedToCart ? Colors.red : Colors.white, // Warna berubah saat ditekan
            ),
            onPressed: _toggleCartStatus,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  clothes.imageUrl,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 100, color: Colors.grey);
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    clothes.name,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: isAddedToCart ? Colors.red : Colors.grey,
                      size: 24, // Ukuran ikon lebih kecil
                    ),
                    onPressed: _toggleCartStatus,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "Rp ${clothes.price.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 20, color: Colors.green),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow[700]),
                  const SizedBox(width: 4),
                  Text(
                    clothes.rating.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  Text("Sold: ${clothes.sold}"),
                ],
              ),
              const SizedBox(height: 16),
              Text("Category: ${clothes.category}"),
              Text("Brand: ${clothes.brand}"),
              const SizedBox(height: 8),
              Text("Available Sizes:", style: const TextStyle(fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 8.0,
                children: clothes.sizes.map((size) => Chip(label: Text(size))).toList(),
              ),
              const SizedBox(height: 8),
              Text("Available Colors:", style: const TextStyle(fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 8.0,
                children: clothes.colors.map((color) => Chip(label: Text(color))).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
