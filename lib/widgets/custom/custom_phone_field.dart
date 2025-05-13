import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

// Lista de códigos de país en el orden deseado
const List<String> _priorityCountryCodes = ['US', 'MX', 'CA'];

/// Widget personalizado para selección de número telefónico con países ordenados
/// según las preferencias del cliente (US, MX, CA primero)
class CustomPhoneField extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialCountryCode;
  final InputDecoration decoration;
  final bool disableLengthCheck;
  final String? invalidNumberMessage;
  final ValueChanged<PhoneNumber> onChanged;
  final bool showCountryFlag;
  final bool showDropdownIcon;

  const CustomPhoneField({
    Key? key,
    this.controller,
    this.initialCountryCode = 'US',
    required this.decoration,
    this.disableLengthCheck = false,
    this.invalidNumberMessage,
    required this.onChanged,
    this.showCountryFlag = true,
    this.showDropdownIcon = true,
  }) : super(key: key);

  @override
  State<CustomPhoneField> createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends State<CustomPhoneField> {
  // Lista de países ordenada según las preferencias del cliente
  late List<Country> _prioritizedCountries;

  @override
  void initState() {
    super.initState();
    _prioritizedCountries = _getCustomOrderedCountries();
  }

  // Método para obtener la lista de países con US, MX y CA al inicio
  List<Country> _getCustomOrderedCountries() {
    // Crear una lista completamente nueva para los países prioritarios
    final List<Country> priorityCountries = [];
    
    // Primero, añadir los países prioritarios en el orden especificado
    for (final code in _priorityCountryCodes) {
      // Buscar el país por su código
      final country = countries.firstWhere(
        (c) => c.code == code,
        orElse: () => countries.first,
      );
      priorityCountries.add(country);
    }
    
    // Luego, añadir el resto de países (excluyendo los prioritarios)
    final remainingCountries = countries.where(
      (country) => !_priorityCountryCodes.contains(country.code)
    ).toList();
    
    // Ordenar el resto de países alfabéticamente por nombre
    remainingCountries.sort((a, b) => a.name.compareTo(b.name));
    
    // Devolver la lista combinada
    return [...priorityCountries, ...remainingCountries];
  }

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: widget.controller,
      decoration: widget.decoration,
      initialCountryCode: widget.initialCountryCode,
      disableLengthCheck: widget.disableLengthCheck,
      invalidNumberMessage: widget.invalidNumberMessage,
      onChanged: widget.onChanged,
      showCountryFlag: widget.showCountryFlag,
      showDropdownIcon: widget.showDropdownIcon,
      // Usar nuestra lista de países personalizada
      countries: _prioritizedCountries,
      // Mejorar la apariencia del selector
      dropdownTextStyle: const TextStyle(fontSize: 16),
    );
  }
}
