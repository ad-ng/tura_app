import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket _socket;

  // Singleton pattern (optional, if you want to ensure one instance of the socket)
  static final SocketService _instance = SocketService._internal();

  factory SocketService() {
    return _instance;
  }

  SocketService._internal();

  // Connect to the server
  void connect() {
    _socket = IO.io('http://your-server-url.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    // Listen to the 'connect' event to know when the socket is connected
    _socket.on('connect', (_) {
      print('Connected to server');
    });

    // Listen to the 'disconnect' event to handle disconnect
    _socket.on('disconnect', (_) {
      print('Disconnected from server');
    });

    // Example of listening to a 'message' event from the server
    _socket.on('message', (data) {
      print('Received message: $data');
      // You can add any logic here to update the UI or process the message
    });

    // Connect to the server
    _socket.connect();
  }

  // Emit an event to the server
  void sendMessage(String message) {
    _socket.emit('message', message);
  }

  // Close the socket connection
  void disconnect() {
    _socket.dispose();
  }
}
