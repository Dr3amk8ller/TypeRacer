import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/game_state.dart';
import '../providers/client_state_provider.dart';
import '../providers/game_state_provider.dart';
import '../utils/socket_methods.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/game_text_field.dart';
import '../widgets/sentence_game.dart';

class GameStateProvider extends ChangeNotifier {
  GameState _gameState = GameState(
    id: '',
    players: [],
    isJoin: true,
    words: [],
    isOver: false,
  );

  Map<String, dynamic> get gameState => _gameState.toJson();

  void updateGameState({
    required id,
    required players,
    required isJoin,
    required words,
    required isOver,
  }) {
    _gameState = GameState(
      id: id,
      players: players,
      isJoin: isJoin,
      words: words,
      isOver: isOver,
    );
    notifyListeners();
  }
}
