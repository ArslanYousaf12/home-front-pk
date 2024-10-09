// firebase_data_populator.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await populateFirestore();
}

Future<void> populateFirestore() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final Map<String, Map<String, List<Map<String, dynamic>>>> constructionData =
      {
    'structural': {
      'bricks': [
        {
          'name': 'A-Class Bricks',
          'pricePerUnit': 14.0,
          'unit': 'per brick',
          'description': 'High-quality clay bricks',
        },
        {
          'name': 'B-Class Bricks',
          'pricePerUnit': 11.0,
          'unit': 'per brick',
          'description': 'Standard quality bricks',
        },
      ],
      'cement': [
        {
          'name': 'Lucky Cement',
          'pricePerUnit': 1150.0,
          'unit': 'per bag',
          'description': 'High-quality Portland cement',
        },
        {
          'name': 'DG Cement',
          'pricePerUnit': 1100.0,
          'unit': 'per bag',
          'description': 'Reliable cement for construction',
        },
      ],
      'foundation': [
        {
          'name': 'Standard Foundation',
          'pricePerUnit': 250.0,
          'unit': 'per sq ft',
          'description': 'Basic foundation work',
        },
        {
          'name': 'Deep Foundation',
          'pricePerUnit': 350.0,
          'unit': 'per sq ft',
          'description': 'For challenging soil conditions',
        },
      ],
      'roofing': [
        {
          'name': 'RCC Roof',
          'pricePerUnit': 180.0,
          'unit': 'per sq ft',
          'description': 'Reinforced Cement Concrete roof',
        },
        {
          'name': 'Steel Roof',
          'pricePerUnit': 150.0,
          'unit': 'per sq ft',
          'description': 'Lightweight steel roofing',
        },
      ],
    },
    'utilities': {
      'plumbing': [
        {
          'name': 'PPR Pipes',
          'pricePerUnit': 120.0,
          'unit': 'per foot',
          'description': 'High-quality polypropylene pipes',
        },
        {
          'name': 'CPVC Pipes',
          'pricePerUnit': 180.0,
          'unit': 'per foot',
          'description': 'Temperature resistant pipes',
        },
      ],
      'electricity': [
        {
          'name': 'Pakistan Cables',
          'pricePerUnit': 85.0,
          'unit': 'per meter',
          'description': 'High-quality electrical wiring',
        },
        {
          'name': 'Fast Cables',
          'pricePerUnit': 75.0,
          'unit': 'per meter',
          'description': 'Reliable electrical wiring',
        },
      ],
      'hvac': [
        {
          'name': 'Basic HVAC',
          'pricePerUnit': 250.0,
          'unit': 'per ton',
          'description': 'Standard air conditioning',
        },
        {
          'name': 'Premium HVAC',
          'pricePerUnit': 350.0,
          'unit': 'per ton',
          'description': 'Energy-efficient system',
        },
      ],
    },
    'finishing': {
      'flooring': [
        {
          'name': 'Ceramic Tiles',
          'pricePerUnit': 95.0,
          'unit': 'per sq ft',
          'description': 'Standard floor tiles',
        },
        {
          'name': 'Porcelain Tiles',
          'pricePerUnit': 120.0,
          'unit': 'per sq ft',
          'description': 'Premium floor tiles',
        },
      ],
      'windows': [
        {
          'name': 'Aluminum Windows',
          'pricePerUnit': 150.0,
          'unit': 'per sq ft',
          'description': 'Standard aluminum frame windows',
        },
        {
          'name': 'UPVC Windows',
          'pricePerUnit': 200.0,
          'unit': 'per sq ft',
          'description': 'Energy-efficient windows',
        },
      ],
      'interiorFinishes': [
        {
          'name': 'Basic Finish',
          'pricePerUnit': 50.0,
          'unit': 'per sq ft',
          'description': 'Standard wall finishing',
        },
        {
          'name': 'Premium Finish',
          'pricePerUnit': 80.0,
          'unit': 'per sq ft',
          'description': 'High-end wall finishing',
        },
      ],
      'cabinetry': [
        {
          'name': 'MDF Cabinets',
          'pricePerUnit': 300.0,
          'unit': 'per linear ft',
          'description': 'Standard kitchen cabinets',
        },
        {
          'name': 'Solid Wood Cabinets',
          'pricePerUnit': 500.0,
          'unit': 'per linear ft',
          'description': 'Premium kitchen cabinets',
        },
      ],
    },
    'appliances': {
      'basicAppliances': [
        {
          'name': 'Standard Package',
          'pricePerUnit': 150000.0,
          'unit': 'per package',
          'description': 'Basic home appliances set',
        },
        {
          'name': 'Premium Package',
          'pricePerUnit': 300000.0,
          'unit': 'per package',
          'description': 'High-end home appliances',
        },
      ],
    },
    'exterior': {
      'landscaping': [
        {
          'name': 'Basic Landscaping',
          'pricePerUnit': 50.0,
          'unit': 'per sq ft',
          'description': 'Simple garden design',
        },
        {
          'name': 'Premium Landscaping',
          'pricePerUnit': 100.0,
          'unit': 'per sq ft',
          'description': 'Elaborate garden design',
        },
      ],
    },
    'services': {
      'labor': [
        {
          'name': 'General Labor',
          'pricePerUnit': 1000.0,
          'unit': 'per day',
          'description': 'Basic construction workforce',
        },
        {
          'name': 'Skilled Labor',
          'pricePerUnit': 1500.0,
          'unit': 'per day',
          'description': 'Specialized construction workforce',
        },
      ],
      'permits': [
        {
          'name': 'Standard Permits',
          'pricePerUnit': 50000.0,
          'unit': 'flat rate',
          'description': 'Basic construction permits',
        },
        {
          'name': 'Commercial Permits',
          'pricePerUnit': 100000.0,
          'unit': 'flat rate',
          'description': 'Commercial construction permits',
        },
      ],
      'architectFees': [
        {
          'name': 'Basic Design',
          'pricePerUnit': 50.0,
          'unit': 'per sq ft',
          'description': 'Standard architectural services',
        },
        {
          'name': 'Custom Design',
          'pricePerUnit': 100.0,
          'unit': 'per sq ft',
          'description': 'Premium architectural services',
        },
      ],
      'sitePrep': [
        {
          'name': 'Basic Site Prep',
          'pricePerUnit': 30.0,
          'unit': 'per sq ft',
          'description': 'Standard site preparation',
        },
        {
          'name': 'Advanced Site Prep',
          'pricePerUnit': 50.0,
          'unit': 'per sq ft',
          'description': 'Comprehensive site preparation',
        },
      ],
    },
  };

  WriteBatch batch = firestore.batch();

  try {
    // First, delete existing data
    final collections = constructionData.keys.toList();
    for (final collection in collections) {
      final querySnapshot = await firestore.collection(collection).get();
      for (final doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }
    }
    await batch.commit();
    batch = firestore.batch();

    // Then, add new data
    for (final category in constructionData.keys) {
      final categoryRef = firestore.collection(category);

      for (final materialType in constructionData[category]!.keys) {
        final materialTypeDoc = categoryRef.doc(materialType);
        final materials = constructionData[category]![materialType]!;

        batch.set(materialTypeDoc, {
          'materials': materials,
          'lastUpdated': FieldValue.serverTimestamp(),
        });
      }
    }

    await batch.commit();
    print('Successfully populated Firestore with construction data');
  } catch (e) {
    print('Error populating Firestore: $e');
  }
}
