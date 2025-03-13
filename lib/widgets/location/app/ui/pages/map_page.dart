import 'package:flutter/material.dart';
import '../widgets/map_widget.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(minimum: EdgeInsets.zero, child: MapWidget()),
    );
  }
}
