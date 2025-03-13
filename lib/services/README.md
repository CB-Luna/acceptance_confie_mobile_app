# Servicio de Direcciones

Este servicio proporciona funcionalidad para obtener direcciones a las oficinas de Freeway Insurance.

## Características

- Solicita permisos de ubicación al usuario
- Detecta si la geolocalización está disponible
- Muestra un diálogo para ingresar código postal cuando la geolocalización no está disponible
- Abre Google Maps con la ruta desde la ubicación actual del usuario hasta la oficina seleccionada
- Maneja errores y muestra mensajes apropiados al usuario

## Uso

```dart
// Para navegar a una oficina usando la ubicación actual del usuario
DirectionsService.navigateToOffice(context, officeLocation);

// Para mostrar el diálogo de código postal cuando la geolocalización no está disponible
DirectionsService.showZipCodeDialog(context, officeLocation);
```

## Implementación

El servicio está implementado en la clase `DirectionsService` y se utiliza en el widget `LocationDetailsView` cuando el usuario presiona el botón "Get Directions".

La implementación sigue el flujo mostrado en la imagen de referencia, donde se solicita al usuario ingresar su código postal cuando la geolocalización no está disponible.
