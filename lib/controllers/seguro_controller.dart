import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/seguro_model.dart';
import '../services/seguro_service.dart';

class SeguroState {
  final bool isLoading;
  final String? error;
  final List<Seguro> seguros;

  SeguroState({
    this.isLoading = false,
    this.error,
    this.seguros = const [],
  });

  SeguroState copyWith({
    bool? isLoading,
    String? error,
    List<Seguro>? seguros,
  }) {
    return SeguroState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      seguros: seguros ?? this.seguros,
    );
  }
}

class SeguroController extends StateNotifier<SeguroState> {
  final SeguroService _service;

  SeguroController(this._service) : super(SeguroState());

  Future<void> cargarSeguros() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final seguros = await _service.obtenerSeguros();
      state = state.copyWith(
        isLoading: false,
        seguros: seguros,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<bool> eliminarSeguro(String id) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _service.eliminarSeguro(id);
      final segurosActualizados = state.seguros.where((s) => s.id != id).toList();
      state = state.copyWith(
        isLoading: false,
        seguros: segurosActualizados,
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
}

// Providers
final seguroServiceProvider = Provider<SeguroService>((ref) {
  return SeguroService();
});

final seguroControllerProvider =
StateNotifierProvider<SeguroController, SeguroState>((ref) {
  final service = ref.watch(seguroServiceProvider);
  return SeguroController(service);
});