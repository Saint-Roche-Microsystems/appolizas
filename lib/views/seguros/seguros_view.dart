import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/poliz_snackbar.dart';
import '../../controllers/seguro_controller.dart';
import 'seguro_item.dart';
import 'seguros_states.dart';

class SegurosView extends ConsumerStatefulWidget {
  const SegurosView({super.key});

  @override
  ConsumerState<SegurosView> createState() => _SegurosViewState();
}

class _SegurosViewState extends ConsumerState<SegurosView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(seguroControllerProvider.notifier).cargarSeguros(),
    );
  }

  Future<void> _eliminarSeguro(String id) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.orange),
            SizedBox(width: 12),
            Text('Confirmar eliminación'),
          ],
        ),
        content: const Text('¿Está seguro de que desea eliminar este seguro?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
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
          PolizSnackBar.showSuccess(
            context,
            message: 'Seguro eliminado exitosamente',
          );
        } else {
          final error = ref.read(seguroControllerProvider).error;
          PolizSnackBar.showError(
            context,
            message: error ?? 'Error al eliminar el seguro',
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
      ),
      body: _buidlBody(state),
    );
  }

  Widget _buidlBody(SeguroState state) {
    if(state.isLoading) {
      return LoadingSegurosView();
    }

    if(state.error != null) {
      return ErrorSegurosView(
        error: state.error!,
        onRetry: () => ref.read(seguroControllerProvider.notifier).cargarSeguros(),
      );
    }

    if(state.seguros.isEmpty) {
      return EmptySegurosView();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.seguros.length,
      itemBuilder: (context, index) {
        final seguro = state.seguros[index];
        return SeguroItem(
          seguro: seguro,
          onEliminar: () => _eliminarSeguro(seguro.id),
        );
      },
    );
  }
}
