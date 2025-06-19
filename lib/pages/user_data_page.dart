import 'package:flutter/material.dart';
import 'package:freeway_app/providers/auth_provider.dart';
import 'package:freeway_app/utils/app_localizations_extension.dart';
import 'package:freeway_app/utils/responsive_font_sizes.dart';
import 'package:freeway_app/widgets/theme/app_theme.dart';
import 'package:provider/provider.dart';

class UserDataPage extends StatefulWidget {
  const UserDataPage({super.key});

  @override
  State<UserDataPage> createState() => _UserDataPageState();
}

class _UserDataPageState extends State<UserDataPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();
  bool _isLoading = false;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

  void _loadUserData() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.currentUser;

    if (user != null) {
      _fullNameController.text = user.fullName;
      _emailController.text = user.email ?? '';
      _phoneController.text = user.phone ?? '';
      _streetController.text = user.street;
      _cityController.text = user.city;
      _stateController.text = user.state;
      _zipCodeController.text = user.zipCode;
    }

    // Añadir listeners para detectar cambios
    _fullNameController.addListener(_onFieldChanged);
    _emailController.addListener(_onFieldChanged);
    _phoneController.addListener(_onFieldChanged);
    _streetController.addListener(_onFieldChanged);
    _cityController.addListener(_onFieldChanged);
    _stateController.addListener(_onFieldChanged);
    _zipCodeController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    if (!_hasChanges) {
      setState(() {
        _hasChanges = true;
      });
    }
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // En una implementación real, aquí se llamaría a la API para actualizar los datos
        // Por ahora, solo simulamos un retraso y mostramos un mensaje de éxito
        await Future.delayed(const Duration(seconds: 1));

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text(context.translate('profile.userDataPage.saveSuccess')),
              backgroundColor: Colors.green,
            ),
          );

          // Aquí se actualizaría el objeto User en el AuthProvider
          // Por ahora, solo cerramos la página
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  // ignore: require_trailing_commas
                  '${context.translate('profile.userDataPage.saveError')}: $e'),
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
        title: Text(
          context.translate('profile.dataUser'),
          style: TextStyle(
            color: AppTheme.white,
            fontSize: responsiveFontSizes.titleMedium(context),
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              color: AppTheme.getBackgroundColor(context),
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    _buildPersonalInfoCard(context),
                    const SizedBox(height: 16),
                    _buildAddressCard(context),
                    const SizedBox(height: 24),
                    _buildSaveButton(context),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildPersonalInfoCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.translate('profile.dataUser'),
              style: TextStyle(
                fontSize: responsiveFontSizes.titleMedium(context),
                fontWeight: FontWeight.bold,
                color: AppTheme.getPrimaryColor(context),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _fullNameController,
              decoration: AppTheme.inputDecoration(
                context,
                labelText: context.translate('profile.userDataPage.fullName'),
              ),
              style: TextStyle(
                fontSize: responsiveFontSizes.bodyMedium(context),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese su nombre completo';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: AppTheme.inputDecoration(
                context,
                labelText: context.translate('profile.userDataPage.email'),
              ),
              style: TextStyle(
                fontSize: responsiveFontSizes.bodyMedium(context),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese su correo electrónico';
                }
                if (!value.contains('@') || !value.contains('.')) {
                  return 'Por favor ingrese un correo electrónico válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: AppTheme.inputDecoration(
                context,
                labelText: context.translate('profile.userDataPage.phone'),
              ),
              style: TextStyle(
                fontSize: responsiveFontSizes.bodyMedium(context),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese su número de teléfono';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.translate('profile.userDataPage.address'),
              style: TextStyle(
                fontSize: responsiveFontSizes.titleMedium(context),
                fontWeight: FontWeight.bold,
                color: AppTheme.getPrimaryColor(context),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _streetController,
              decoration: AppTheme.inputDecoration(
                context,
                labelText: context.translate('profile.userDataPage.street'),
              ),
              style: TextStyle(
                fontSize: responsiveFontSizes.bodyMedium(context),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese su dirección';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _cityController,
              decoration: AppTheme.inputDecoration(
                context,
                labelText: context.translate('profile.userDataPage.city'),
              ),
              style: TextStyle(
                fontSize: responsiveFontSizes.bodyMedium(context),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese su ciudad';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _stateController,
                    decoration: AppTheme.inputDecoration(
                      context,
                      labelText:
                          context.translate('profile.userDataPage.state'),
                    ),
                    style: TextStyle(
                      fontSize: responsiveFontSizes.bodyMedium(context),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su estado';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _zipCodeController,
                    keyboardType: TextInputType.number,
                    decoration: AppTheme.inputDecoration(
                      context,
                      labelText:
                          context.translate('profile.userDataPage.zipCode'),
                    ),
                    style: TextStyle(
                      fontSize: responsiveFontSizes.bodyMedium(context),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su código postal';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ],
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
          context.translate('profile.userDataPage.save'),
          style: TextStyle(
            fontSize: responsiveFontSizes.bodyLarge(context),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
