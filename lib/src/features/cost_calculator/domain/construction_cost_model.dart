import 'package:equatable/equatable.dart';

// Represents individual material options
class MaterialOption {
  final String name;
  final double pricePerUnit;
  final String unit;
  final String description;

  MaterialOption({
    required this.name,
    required this.pricePerUnit,
    required this.unit,
    required this.description,
  });

  factory MaterialOption.fromMap(Map<String, dynamic> map) {
    return MaterialOption(
      name: map['name'] ?? '',
      pricePerUnit: (map['pricePerUnit'] ?? 0.0).toDouble(),
      unit: map['unit'] ?? '',
      description: map['description'] ?? '',
    );
  }
}

// Represents a material type (e.g., 'bricks', 'cement') with its options
class MaterialType {
  final String name;
  final List<MaterialOption> materials;
  MaterialOption? selectedOption;

  MaterialType({
    required this.name,
    required this.materials,
    this.selectedOption,
  }) {
    selectedOption ??= materials.isNotEmpty ? materials.first : null;
  }

  factory MaterialType.fromFirestore(String name, Map<String, dynamic> data) {
    final materialsList = (data['materials'] as List<dynamic>)
        .map((material) => MaterialOption.fromMap(material as Map<String, dynamic>))
        .toList();
    
    return MaterialType(
      name: name,
      materials: materialsList,
    );
  }
}

// Represents a category (e.g., 'structural', 'utilities')
class ConstructionCategory {
  final String name;
  final Map<String, MaterialType> materialTypes;

  ConstructionCategory({
    required this.name,
    required this.materialTypes,
  });

  factory ConstructionCategory.fromFirestore(String name, Map<String, dynamic> data) {
    final types = <String, MaterialType>{};
    
    data.forEach((typeName, typeData) {
      types[typeName] = MaterialType.fromFirestore(typeName, typeData as Map<String, dynamic>);
    });

    return ConstructionCategory(
      name: name,
      materialTypes: types,
    );
  }
}

// Main model that represents the entire construction costs structure
class ConstructionCostsModel extends Equatable {
  final Map<String, ConstructionCategory> categories;

  const ConstructionCostsModel({
    required this.categories,
  });

  factory ConstructionCostsModel.fromFirestore(Map<String, dynamic> firestoreData) {
    final categories = <String, ConstructionCategory>{};
    
    firestoreData.forEach((categoryName, categoryData) {
      categories[categoryName] = ConstructionCategory.fromFirestore(
        categoryName,
        categoryData as Map<String, dynamic>,
      );
    });

    return ConstructionCostsModel(categories: categories);
  }

  double calculateTotalCost(double area) {
    double total = 0.0;
    
    categories.forEach((categoryName, category) {
      category.materialTypes.forEach((typeName, materialType) {
        if (materialType.selectedOption != null) {
          // Calculate based on unit type
          final option = materialType.selectedOption!;
          switch (option.unit) {
            case 'per sq ft':
              total += option.pricePerUnit * area;
              break;
            case 'flat rate':
              total += option.pricePerUnit;
              break;
            // Add other unit type calculations as needed
            default:
              total += option.pricePerUnit;
          }
        }
      });
    });

    return total;
  }

  @override
  List<Object?> get props => [categories];
}