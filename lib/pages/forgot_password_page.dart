// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:freeway_app/locatordevice/presentation/widgets/loading_view.dart';
import 'package:freeway_app/utils/app_localizations_extension.dart';
import 'package:freeway_app/utils/responsive_font_sizes.dart';
import 'package:freeway_app/widgets/theme/app_theme.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ForgotPasswordPageState createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _resetSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulamos un proceso de envío de correo
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
        _resetSent = true;
      });

      // Mostrar mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.translate('auth.resetPasswordEmailSent')),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsiveFontSizes = ResponsiveFontSizes();

    return Scaffold(
      backgroundColor: AppTheme.getBackgroundColor(context),
      appBar: AppBar(
        backgroundColor: AppTheme.getPrimaryColor(context),
        title: Text(
          context.translate('auth.forgotPasswordTitle'),
          style: TextStyle(
            color: Colors.white,
            fontSize: responsiveFontSizes.titleLarge(context),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: _isLoading
            ? LoadingView(message: context.translate('common.loadingGif'))
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.translate('auth.forgotPasswordInstructions'),
                        style: TextStyle(
                          fontSize: responsiveFontSizes.bodyMedium(context),
                          color: AppTheme.getTextGreyColor(context),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: context.translate('auth.email'),
                                border: const OutlineInputBorder(),
                                prefixIcon: const Icon(Icons.email),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return context.translate('auth.pleaseEnterEmail');
                                }
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                  return context.translate('auth.pleaseEnterValidEmail');
                                }
                                return null;
                              },
                              onChanged: (value) {
                                // Convertir a minúsculas automáticamente
                                final newValue = value.toLowerCase();
                                if (value != newValue) {
                                  _emailController.value = TextEditingValue(
                                    text: newValue,
                                    selection: TextSelection.collapsed(offset: newValue.length),
                                  );
                                }
                              },
                            ),
                            const SizedBox(height: 32),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _resetSent ? null : _handleResetPassword,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.getPrimaryColor(context),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  textStyle: TextStyle(
                                    fontSize: responsiveFontSizes.bodyLarge(context),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(_resetSent
                                    ? context.translate('auth.resetPasswordSent')
                                    : context.translate('auth.resetPasswordButton')),
                              ),
                            ),
                            if (_resetSent) ...[
                              const SizedBox(height: 24),
                              Text(
                                context.translate('auth.resetPasswordCheckEmail'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: responsiveFontSizes.bodyMedium(context),
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _resetSent = false;
                                    _emailController.clear();
                                  });
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: AppTheme.getPrimaryColor(context),
                                ),
                                child: Text(context.translate('auth.resetPasswordTryAgain')),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
