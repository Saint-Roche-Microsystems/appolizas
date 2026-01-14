import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/automovil_controller.dart';
import '../../models/automovil_model.dart';

class AutomovilesView extends ConsumerStatefulWidget {
  const AutomovilesView({super.key});

  @override
  ConsumerState<AutomovilesView> createState() => _AutomovilesViewState();
}

class _AutomovilesViewState extends ConsumerState<AutomovilesView> {
  final _formKey = GlobalKey<FormState>();
  final _propietarioController = TextEditingController();
  final _edadController = TextEditingController();
  final _valorController = TextEditingController();
  final _accidentesController = TextEditingController();
  String _modeloSeleccionado = 'A';

  @override
  void dispose() {
    _propietarioController.dispose();
    _edadController.dispose();
    _valorController.dispose();
    _accidentesController.dispose();
    super.dispose();
  }

  void _limpiarFormulario() {
    _formKey.currentState?.reset();
    _propietarioController.clear();
    _edadController.clear();
    _valorController.clear();
    _accidentesController.clear();
    setState(() {
      _modeloSeleccionado = 'A';
    });
  }

  Future<void> _crearAutomovil() async {
    if (_formKey.currentState!.validate()) {
      final automovil = Automovil(
        propietario: _propietarioController.text.trim(),
        edadPropietario: int.parse(_edadController.text),
        modelo: _modeloSeleccionado,
        valor: double.parse(_valorController.text),
        accidentes: int.parse(_accidentesController.text),
      );

      final controller = ref.read(automovilControllerProvider.notifier);
      final exito = await controller.crearAutomovil(automovil);

      if (mounted) {
        if (exito) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Automóvil creado exitosamente'),
              backgroundColor: Colors.green,
            ),
          );
          _limpiarFormulario();
        } else {
          final error = ref.read(automovilControllerProvider).error;
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
    final state = ref.watch(automovilControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Automóviles'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _propietarioController,
                decoration: const InputDecoration(
                  labelText: 'Propietario (Nombre Apellido)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: Automovil.validarPropietario,
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _edadController,
                decoration: const InputDecoration(
                  labelText: 'Edad del Propietario',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese la edad';
                  }
                  final edad = int.tryParse(value);
                  if (edad == null || edad <= 0) {
                    return 'Ingrese una edad válida';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _modeloSeleccionado,
                decoration: const InputDecoration(
                  labelText: 'Modelo',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.directions_car),
                ),
                items: ['A', 'B', 'C'].map((modelo) {
                  return DropdownMenuItem(
                    value: modelo,
                    child: Text('Modelo $modelo'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _modeloSeleccionado = value!;
                  });
                },
                validator: Automovil.validarModelo,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _valorController,
                decoration: const InputDecoration(
                  labelText: 'Valor del Automóvil',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el valor';
                  }
                  final valor = double.tryParse(value);
                  if (valor == null || valor <= 0) {
                    return 'Ingrese un valor válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _accidentesController,
                decoration: const InputDecoration(
                  labelText: 'Número de Accidentes',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.warning),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el número de accidentes';
                  }
                  final accidentes = int.tryParse(value);
                  if (accidentes == null || accidentes < 0) {
                    return 'Ingrese un número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: state.isLoading ? null : _crearAutomovil,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: state.isLoading
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : const Text(
                  'Registrar Automóvil',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}