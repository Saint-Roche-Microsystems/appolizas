import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/poliz_snackbar.dart';
import '../../controllers/seguro_controller.dart';
import '../../controllers/automovil_controller.dart';
import 'automovil_form.dart';

class AutomovilesView extends ConsumerWidget {
  const AutomovilesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(automovilControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Automóviles'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: AutomovilForm(
          isLoading: state.isLoading,
          onSubmit: (automovil) async {
            final controller = ref.read(automovilControllerProvider.notifier);
            final exito = await controller.crearAutomovil(automovil);

            if (context.mounted) {
              if (exito) {
                PolizSnackBar.showSuccess(
                  context,
                  message: 'Automóvil creado exitosamente',
                );
                await ref.read(seguroControllerProvider.notifier).cargarSeguros();
              } else {
                final error = ref.read(automovilControllerProvider).error;
                PolizSnackBar.showError(
                  context,
                  message: error ?? 'Error al crear el automóvil',
                );
              }
            }
          }
        ),
      ),
    );
  }
}
