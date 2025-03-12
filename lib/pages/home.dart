import 'package:flutter/material.dart';
import 'package:quiztpm/data/clothes_data.dart';
import 'package:quiztpm/pages/detail.dart';
import 'package:quiztpm/pages/login.dart';

class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({super.key, required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> selectedItems = []; // List untuk menyimpan item yang telah ditekan

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          itemCount: clothesList.length,
          itemBuilder: _buildProductCard,
        ),
      ),
    );
  }

  // 🔹 APPBAR DENGAN FOTO PROFIL (TANPA ICON CART)
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 3,
      title: Row(
        children: [
          ClipOval(
            child: Image.asset(
              'assets/profile.jpg',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.person, color: Colors.white),
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "Hi, ${widget.username}!",
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.black),
          onPressed: _logout,
        ),
      ],
    );
  }

  // 🔹 LOGOUT FUNCTION
  void _logout() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Logout berhasil!"),
        backgroundColor: Colors.green,
      ),
    );

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  // 🔹 TAMPILAN KARTU PRODUK DENGAN CART ICON YANG BERUBAH WARNA
  Widget _buildProductCard(BuildContext context, int index) {
    bool isSelected = selectedItems.contains(index);

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailScreen(index: index),
          ),
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  clothesList[index].imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(clothesList[index].name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text("${clothesList[index].brand} | Terjual ${clothesList[index].sold} buah",
                      style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  const SizedBox(height: 4),
                  Text("Rp ${clothesList[index].price}",
                      style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.add_shopping_cart,
                        color: isSelected ? Colors.red : Colors.blue, // Warna berubah jika ditekan
                      ),
                      onPressed: () {
                        setState(() {
                          if (isSelected) {
                            selectedItems.remove(index);
                          } else {
                            selectedItems.add(index);
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
