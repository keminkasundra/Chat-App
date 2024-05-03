import 'dart:async';
import 'package:firebase_chat/ChatList/chat_users_list.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_chat/Login/login.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;



class InitialPage extends StatefulWidget {
  InitialPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
late IO.Socket socket; 
  // AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    // loadInitialPage();
    connectToServer();
  }

  Future<void> initializeDefault() async {
      WidgetsFlutterBinding.ensureInitialized();
    // FirebaseApp app = await Firebase.initializeApp();
    // assert(app != null);
    // print('Initialized default app $app');
  }

  Future<void> connectToServer() async {
    try {
      // Replace with your actual Socket.io server URL
      // socket = IO.io('http://localhost:3000' , <String, dynamic>{
      socket = IO.io('http://192.168.1.13:8080' , <String, dynamic>{
        'transports': ['websocket'], // Specify transport (optional)
      });
      socket.connect();
      print('Connected to Socket.io server!');
       socket.emit('chat_message', 'test');
       socket.on('messageSuccess', (data) => print(data));
      // socket.on('chat_message')
      // socket.emit('chat_message', {'message': 'Hello, World!'});
// socket.emit(event)
      // Handle connection events (optional)
      socket.on('connect', (_) => print('Connected'));

      socket.on('disconnect', (_) => print('Disconnected'));

      // Check for logged-in status using your own logic (replace with your implementation)
      bool isLoggedIn = await checkLoggedInStatus(); // Implement checkLoggedInStatus
      navigateToAppropriatePage(isLoggedIn);
    } catch (e) {
      print('Error connecting to Socket.io server: $e');
    }
  }

  
  Future<bool> checkLoggedInStatus() async {
    // Implement your logic to check if the user is logged in (e.g., using shared preferences)
    // Replace with your actual implementation
    return await Future.delayed(Duration(seconds: 1), () => false); // Simulate a delay and return false
  }

  void navigateToAppropriatePage(bool isLoggedIn) {
    // Navigator.pushAndRemoveUntil(context,
    //       MaterialPageRoute(builder: (context) => ChatUserList()),
    //       (route) => false);
    if (isLoggedIn) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => ChatUserList()),
          (route) => false);
    } else {
      // Replace with your login screen widget
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
    }
  }
  // loadInitialPage() async {
  //   initializeDefault();
  //   Timer(Duration(seconds: 3), () {
  //     authService.islogedin().then((value) {
  //       if(value) {
  //         Navigator.pushAndRemoveUntil(context,
  //             MaterialPageRoute(
  //                 builder: (context) => ChatUserList()
  //             )
  //             , (route) => false);
  //       } else {
  //         Navigator.pushAndRemoveUntil(context,
  //             MaterialPageRoute(
  //                 builder: (context) => Login()
  //             )
  //             , (route) => false);
  //       }

  //     });

  //   });
  // }
 @override
  void dispose() {
    socket.disconnect(); // Disconnect from Socket.io server on widget disposal
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Chat Demo',
                style: TextStyle(
                  fontSize: 38,
                  letterSpacing: 3,
                  color: Colors.white,
                ),
              ),

            ],
          ),
        )
    );
  }
}