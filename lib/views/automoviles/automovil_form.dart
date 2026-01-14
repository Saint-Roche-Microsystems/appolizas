import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/automovil_model.dart';
import '../../widgets/poliz_text_field.dart';
import '../../widgets/poliz_select.dart';
import '../../widgets/poliz_button.dart';

class AutomovilForm extends StatefulWidget {
  final Function(Automovil) onSubmit;
  final bool isLoading;

  const AutomovilForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<AutomovilForm> createState() => _AutomovilFormState();
}

class _AutomovilFormState extends State<AutomovilForm> {
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

  void limpiarFormulario() {
    _formKey.currentState?.reset();
    _propietarioController.clear();
    _edadController.clear();
    _valorController.clear();
    _accidentesController.clear();
    setState(() {
      _modeloSeleccionado = 'A';
    });
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final automovil = Automovil(
        propietario: _propietarioController.text.trim(),
        edadPropietario: int.parse(_edadController.text),
        modelo: _modeloSeleccionado,
        valor: double.parse(_valorController.text),
        accidentes: int.parse(_accidentesController.text),
      );

      widget.onSubmit(automovil);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/car.jpg',
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text(
              'Complete los datos del vehículo',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),

            // Campo: Propietario
            PolizTextField(
              controller: _propietarioController,
              labelText: 'Propietario',
              hintText: 'Nombre Apellido',
              prefixIcon: Icons.person,
              textCapitalization: TextCapitalization.words,
              validator: Automovil.validarPropietario,
            ),
            const SizedBox(height: 16),

            // Campo: Edad
            PolizTextField(
              controller: _edadController,
              labelText: 'Edad del Propietario',
              hintText: 'Ej: 30',
              prefixIcon: Icons.calendar_today,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese la edad';
                }
                final edad = int.tryParse(value);
                if (edad == null || edad <= 0) {
                  return 'Ingrese una edad válida';
                }
                if (edad < 18) {
                  return 'El propietario debe ser mayor de edad';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Campo: Modelo
            PolizSelect<String>(
              value: _modeloSeleccionado,
              labelText: 'Modelo del Vehículo',
              prefixIcon: Icons.directions_car_outlined,
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

            // Campo: Valor
            PolizTextField(
              controller: _valorController,
              labelText: 'Valor del Automóvil',
              hintText: 'Ej: 25000.00',
              prefixIcon: Icons.attach_money,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
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

            // Campo: Accidentes
            PolizTextField(
              controller: _accidentesController,
              labelText: 'Número de Accidentes',
              hintText: 'Ej: 0',
              prefixIcon: Icons.warning_amber,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
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

            // Enviar
            PolizButton(
              text: 'Guardar',
              onPressed: _handleSubmit,
              isLoading: widget.isLoading,
            ),
          ],
        ),
      ),
    );
  }
}