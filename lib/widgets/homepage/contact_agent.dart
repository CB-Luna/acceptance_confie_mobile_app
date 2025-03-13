import 'package:flutter/material.dart';
import '../contactcenter/request_call.dart';

class ContactAgent extends StatelessWidget {
  const ContactAgent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FDFF),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFE8E8E8),
          width: 1,
        ),
        boxShadow: [
          const BoxShadow(
            color: Color(0x12000000),
            offset: Offset(0, 2),
            blurRadius: 13,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/home/icons/contactagent.png',
                width: 47,
                height: 36,
              ),
              const SizedBox(width: 16),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Need Changes?',
                    style: TextStyle(
                      color: Color(0xFFC74E10),
                      fontFamily: 'Open Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 18 / 14,
                      letterSpacing: 0,
                    ),
                  ),
                  Text(
                    'Contact My Agent',
                    style: TextStyle(
                      color: Color(0xFF0047BB),
                      fontFamily: 'Open Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      height: 18 / 14,
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RequestCallPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0047BB),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
            ),
            child: const Text(
              'Call Now',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Open Sans',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                height: 18 / 14,
                letterSpacing: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
