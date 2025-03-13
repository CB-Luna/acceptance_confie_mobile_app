import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BluefireClaimCard extends StatelessWidget {
  const BluefireClaimCard({super.key});

  void _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A111111),
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            'assets/products/vehiclepng/4.0x/Bluefire.png',
            height: 40,
          ),
          const SizedBox(height: 16),
          const Text(
            'Bluefire Insurance Claims',
            style: TextStyle(
              color: Color(0xFF0047BB),
              fontSize: 20,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'To start the process, please enter the\nBluefire Insurance Policy Number',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF414648),
              fontSize: 14,
              height:
                  1.43, // This gives us the 20px line height (14 * 1.43 ≈ 20)
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w600,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 16),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'If the policy starts with CNM,\nplease call ',
                  style: TextStyle(
                    color: Color(0xFF414648),
                    fontSize: 14,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () => _launchPhone('8332863057'),
                    child: const Text(
                      '(833) 286-3057',
                      style: TextStyle(
                        color: Color(0xFF0047BB),
                        fontSize: 14,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'If the policy starts with GSP,\nplease call ',
                  style: TextStyle(
                    color: Color(0xFF414648),
                    fontSize: 14,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () => _launchPhone('8004683466'),
                    child: const Text(
                      '(800) 468-3466',
                      style: TextStyle(
                        color: Color(0xFF0047BB),
                        fontSize: 14,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 18,
                height: 25,
                child: Checkbox(
                  value: false,
                  onChanged: (value) {
                    // TODO: Implement checkbox state
                  },
                  activeColor: const Color(0xFF0047BB),
                  side: const BorderSide(
                    color: Color(0xFF0046B9),
                    width: 2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'I am the Bluefire policyholder',
                style: TextStyle(
                  color: Color(0xFF414648),
                  fontSize: 14,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Please enter the full policy number including the letters. Do not enter the dash or any numbers after the dash. Example: TXA10000000',
            style: TextStyle(
              color: Color(0xFF414648),
              fontSize: 12,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement start claim
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0047BB),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Start My Claim',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
