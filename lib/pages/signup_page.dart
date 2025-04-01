import 'package:flutter/material.dart';
import 'package:freeway_app/locatordevice/presentation/widgets/loading_view.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../providers/auth_provider.dart';
import '../widgets/theme/app_theme.dart';
import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _policyNumberController = TextEditingController();
  final _birthDateController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;
  DateTime? _selectedDate;

  // Formateador para el número de teléfono con formato internacional
  final _phoneMaskFormatter = MaskTextInputFormatter(
    mask: '+# (###) ###-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  void initState() {
    super.initState();
    // Dar foco al campo First Name cuando se abre la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _firstNameFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _policyNumberController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(1990),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _birthDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  // Método para extraer solo los dígitos del número de teléfono formateado
  String _getFormattedPhoneNumber() {
    // Obtener el número con formato (con máscara)
    final maskedNumber = _phoneController.text;
    
    // Eliminar todos los caracteres que no sean dígitos o el signo '+'
    final cleanedNumber = maskedNumber.replaceAll(RegExp(r'[^\d+]'), '');
    
    // Asegurarse de que comience con '+'
    return cleanedNumber.startsWith('+') ? cleanedNumber : '+$cleanedNumber';
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        await authProvider.signUp(
          _firstNameController.text,
          _lastNameController.text,
          _emailController.text,
          _passwordController.text,
          _getFormattedPhoneNumber(),
          _policyNumberController.text,
          _birthDateController.text,
        );
        
        // Verificar si hay un mensaje de error
        if (authProvider.errorMessage != null) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(authProvider.errorMessage!)),
            );
          }
        } else if (mounted) {
          // Si no hay error, navegar a la página de inicio
          await Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Image.asset(
                      'assets/auth/freeway_logo.png',
                      width: 195.65,
                      height: 50,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Sign Up',
                    style: AppTheme.titleStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _firstNameController,
                    focusNode: _firstNameFocus,
                    decoration: AppTheme.inputDecoration(labelText: 'First Name'),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_lastNameFocus);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _lastNameController,
                    focusNode: _lastNameFocus,
                    decoration: AppTheme.inputDecoration(labelText: 'Last Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        AppTheme.inputDecoration(labelText: 'Email address'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@') || !value.contains('.')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: AppTheme.inputDecoration(labelText: 'Password')
                        .copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      // Verificar si la contraseña tiene al menos una letra mayúscula
                      if (!value.contains(RegExp(r'[A-Z]'))) {
                        return 'Password must contain at least one uppercase letter';
                      }
                      // Verificar si la contraseña tiene al menos un número
                      if (!value.contains(RegExp(r'[0-9]'))) {
                        return 'Password must contain at least one number';
                      }
                      // Verificar si la contraseña tiene al menos un carácter especial
                      if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                        return 'Password must contain at least one special character';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [_phoneMaskFormatter],
                    decoration:
                        AppTheme.inputDecoration(labelText: 'Phone Number')
                            .copyWith(
                      hintText: '+1 (234) 567-8910',
                      prefixIcon: const Icon(Icons.phone),
                      helperText: 'Include country code (e.g. +1 for USA)',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      
                      // Verificar que el número tenga el formato correcto
                      if (!_phoneMaskFormatter.isFill()) {
                        return 'Please enter a complete phone number';
                      }
                      
                      // Verificar que el número limpio tenga el formato correcto para la API
                      final cleanedNumber = value.replaceAll(RegExp(r'[^\d+]'), '');
                      if (!RegExp(r'^\+\d{10,15}$').hasMatch(cleanedNumber)) {
                        return 'Phone number must include country code and be 10-15 digits';
                      }
                      
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _birthDateController,
                    readOnly: true,
                    decoration: AppTheme.inputDecoration(labelText: 'Birth Date (YYYY-MM-DD)')
                        .copyWith(
                      prefixIcon: const Icon(Icons.calendar_today),
                    ),
                    onTap: () => _selectDate(context),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your birth date';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _policyNumberController,
                    decoration: AppTheme.inputDecoration(labelText: 'Policy Number (optional)')
                        .copyWith(
                      prefixIcon: const Icon(Icons.policy),
                    ),
                    // No hay validación porque es opcional
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _signUp,
                    style: AppTheme.primaryButtonStyle,
                    child: _isLoading
                        ? const LoadingView(message: 'Loading...')
                        : const Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Sign In',
                          style: AppTheme.linkTextStyle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
