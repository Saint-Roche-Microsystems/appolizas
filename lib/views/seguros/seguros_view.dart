import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/seguro_controller.dart';
import '../../models/seguro_model.dart';

class SegurosView extends ConsumerStatefulWidget {
  const SegurosView({super.key});

  @override
  ConsumerState<SegurosView> createState() => _SegurosViewState();
}

class _SegurosViewState extends ConsumerState<SegurosView> {
  @override
  void initState() {
    super.initState();
    // Cargar seguros al iniciar
    Future.microtask(
          () => ref.read(seguroControllerProvider.notifier).cargarSeguros(),
    );
  }

  Future<void> _eliminarSeguro(String id) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: const Text('¿Está seguro de que desea eliminar este seguro?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmar == true && mounted) {
      final controller = ref.read(seguroControllerProvider.notifier);
      final exito = await controller.eliminarSeguro(id);

      if (mounted) {
        if (exito) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Seguro eliminado exitosamente'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          final error = ref.read(seguroControllerProvider).error;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $error'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(seguroControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seguros'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(seguroControllerProvider.notifier).cargarSeguros();
            },
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Error: ${state.error}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(seguroControllerProvider.notifier).cargarSeguros();
              },
              child: const Text('Reintentar'),
            ),
          ],
        ),
      )
          : state.seguros.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No hay seguros registrados',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: state.seguros.length,
        itemBuilder: (context, index) {
          final seguro = state.seguros[index];
          return _SeguroCard(
            seguro: seguro,
            onEliminar: () => _eliminarSeguro(seguro.id),
          );
        },
      ),
    );
  }
}

class _SeguroCard extends StatelessWidget {
  final Seguro seguro;
  final VoidCallback onEliminar;

  const _SeguroCard({
    required this.seguro,
    required this.onEliminar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
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