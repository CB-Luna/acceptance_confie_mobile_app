import 'package:flutter/material.dart';
import 'package:freeway_app/locatordevice/presentation/widgets/loading_view.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/biometric_provider.dart';
import '../widgets/theme/app_theme.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscureText = true;
  bool _isBiometricAvailable = false;
  bool _isBiometricEnabled = false;

  @override
  void initState() {
    super.initState();
    // Verificar si la biometría está disponible y habilitada
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkBiometricStatus();
    });
  }

  Future<void> _checkBiometricStatus() async {
    final biometricProvider =
        Provider.of<BiometricProvider>(context, listen: false);
    setState(() {
      _isBiometricAvailable = biometricProvider.isAvailable;
      _isBiometricEnabled = biometricProvider.isEnabled;
    });

    // Nota: Eliminamos la autenticación automática por razones de seguridad
    // Es mejor que el usuario inicie manualmente el proceso de autenticación biométrica
  }

  /// Intenta autenticar al usuario usando biometría
  ///
  /// Devuelve true si la autenticación fue exitosa, false en caso contrario
  Future<bool> _authenticateWithBiometrics() async {
    try {
      final biometricProvider =
          Provider.of<BiometricProvider>(context, listen: false);
      final success = await biometricProvider.authenticate();

      if (!success) {
        // Si la autenticación biométrica falló, mostrar un mensaje
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Authentication failed with biometrics.'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return false;
      }

      if (mounted) {
        // Si la autenticación biométrica fue exitosa, iniciar sesión
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        setState(() {
          _isLoading = true;
        });

        // Obtener las credenciales guardadas y hacer login
        final loginSuccess = await authProvider.loginWithSavedCredentials();

        setState(() {
          _isLoading = false;
        });

        if (!loginSuccess && mounted) {
          // Si el login falló, mostrar un mensaje
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(authProvider.errorMessage ?? 'Failed to login.'),
              backgroundColor: Colors.red,
            ),
          );
          return false;
        }

        return loginSuccess;
      }

      return false;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return false;
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
                children: [
                  SizedBox(
                    height: 150, // Increased height for more space
                    child: Center(
                      child: Image.asset(
                        'assets/auth/freeway_logo.png',
                        width: 195.65219116210938,
                        height: 50,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 120,
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                          height: 1.0,
                          letterSpacing: 0,
                          color: AppTheme.primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 60,
                    width: 346,
                    child: TextFormField(
                      controller: _usernameController,
                      decoration:
                          AppTheme.inputDecoration(labelText: 'Username'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 346,
                    child: TextFormField(
                      controller: _passwordController,
                      decoration:
                          AppTheme.inputDecoration(labelText: 'Password')
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
                      obscureText: _obscureText,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        // TODO: Implement forgot password
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppTheme.primaryColor,
                      ),
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleLogin,
                      style: AppTheme.primaryButtonStyle,
                      child: _isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: LoadingView(message: 'Loading...'),
                            )
                          : const Text(
                              'Login',
                              style: AppTheme.buttonTextStyle,
                            ),
                    ),
                  ),

                  // Botón de biometría si está disponible
                  if (_isBiometricAvailable)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Consumer<BiometricProvider>(
                        builder: (context, biometricProvider, child) {
                          return IconButton(
                            icon: Icon(
                              biometricProvider.biometricType.contains('Face')
                                  ? Icons.face_outlined
                                  : Icons.fingerprint,
                              size: 40,
                              color: AppTheme.primaryColor,
                            ),
                            onPressed: _isLoading
                                ? null
                                : () async {
                                    final success =
                                        await _authenticateWithBiometrics();
                                    if (success && mounted) {
                                      // Si la autenticación fue exitosa, navegar a la pantalla principal
                                      await Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                        '/home',
                                        (route) => false,
                                      );
                                    }
                                  },
                            tooltip:
                                'Acceder con ${biometricProvider.biometricType}',
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppTheme.primaryColor,
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final authProvider = context.read<AuthProvider>();
      final success = await authProvider.login(
        _usernameController.text,
        _passwordController.text,
      );

      // Si el login fue exitoso y la biometría está disponible y habilitada, guardar las credenciales
      if (success && _isBiometricAvailable && _isBiometricEnabled) {
        await authProvider.saveCredentials(
          _usernameController.text,
          _passwordController.text,
        );
      }

      setState(() => _isLoading = false);

      if (success && mounted) {
        await Navigator.of(context).pushNamedAndRemoveUntil(
          '/home',
          (route) => false,
        );
      } else if (mounted) {
        final errorMessage =
            authProvider.errorMessage ?? 'Authentication error.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
