import 'package:flutter/material.dart';
import 'package:freeway_app/utils/app_localizations_extension.dart';
import 'package:freeway_app/utils/responsive_font_sizes.dart';
import 'package:freeway_app/widgets/theme/app_theme.dart';

/// Página para cambiar la contraseña del usuario
class PasswordChangePage extends StatefulWidget {
  const PasswordChangePage({super.key});

  @override
  State<PasswordChangePage> createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _hasChanges = false;
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  final responsiveFontSizes = ResponsiveFontSizes();

  @override
  void initState() {
    super.initState();
    _setupTextControllerListeners();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _setupTextControllerListeners() {
    void listener() {
      final hasCurrentPassword = _currentPasswordController.text.isNotEmpty;
      final hasNewPassword = _newPasswordController.text.isNotEmpty;
      final hasConfirmPassword = _confirmPasswordController.text.isNotEmpty;

      final newHasChanges =
          hasCurrentPassword && hasNewPassword && hasConfirmPassword;

      if (newHasChanges != _hasChanges) {
        setState(() {
          _hasChanges = newHasChanges;
        });
      }
    }

    _currentPasswordController.addListener(listener);
    _newPasswordController.addListener(listener);
    _confirmPasswordController.addListener(listener);
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // En una implementación real, aquí se llamaría a la API para actualizar la contraseña
      // Por ahora, solo simulamos un retraso y mostramos un mensaje de éxito
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(context.translate('profile.passwordPage.saveSuccess')),
            backgroundColor: Colors.green,
          ),
        );

        // Aquí se actualizaría la contraseña en el AuthProvider
        // Por ahora, solo cerramos la página
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${context.translate('profile.passwordPage.saveError')}: $e',
            ),
            backgroundColor: AppTheme.getRedColor(context),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  bool _isPasswordValid(String password) {
    // Validación básica: al menos 8 caracteres y contiene un número
    return password.length >= 8 && password.contains(RegExp(r'[0-9]'));
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
        title: Text(
          context.translate('profile.passwordPage.title'),
          style: TextStyle(
            color: AppTheme.white,
            fontSize: responsiveFontSizes.titleLarge(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Container(
                color: AppTheme.getBackgroundColor(context),
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    _buildPasswordForm(context),
                    const SizedBox(height: 24),
                    _buildSaveButton(context),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildPasswordForm(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.translate('profile.passwordPage.title'),
                style: TextStyle(
                  fontSize: responsiveFontSizes.titleLarge(context),
                  fontWeight: FontWeight.bold,
                  color: AppTheme.getPrimaryColor(context),
                ),
              ),
              const SizedBox(height: 16),
              // Campo de contraseña actual
              TextFormField(
                controller: _currentPasswordController,
                obscureText: _obscureCurrentPassword,
                decoration: AppTheme.inputDecoration(
                  context,
                  labelText:
                      context.translate('profile.passwordPage.currentPassword'),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureCurrentPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureCurrentPassword = !_obscureCurrentPassword;
                      });
                    },
                  ),
                ),
                style: TextStyle(
                  fontSize: responsiveFontSizes.bodyMedium(context),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.translate('validation.required');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Campo de nueva contraseña
              TextFormField(
                controller: _newPasswordController,
                obscureText: _obscureNewPassword,
                decoration: AppTheme.inputDecoration(
                  context,
                  labelText:
                      context.translate('profile.passwordPage.newPassword'),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureNewPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureNewPassword = !_obscureNewPassword;
                      });
                    },
                  ),
                ),
                style: TextStyle(
                  fontSize: responsiveFontSizes.bodyMedium(context),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.translate('validation.required');
                  }
                  if (!_isPasswordValid(value)) {
                    return context
                        .translate('profile.passwordPage.passwordRequirements');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Campo de confirmación de contraseña
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: AppTheme.inputDecoration(
                  context,
                  labelText:
                      context.translate('profile.passwordPage.confirmPassword'),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                style: TextStyle(
                  fontSize: responsiveFontSizes.bodyMedium(context),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.translate('validation.required');
                  }
                  if (value != _newPasswordController.text) {
                    return context
                        .translate('profile.passwordPage.passwordMismatch');
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    final primaryColor = AppTheme.getGreenColor(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ElevatedButton(
        onPressed: _hasChanges && !_isLoading ? _saveChanges : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          disabledBackgroundColor: primaryColor.withAlpha(128),
          disabledForegroundColor: Colors.white70,
          minimumSize: const Size(double.infinity, 50),
        ),
        child: Text(
          context.translate('profile.passwordPage.save'),
          style: TextStyle(
            fontSize: responsiveFontSizes.bodyLarge(context),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
