class Automovil {
  final String? id;
  final String propietario;
  final int edadPropietario;
  final String modelo;
  final double valor;
  final int accidentes;

  Automovil({
    this.id,
    required this.propietario,
    required this.edadPropietario,
    required this.modelo,
    required this.valor,
    required this.accidentes,
  });

  factory Automovil.fromJson(Map<String, dynamic> json) {
    return Automovil(
      id: json['id'] as String?,
      propietario: json['propietario'] as String,
      edadPropietario: json['edadPropietario'] as int,
      modelo: json['modelo'] as String,
      valor: (json['valor'] as num).toDouble(),
      accidentes: json['accidentes'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'propietario': propietario,
      'edadPropietario': edadPropietario,
      'modelo': modelo,
      'valor': valor,
      'accidentes': accidentes,
    };
  }

  Automovil copyWith({
    String? id,
    String? propietario,
    int? edadPropietario,
    String? modelo,
    double? valor,
    int? accidentes,
  }) {
    return Automovil(
      id: id ?? this.id,
      propietario: propietario ?? this.propietario,
      edadPropietario: edadPropietario ?? this.edadPropietario,
      modelo: modelo ?? this.modelo,
      valor: valor ?? this.valor,
      accidentes: accidentes ?? this.accidentes,
    );
  }

  // Validaciones
  static String? validarPropietario(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El propietario no puede estar en blanco';
    }

    // Verificar que no contenga números
    if (RegExp(r'\d').hasMatch(value)) {
      return 'El propietario no puede contener números';
    }

    // Verificar que tenga máximo 2 palabras
    final palabras = value.trim().split(RegExp(r'\s+'));
    if (palabras.length > 2) {
      return 'El propietario debe tener máximo 2 palabras (nombre y apellido)';
    }

    return null;
  }

  static String? validarModelo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Debe seleccionar un modelo';
    }
    if (!['A', 'B', 'C'].contains(value)) {
      return 'El modelo debe ser A, B o C';
    }
    return null;
  }
}