/// Modelo para representar un país en el selector de teléfono personalizado
class CountryPhoneModel {
  final String name;
  final String code;
  final String dialCode;
  final String flag;
  final int minLength;
  final int maxLength;

  const CountryPhoneModel({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.flag,
    this.minLength = 9,
    this.maxLength = 15,
  });

  // Método para obtener la bandera como emoji
  String get flagEmoji => flag;

  // Método para obtener el código de marcación con el formato +XX
  String get formattedDialCode => dialCode.startsWith('+') ? dialCode : '+$dialCode';

  @override
  String toString() => 'CountryPhoneModel(name: $name, code: $code, dialCode: $dialCode)';
}

/// Lista de países prioritarios para mostrar al inicio
const List<String> priorityCountryCodes = ['US', 'MX', 'CA'];

/// Lista de países disponibles para el selector de teléfono
final List<CountryPhoneModel> countryPhoneList = [
  // Estados Unidos (prioridad 1)
  const CountryPhoneModel(
    name: 'United States',
    code: 'US',
    dialCode: '+1',
    flag: '🇺🇸',
    minLength: 10,
    maxLength: 10,
  ),
  // México (prioridad 2)
  const CountryPhoneModel(
    name: 'Mexico',
    code: 'MX',
    dialCode: '+52',
    flag: '🇲🇽',
    minLength: 10,
    maxLength: 10,
  ),
  // Canadá (prioridad 3)
  const CountryPhoneModel(
    name: 'Canada',
    code: 'CA',
    dialCode: '+1',
    flag: '🇨🇦',
    minLength: 10,
    maxLength: 10,
  ),
  // Resto de países en orden alfabético
  const CountryPhoneModel(
    name: 'Afghanistan',
    code: 'AF',
    dialCode: '+93',
    flag: '🇦🇫',
  ),
  const CountryPhoneModel(
    name: 'Albania',
    code: 'AL',
    dialCode: '+355',
    flag: '🇦🇱',
  ),
  const CountryPhoneModel(
    name: 'Algeria',
    code: 'DZ',
    dialCode: '+213',
    flag: '🇩🇿',
  ),
  const CountryPhoneModel(
    name: 'Argentina',
    code: 'AR',
    dialCode: '+54',
    flag: '🇦🇷',
  ),
  const CountryPhoneModel(
    name: 'Australia',
    code: 'AU',
    dialCode: '+61',
    flag: '🇦🇺',
  ),
  const CountryPhoneModel(
    name: 'Brazil',
    code: 'BR',
    dialCode: '+55',
    flag: '🇧🇷',
  ),
  const CountryPhoneModel(
    name: 'Chile',
    code: 'CL',
    dialCode: '+56',
    flag: '🇨🇱',
  ),
  const CountryPhoneModel(
    name: 'China',
    code: 'CN',
    dialCode: '+86',
    flag: '🇨🇳',
  ),
  const CountryPhoneModel(
    name: 'Colombia',
    code: 'CO',
    dialCode: '+57',
    flag: '🇨🇴',
  ),
  const CountryPhoneModel(
    name: 'Costa Rica',
    code: 'CR',
    dialCode: '+506',
    flag: '🇨🇷',
  ),
  const CountryPhoneModel(
    name: 'Cuba',
    code: 'CU',
    dialCode: '+53',
    flag: '🇨🇺',
  ),
  const CountryPhoneModel(
    name: 'Dominican Republic',
    code: 'DO',
    dialCode: '+1',
    flag: '🇩🇴',
  ),
  const CountryPhoneModel(
    name: 'Ecuador',
    code: 'EC',
    dialCode: '+593',
    flag: '🇪🇨',
  ),
  const CountryPhoneModel(
    name: 'El Salvador',
    code: 'SV',
    dialCode: '+503',
    flag: '🇸🇻',
  ),
  const CountryPhoneModel(
    name: 'France',
    code: 'FR',
    dialCode: '+33',
    flag: '🇫🇷',
  ),
  const CountryPhoneModel(
    name: 'Germany',
    code: 'DE',
    dialCode: '+49',
    flag: '🇩🇪',
  ),
  const CountryPhoneModel(
    name: 'Guatemala',
    code: 'GT',
    dialCode: '+502',
    flag: '🇬🇹',
  ),
  const CountryPhoneModel(
    name: 'Honduras',
    code: 'HN',
    dialCode: '+504',
    flag: '🇭🇳',
  ),
  const CountryPhoneModel(
    name: 'India',
    code: 'IN',
    dialCode: '+91',
    flag: '🇮🇳',
  ),
  const CountryPhoneModel(
    name: 'Italy',
    code: 'IT',
    dialCode: '+39',
    flag: '🇮🇹',
  ),
  const CountryPhoneModel(
    name: 'Japan',
    code: 'JP',
    dialCode: '+81',
    flag: '🇯🇵',
  ),
  const CountryPhoneModel(
    name: 'Nicaragua',
    code: 'NI',
    dialCode: '+505',
    flag: '🇳🇮',
  ),
  const CountryPhoneModel(
    name: 'Panama',
    code: 'PA',
    dialCode: '+507',
    flag: '🇵🇦',
  ),
  const CountryPhoneModel(
    name: 'Paraguay',
    code: 'PY',
    dialCode: '+595',
    flag: '🇵🇾',
  ),
  const CountryPhoneModel(
    name: 'Peru',
    code: 'PE',
    dialCode: '+51',
    flag: '🇵🇪',
  ),
  const CountryPhoneModel(
    name: 'Puerto Rico',
    code: 'PR',
    dialCode: '+1',
    flag: '🇵🇷',
  ),
  const CountryPhoneModel(
    name: 'Russia',
    code: 'RU',
    dialCode: '+7',
    flag: '🇷🇺',
  ),
  const CountryPhoneModel(
    name: 'Spain',
    code: 'ES',
    dialCode: '+34',
    flag: '🇪🇸',
  ),
  const CountryPhoneModel(
    name: 'United Kingdom',
    code: 'GB',
    dialCode: '+44',
    flag: '🇬🇧',
  ),
  const CountryPhoneModel(
    name: 'Uruguay',
    code: 'UY',
    dialCode: '+598',
    flag: '🇺🇾',
  ),
  const CountryPhoneModel(
    name: 'Venezuela',
    code: 'VE',
    dialCode: '+58',
    flag: '🇻🇪',
  ),
];

/// Obtener una lista ordenada de países con los prioritarios al inicio
List<CountryPhoneModel> getOrderedCountries() {
  // Extraer los países prioritarios en el orden especificado
  final priorityCountries = priorityCountryCodes
      .map((code) => countryPhoneList.firstWhere((country) => country.code == code))
      .toList();
  
  // Obtener el resto de países (excluyendo los prioritarios)
  final otherCountries = countryPhoneList
      .where((country) => !priorityCountryCodes.contains(country.code))
      .toList()
      // Ordenar alfabéticamente por nombre
      ..sort((a, b) => a.name.compareTo(b.name));
  
  // Combinar las listas: primero los prioritarios, luego el resto
  return [...priorityCountries, ...otherCountries];
}
