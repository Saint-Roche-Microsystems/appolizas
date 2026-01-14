import 'package:flutter/material.dart';
import '../../widgets/poliz_card.dart';
import '../../../models/seguro_model.dart';

class SeguroItem extends StatelessWidget {
  final Seguro seguro;
  final VoidCallback onEliminar;

  const SeguroItem({super.key, required this.seguro, required this.onEliminar});

  @override
  Widget build(BuildContext context) {
    return PolizCard(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: ExpansionTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(Icons.shield, color: Colors.white),
        ),
        title: Text(
          'Seguro #${seguro.id}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Cargo Total: \$${seguro.cargoTotal.toStringAsFixed(2)}',
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onEliminar,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _DetalleRow(
                  label: 'Cargo por Valor',
                  valor: seguro.cargoPorValor,
                ),
                _DetalleRow(
                  label: 'Cargo por Modelo',
                  valor: seguro.cargoPorModelo,
                ),
                _DetalleRow(
                  label: 'Cargo por Edad',
                  valor: seguro.cargoPorEdad,
                ),
                _DetalleRow(
                  label: 'Cargo por Accidentes',
                  valor: seguro.cargoPorAccidentes,
                ),
                const Divider(thickness: 2),
                _DetalleRow(
                  label: 'TOTAL',
                  valor: seguro.cargoTotal,
                  isTotal: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetalleRow extends StatelessWidget {
  final String label;
  final double valor;
  final bool isTotal;

  const _DetalleRow({
    required this.label,
    required this.valor,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
          Text(
            '\$${valor.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
              color: isTotal ? Colors.green : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
