import 'package:flutter/material.dart';
import 'package:freeway_app/widgets/insproducts/motorcycle_insurance_page.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class ProductCarousel extends StatelessWidget {
  const ProductCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = [
      {
        'icon': Icons.car_crash,
        'color': Colors.blue,
        'title': 'Roadside\nAssistance',
        'onTap': () {},
      },
      {
        'icon': Icons.motorcycle,
        'color': Colors.green,
        'title': 'Motorcycle\nInsurance',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MotorcycleInsurancePage(),
            ),
          );
        },
      },
      {
        'icon': Icons.apartment,
        'color': Colors.orange,
        'title': 'Building\nInsurance',
        'onTap': () {},
      },
      {
        'icon': Icons.house,
        'color': Colors.blue,
        'title': 'House\nInsurance',
        'onTap': () {},
      },
      {
        'icon': Icons.pets,
        'color': Colors.brown,
        'title': 'Animals\nInsurance',
        'onTap': () {},
      },
    ];

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => SizedBox(
        height: 80,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: InkWell(
                onTap: products[index]['onTap'],
                child: Card(
                  elevation: 2,
                  color: themeProvider.isDarkMode
                      ? const Color(0xFF2A4365)
                      : Colors.white,
                  child: Container(
                    width: 150,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      children: [
                        Icon(
                          products[index]['icon'],
                          color: products[index]['color'],
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            products[index]['title'],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: themeProvider.isDarkMode
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
