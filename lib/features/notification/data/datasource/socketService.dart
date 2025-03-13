import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:tura_app/features/notification/presentation/cubit/allnotiCubit.dart';
import 'package:tura_app/features/notification/presentation/cubit/unreadCubit.dart';

class SocketService {
  late IO.Socket _socket;

  // Singleton pattern (optional, if you want to ensure one instance of the socket)
  static final SocketService _instance = SocketService._internal();

  factory SocketService() {
    return _instance;
  }

  SocketService._internal();

  void connect(BuildContext context) {
    _socket = IO.io('https://backend.turaestates.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket.on('connect', (_) {
      print('Connected to server');
    });

    _socket.on('disconnect', (_) {
      print('Disconnected from server');
    });

    _socket.on('onCreateShare', (data) {
      try {
        print('Connected to createShare');
        if (data != null) {
          print('Received createShare message: $data');
          BlocProvider.of<AllNotiCubit>(context).fetchAllNotifications();
          BlocProvider.of<UnreadCubit>(context).fetchUnreadNotifications();
        } else {
          print('Received null or invalid data.');
        }
      } catch (e) {
        print('Error handling createShare event: $e');
      }
    });

// // Listen to any other events
//     _socket.onAny((event, data) {
//       print('Event received: $event with data: $data');
//     });

    // Connect to the server
    _socket.connect();
  }

  // Close the socket connection
  void disconnect() {
    _socket.dispose();
  }
}
