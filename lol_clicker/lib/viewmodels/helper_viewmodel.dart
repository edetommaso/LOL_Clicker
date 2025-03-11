import 'package:flutter/material.dart';
import 'package:lol_clicker/core/services/helper_service.dart';
import '../models/helper_model.dart';
import 'game_viewmodel.dart';

class HelperViewModel extends ChangeNotifier {
  final HelperRequest _helperRequest = HelperRequest();
  List<HelperModel> _helpers = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<HelperModel> get helpers => _helpers;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  HelperViewModel() {
    loadHelpers();
  }

  Future<void> loadHelpers() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _helpers = await _helperRequest.getHelpers();
    } catch (e) {
      _errorMessage = "Erreur lors du chargement des helpers: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void buyHelper(String helperId, GameViewModel gameViewModel) {
    final helper = _helpers.firstWhere((h) => h.id == helperId);

    if (gameViewModel.coins >= helper.price) {
      gameViewModel.removeCoins(helper.price);
      helper.purchaseCount++;
      gameViewModel.addHelperDps(helper.dps);
      _errorMessage = null;
    } else {
      _errorMessage = 'Pas assez de pièces pour acheter ${helper.name}';
    }
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null; 
    notifyListeners();
  }
}