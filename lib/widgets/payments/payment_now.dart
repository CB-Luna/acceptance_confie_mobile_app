import 'package:flutter/material.dart';
import 'package:freeway_app/locatordevice/locator_device_module.dart';
import 'package:freeway_app/pages/add_insurance.dart';
import 'package:freeway_app/utils/app_localizations_extension.dart';
import 'package:freeway_app/widgets/theme/app_theme.dart';

import '../../utils/menu/circle_nav_bar.dart';
import 'add_payment_form.dart';
import 'billing_info_card.dart';
import 'payment_button.dart';
import 'payment_card_item.dart';

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
  int _selectedIndex = 0;
  int _selectedCard = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getBackgroundHeaderColor(context),
      appBar: AppBar(
        backgroundColor: AppTheme.getBackgroundHeaderColor(context),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: AppTheme.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        leadingWidth: 56,
        title: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.translate('payment.title'),
                  style: const TextStyle(
                    color: AppTheme.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              child: Text(
                context.translate('payment.back'),
                style: const TextStyle(
                  color: AppTheme.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.getBackgroundColor(context),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      // Title
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                          child: Text(
                            context.translate('payment.paymentMethod'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w700,
                              height: 24 / 20, // line-height: 24px
                              letterSpacing: 0,
                              color: AppTheme.getTitleTextColor(context),
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
                                      AppTheme.white,
                                      AppTheme.white.withAlpha(230),
                                      AppTheme.white.withAlpha(230),
                                      AppTheme.white,
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
                                    final formattedExpiry = '${context.translate('payment.cardForm.expires')} $expiry';

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
        ],
      ),
      bottomNavigationBar: Transform.translate(
        offset: const Offset(0, 0),
        child: CircleNavBar(
          selectedPos: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });

            switch (index) {
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddInsurancePage(),
                  ),
                ).then((_) => setState(() => _selectedIndex = 0));
                break;
              case 2:
                LocatorDeviceModule.navigateToLocationView(context);
                break;
            }
          },
          tabItems: [
            TabData(
              Icons.home_outlined, 
              context.translate('home.navigation.myProducts'),
            ),
            TabData(
              Icons.verified_user_outlined, 
              context.translate('home.navigation.addInsurance'),
            ),
            TabData(
              Icons.location_on_outlined, 
              context.translate('home.navigation.location'),
            ),
          ],
        ),
      ),
    );
  }
}
