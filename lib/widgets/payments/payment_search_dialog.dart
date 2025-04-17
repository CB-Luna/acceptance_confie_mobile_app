import 'package:flutter/material.dart';
import 'package:freeway_app/locatordevice/presentation/widgets/loading_view.dart';
import 'package:freeway_app/utils/app_localizations_extension.dart';
import 'package:freeway_app/widgets/theme/app_theme.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

enum SearchType {
  policyNumber,
  phoneNumber,
}

class PaymentSearchDialog extends StatefulWidget {
  final String? initialZipCode;
  final Function(String, SearchType) onContinue;

  const PaymentSearchDialog({
    required this.onContinue,
    super.key,
    this.initialZipCode,
  });

  static Future<Map<String, dynamic>?> show({
    required BuildContext context,
    String? initialZipCode,
  }) async {
    // Si no se proporciona un código postal inicial, intentar obtenerlo por geolocalización
    if (initialZipCode == null || initialZipCode.isEmpty) {
      initialZipCode = await _getZipCodeFromLocation(context);
    }
    if (!context.mounted) return null;

    return await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        final initialSize = keyboardHeight > 0 ? 0.7 : 0.6;

        return DraggableScrollableSheet(
          initialChildSize: initialSize,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          builder: (_, controller) {
            return PaymentSearchDialog(
              initialZipCode: initialZipCode,
              onContinue: (zipCode, searchType) {
                FocusScope.of(context).unfocus();
                Navigator.pop(context, {
                  'zipCode': zipCode,
                  'searchType': searchType,
                });
              },
            );
          },
        );
      },
    );
  }

  @override
  State<PaymentSearchDialog> createState() => _PaymentSearchDialogState();

  // Método para obtener el código postal basado en la ubicación del usuario
  static Future<String> _getZipCodeFromLocation(BuildContext context) async {
    // Mostrar un indicador de progreso
    final overlay = LoadingView.showOverlay(
      context,
      message: context.translate('vehicleInsurance.location.gettingLocation'),
      indicatorColor: AppTheme.getPrimaryColor(context),
      textColor: AppTheme.getTitleTextColor(context),
    );

    try {
      // Verificar si los servicios de ubicación están habilitados
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Si los servicios de ubicación no están habilitados, devolver cadena vacía
        return '';
      }

      // Verificar permisos de ubicación
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Si los permisos son denegados, devolver cadena vacía
          return '';
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Si los permisos son denegados permanentemente, devolver cadena vacía
        return '';
      }

      // Obtener la posición actual
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Obtener la dirección a partir de las coordenadas
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final Placemark placemark = placemarks.first;
        final String postalCode = placemark.postalCode ?? '';
        return postalCode;
      }
      return '';
    } catch (e) {
      debugPrint('Error al obtener la ubicación: $e');
      return '';
    } finally {
      // Ocultar el indicador de progreso
      overlay.remove();
    }
  }
}

class _PaymentSearchDialogState extends State<PaymentSearchDialog> {
  late TextEditingController _zipCodeController;
  bool _isZipCodeValid = false;
  SearchType _selectedSearchType = SearchType.policyNumber;

  @override
  void initState() {
    super.initState();
    _zipCodeController =
        TextEditingController(text: widget.initialZipCode ?? '');
    _validateZipCode(_zipCodeController.text);
    _zipCodeController.addListener(() {
      _validateZipCode(_zipCodeController.text);
    });
  }

  @override
  void dispose() {
    _zipCodeController.dispose();
    super.dispose();
  }

  void _validateZipCode(String value) {
    setState(() {
      _isZipCodeValid = value.length == 5 && RegExp(r'^\d{5}$').hasMatch(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final isKeyboardVisible = keyboardHeight > 0;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.getCardColor(context),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            20.0,
            20.0,
            20.0,
            isKeyboardVisible ? keyboardHeight + 20.0 : 20.0,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Indicador de arrastre
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppTheme.getDetailsGreyColor(context),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Título
                Text(
                  context.translate('payment.search.title'),
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.getTitleTextColor(context),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                // Subtítulo
                Text(
                  context.translate('payment.search.subtitle'),
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 14,
                    color: AppTheme.getSubtitleTextColor(context),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Opciones de búsqueda
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppTheme.getDetailsGreyColor(context),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      // Opción de búsqueda por número de póliza
                      RadioListTile<SearchType>(
                        title: Text(
                          context.translate('payment.search.byPolicyNumber'),
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.getTitleTextColor(context),
                          ),
                        ),
                        value: SearchType.policyNumber,
                        groupValue: _selectedSearchType,
                        activeColor: AppTheme.getPrimaryColor(context),
                        onChanged: (SearchType? value) {
                          if (value != null) {
                            setState(() {
                              _selectedSearchType = value;
                            });
                          }
                        },
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: AppTheme.getDetailsGreyColor(context),
                      ),
                      // Opción de búsqueda por número de teléfono
                      RadioListTile<SearchType>(
                        title: Text(
                          context.translate('payment.search.byPhoneNumber'),
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.getTitleTextColor(context),
                          ),
                        ),
                        value: SearchType.phoneNumber,
                        groupValue: _selectedSearchType,
                        activeColor: AppTheme.getPrimaryColor(context),
                        onChanged: (SearchType? value) {
                          if (value != null) {
                            setState(() {
                              _selectedSearchType = value;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Campo de entrada de ZipCode
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _zipCodeController,
                    keyboardType: TextInputType.number,
                    maxLength: 5,
                    decoration: InputDecoration(
                      labelText:
                          context.translate('payment.search.zipCodeHint'),
                      border: InputBorder.none,
                      counterText: '',
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                          color: AppTheme.getPrimaryColor(context),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                          color: AppTheme.getDetailsGreyColor(context),
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 16,
                    ),
                  ),
                ),

                SizedBox(height: isKeyboardVisible ? 40 : 30),

                // Botón de continuar
                ElevatedButton(
                  onPressed: _isZipCodeValid
                      ? () => widget.onContinue(
                            _zipCodeController.text,
                            _selectedSearchType,
                          )
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.getPrimaryColor(context),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    disabledBackgroundColor: AppTheme.getPrimaryColor(context)
                        .withValues(alpha: 0.5),
                  ),
                  child: Text(
                    context.translate('payment.search.continueButton'),
                    style: const TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.white,
                    ),
                  ),
                ),

                SizedBox(height: isKeyboardVisible ? 20 : 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
