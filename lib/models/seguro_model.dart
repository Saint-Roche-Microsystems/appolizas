class Seguro {
  final String id;
  final double cargoPorValor;
  final double cargoPorModelo;
  final double cargoPorEdad;
  final double cargoPorAccidentes;
  final double cargoTotal;

  Seguro({
    required this.id,
    required this.cargoPorValor,
    required this.cargoPorModelo,
    required this.cargoPorEdad,
    required this.cargoPorAccidentes,
    required this.cargoTotal,
  });

  factory Seguro.fromJson(Map<String, dynamic> json) {
    return Seguro(
      id: json['id'] as String,
      cargoPorValor: (json['cargoPorValor'] as num).toDouble(),
      cargoPorModelo: (json['cargoPorModelo'] as num).toDouble(),
      cargoPorEdad: (json['cargoPorEdad'] as num).toDouble(),
      cargoPorAccidentes: (json['cargoPorAccidentes'] as num).toDouble(),
      cargoTotal: (json['cargoTotal'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cargoPorValor': cargoPorValor,
      'cargoPorModelo': cargoPorModelo,
      'cargoPorEdad': cargoPorEdad,
      'cargoPorAccidentes': cargoPorAccidentes,
      'cargoTotal': cargoTotal,
    };
  }

  Seguro copyWith({
    String? id,
    double? cargoPorValor,
    double? cargoPorModelo,
    double? cargoPorEdad,
    double? cargoPorAccidentes,
    double? cargoTotal,
  }) {
    return Seguro(
      id: id ?? this.id,
      cargoPorValor: cargoPorValor ?? this.cargoPorValor,
      cargoPorModelo: cargoPorModelo ?? this.cargoPorModelo,
      cargoPorEdad: cargoPorEdad ?? this.cargoPorEdad,
      cargoPorAccidentes: cargoPorAccidentes ?? this.cargoPorAccidentes,
      cargoTotal: cargoTotal ?? this.cargoTotal,
    );
  }
}