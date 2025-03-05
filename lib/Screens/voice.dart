import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_chess_board/flutter_chess_board.dart';

void main() {
  runApp(VoiceControlledChess());
}

class VoiceControlledChess extends StatelessWidget {
  const VoiceControlledChess({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChessGame(),
    );
  }
}

class ChessGame extends StatefulWidget {
  const ChessGame({super.key});

  @override
  _ChessGameState createState() => _ChessGameState();
}

class _ChessGameState extends State<ChessGame> {
  late stt.SpeechToText _speech;
  final ChessBoardController _controller = ChessBoardController();
  bool _isListening = false;
  String _lastCommand = "";

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  Future<void> _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) => print('Status: $status'),
      onError: (error) => print('Error: $error'),
    );
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (result) {
          setState(() {
            _lastCommand = result.recognizedWords;
            _processCommand(_lastCommand);
          });
        },
      );
    } else {
      setState(() => _isListening = false);
      print("Speech recognition unavailable.");
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  void _processCommand(String command) {
    command = command.toLowerCase().replaceAll(" to ", "").replaceAll(" ", "");
    if (command.length == 4) {
      try {
        _controller.makeMove(command.substring(0, 2), newMethod(command));
      } catch (e) {
        _showSnackbar("Invalid move: $command");
      }
    } else {
      _showSnackbar("Command not understood. Try moves like 'E2 to E4'.");
    }
  }

  String newMethod(String command) => command.substring(2, 4);

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voice-Controlled Chess"),
        actions: [
          IconButton(
            icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
            onPressed: _isListening ? _stopListening : _startListening,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ChessBoard(
              controller: _controller,
              boardColor: BoardColor.brown,
              boardOrientation: PlayerColor.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _lastCommand.isEmpty
                  ? "Say a move like 'E2 to E4'."
                  : "Last Command: $_lastCommand",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
