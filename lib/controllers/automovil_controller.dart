import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/automovil_model.dart';
import '../services/automovil_service.dart';

class AutomovilState {
  final bool isLoading;
  final String? error;
  final Automovil? automovilCreado;

  AutomovilState({
    this.isLoading = false,
    this.error,
    this.automovilCreado,
  });

  AutomovilState copyWith({
    bool? isLoading,
    String? error,
    Automovil? automovilCreado,
  }) {
    return AutomovilState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      automovilCreado: automovilCreado ?? this.automovilCreado,
    );
  }
}

class AutomovilController extends StateNotifier<AutomovilState> {
  final AutomovilService _service;

  AutomovilController(this._service) : super(AutomovilState());

  Future<bool> crearAutomovil(Automovil automovil) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final automovilCreado = await _service.crearAutomovil(automovil);
      state = state.copyWith(
        isLoading: false,
        automovilCreado: automovilCreado,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  void limpiarEstado() {
    state = AutomovilState();
  }
}

// Providers
final automovilServiceProvider = Provider<AutomovilService>((ref) {
  return AutomovilService();
});

final automovilControllerProvider =
StateNotifierProvider<AutomovilController, AutomovilState>((ref) {
  final service = ref.watch(automovilServiceProvider);
  return AutomovilController(service);
});