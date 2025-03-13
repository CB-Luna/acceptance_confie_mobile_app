import 'package:flutter/material.dart';

class QuotePlan {
  final String title;
  final String iconPath;
  final double monthlyPrice;
  final double annualPrice;
  final bool isPopular;
  final List<PlanFeature> features;
  final Color primaryColor;
  final Color accentColor;

  QuotePlan({
    required this.title,
    required this.iconPath,
    required this.monthlyPrice,
    required this.annualPrice,
    this.isPopular = false,
    required this.features,
    required this.primaryColor,
    required this.accentColor,
  });
}

class PlanFeature {
  final String title;
  final String? subtitle;
  final String iconPath;

  PlanFeature({
    required this.title,
    this.subtitle,
    required this.iconPath,
  });
}
