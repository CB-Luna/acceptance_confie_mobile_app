import 'package:flutter/material.dart';

import '../../pages/home_page.dart';
import '../../utils/menu/circle_nav_bar.dart';
import 'add_payment_form.dart';
import 'billing_info_card.dart';
import 'payment_button.dart';
import 'payment_card_item.dart';
import 'payment_header.dart';

// Extension para capitalizar strings
extension StringExtension on String {
  String capitalize() {
    // ignore: prefer_single_quotes
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

class PaymentNowPage extends StatefulWidget {
  const PaymentNowPage({super.key});

  @override
  State<PaymentNowPage> createState() => _PaymentNowPageState();
}

class _PaymentNowPageState extends State<PaymentNowPage> {
  final ScrollController _scrollController = ScrollController();
  int _selectedCard = 0;
  int _selectedTab = 0;

  // Lista de tarjetas
  final List<Map<String, String>> _cards = [
    {
      'number': 'Visa*4242',
      'expiry': 'Expires 05/28',
      'image': 'assets/payments/visa.png',
    },
    {
      'number': 'Mastercard*0011',
      'expiry': 'Expires 03/26',
      'image': 'assets/payments/mastercard.png',
    },
  ];

  final List<TabData> _tabItems = [
    TabData(Icons.home, 'My Products'),
    TabData(Icons.verified_user, '+ Add Insurance'),
    TabData(Icons.location_on, 'Location'),
  ];

  bool _showAddPaymentForm = false;

  void _toggleAddPaymentForm() {
    setState(() {
      _showAddPaymentForm = !_showAddPaymentForm;
    });

    // Si estamos cerrando el formulario, aseguramos que el scroll vuelva arriba
    if (!_showAddPaymentForm) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }

    if (_showAddPaymentForm) {
      // Capturamos todas las medidas necesarias antes del delay
      final screenHeight = MediaQuery.of(context).size.height;
      final formContext = _formKey.currentContext;

      if (formContext == null) return;

      final RenderBox formBox = formContext.findRenderObject() as RenderBox;
      final formPosition = formBox.localToGlobal(Offset.zero).dy;
      final targetScroll =
          formPosition - (screenHeight * 0.15); // 15% desde arriba

      // Esperamos a que el formulario se expanda
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!mounted) return;

        _scrollController.animateTo(
          targetScroll,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  // Clave global para encontrar el formulario
  final GlobalKey _formKey = GlobalKey();

  void _handlePayment() {
    // TODO: Implement payment processing
  }

  void _handleNavigation(int index) {
    setState(() {
      _selectedTab = index;
    });

    switch (index) {
      case 0: // My Products
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 1: // Add Insurance
        // TODO: Navigate to Add Insurance page
        break;
      case 2: // Location
        // TODO: Navigate to Location page
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0047BB),
      body: Stack(
        children: [
          Column(
            children: [
              const PaymentHeader(),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5FCFF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      // Title
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(24, 20, 24, 24),
                          child: Text(
                            'Payment Method',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w700,
                              height: 24 / 20, // line-height: 24px
                              letterSpacing: 0,
                              color: Color(0xFF414648),
                            ),
                          ),
                        ),
                      ),
                      // Billing Info
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: AnimatedSlide(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            offset: Offset(0, _showAddPaymentForm ? -0.1 : 0),
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: _showAddPaymentForm ? 0.7 : 1.0,
                              child: const BillingInfoCard(
                                name: 'Carlos, Velasco',
                                address: 'Astete 327...',
                                total: 'USD 340.00',
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Spacing
                      SliverToBoxAdapter(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          height: _showAddPaymentForm ? 30 : 60,
                          child: const SizedBox(),
                        ),
                      ),
                      // Payment Cards
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: AnimatedSlide(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            offset: Offset(0, _showAddPaymentForm ? -0.1 : 0),
                            child: SizedBox(
                              height:
                                  264, // Alto para 3 tarjetas (80px cada una) + 2 espacios (8px cada uno) + margen extra
                              child: ShaderMask(
                                shaderCallback: (Rect rect) {
                                  return LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.white,
                                      Colors.white.withAlpha(230),
                                      Colors.white.withAlpha(230),
                                      Colors.white,
                                    ],
                                    stops: const [0.0, 0.02, 0.98, 1.0],
                                  ).createShader(rect);
                                },
                                blendMode: BlendMode.dstIn,
                                child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  itemCount: _cards.length,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 8),
                                  itemBuilder: (context, index) {
                                    final card = _cards[index];
                                    return PaymentCardItem(
                                      cardNumber: card['number']!,
                                      expiry: card['expiry']!,
                                      imagePath: card['image']!,
                                      isSelected: _selectedCard == index,
                                      onTap: () =>
                                          setState(() => _selectedCard = index),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Add Payment Form
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              const SizedBox(height: 24),
                              AddPaymentForm(
                                key: _formKey,
                                onClose: _toggleAddPaymentForm,
                                isExpanded: _showAddPaymentForm,
                                onSaveCard: (cardNumber, expiry, cardHolder) {
                                  setState(() {
                                    // Determinar el tipo de tarjeta basado en el número
                                    final cardType = cardNumber.startsWith('4')
                                        ? 'visa'
                                        : cardNumber.startsWith('5')
                                            ? 'mastercard'
                                            : 'generic';

                                    // Formatear el número de tarjeta para mostrar solo los últimos 4 dígitos
                                    final lastFourDigits = cardNumber
                                        .replaceAll(' ', '')
                                        .substring(12);
                                    final formattedNumber =
                                        '${cardType.capitalize()}*$lastFourDigits';

                                    // Formatear la fecha de expiración
                                    final formattedExpiry = 'Expires $expiry';

                                    // Agregar la nueva tarjeta
                                    _cards.add({
                                      'number': formattedNumber,
                                      'expiry': formattedExpiry,
                                      'image': 'assets/payments/$cardType.png',
                                    });

                                    // Seleccionar la nueva tarjeta
                                    _selectedCard = _cards.length - 1;
                                  });
                                },
                              ),
                              const SizedBox(height: 24),
                              if (!_showAddPaymentForm)
                                PaymentButton(onPressed: _handlePayment),
                              const SizedBox(height: 100),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Navigation Bar
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: CircleNavBar(
              tabItems: _tabItems,
              selectedPos: _selectedTab,
              onTap: _handleNavigation,
            ),
          ),
        ],
      ),
    );
  }
}
