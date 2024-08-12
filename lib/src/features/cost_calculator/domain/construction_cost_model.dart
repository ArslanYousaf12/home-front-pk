import 'package:equatable/equatable.dart';

class ConstructionCostsModel extends Equatable {
  final double bricks;
  final double cement;
  final double plumbing;
  final double electricity;
  final double labor;
  final double foundation;
  final double roofing;
  final double windows;
  final double hvac;
  final double flooring;
  final double interiorFinishes;
  final double cabinetry;
  final double appliances;
  final double landscaping;
  final double permits;
  final double architectFees;
  final double sitePrep;

  const ConstructionCostsModel({
    required this.bricks,
    required this.cement,
    required this.plumbing,
    required this.electricity,
    required this.labor,
    required this.foundation,
    required this.roofing,
    required this.windows,
    required this.hvac,
    required this.flooring,
    required this.interiorFinishes,
    required this.cabinetry,
    required this.appliances,
    required this.landscaping,
    required this.permits,
    required this.architectFees,
    required this.sitePrep,
  });
  factory ConstructionCostsModel.fromMap(Map<String, dynamic> map) {
    return ConstructionCostsModel(
      bricks: (map['bricks'] ?? 0).toDouble(),
      cement: (map['cement'] ?? 0).toDouble(),
      plumbing: (map['plumbing'] ?? 0).toDouble(),
      electricity: (map['electricity'] ?? 0).toDouble(),
      labor: (map['labor'] ?? 0).toDouble(),
      foundation: (map['foundation'] ?? 0).toDouble(),
      roofing: (map['roofing'] ?? 0).toDouble(),
      windows: (map['windows'] ?? 0).toDouble(),
      hvac: (map['hvac'] ?? 0).toDouble(),
      flooring: (map['flooring'] ?? 0).toDouble(),
      interiorFinishes: (map['interiorFinishes'] ?? 0).toDouble(),
      cabinetry: (map['cabinetry'] ?? 0).toDouble(),
      appliances: (map['appliances'] ?? 0).toDouble(),
      landscaping: (map['landscaping'] ?? 0).toDouble(),
      permits: (map['permits'] ?? 0).toDouble(),
      architectFees: (map['architectFees'] ?? 0).toDouble(),
      sitePrep: (map['sitePrep'] ?? 0).toDouble(),
    );
  }

  // factory ConstructionCosts.fromMap(Map<String, dynamic> map) {
  //   return ConstructionCosts(
  //     bricks: map['bricks'] ?? 0.0,
  //     cement: map['cement'] ?? 0.0,
  //     plumbing: map['plumbing'] ?? 0.0,
  //     electricity: map['electricity'] ?? 0.0,
  //     labor: map['labor'] ?? 0.0,
  //     foundation: map['foundation'] ?? 0.0,
  //     roofing: map['roofing'] ?? 0.0,
  //     windows: map['windows'] ?? 0.0,
  //     hvac: map['hvac'] ?? 0.0,
  //     flooring: map['flooring'] ?? 0.0,
  //     interiorFinishes: map['interiorFinishes'] ?? 0.0,
  //     cabinetry: map['cabinetry'] ?? 0.0,
  //     appliances: map['appliances'] ?? 0.0,
  //     landscaping: map['landscaping'] ?? 0.0,
  //     permits: map['permits'] ?? 0.0,
  //     architectFees: map['architectFees'] ?? 0.0,
  //     sitePrep: map['sitePrep'] ?? 0.0,
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'bricks': bricks,
      'cement': cement,
      'plumbing': plumbing,
      'electricity': electricity,
      'labor': labor,
      'foundation': foundation,
      'roofing': roofing,
      'windows': windows,
      'hvac': hvac,
      'flooring': flooring,
      'interiorFinishes': interiorFinishes,
      'cabinetry': cabinetry,
      'appliances': appliances,
      'landscaping': landscaping,
      'permits': permits,
      'architectFees': architectFees,
      'sitePrep': sitePrep,
    };
  }

  @override
  List<Object?> get props => [
        bricks,
        cement,
        plumbing,
        electricity,
        labor,
        foundation,
        roofing,
        windows,
        hvac,
        flooring,
        interiorFinishes,
        cabinetry,
        appliances,
        landscaping,
        permits,
        architectFees,
        sitePrep,
      ];
}
