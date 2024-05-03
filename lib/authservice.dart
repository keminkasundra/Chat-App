// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User {
  final String name;
  final String email;
  // Other user attributes

  User({required this.name, required this.email});
}

const String clientId =
    '37266721800-s6km4jf18vmnnf4t76bieg5pejud2odr.apps.googleusercontent.com';

class AuthService {
  final secureStorage = new FlutterSecureStorage();

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
     'openid', 'profile',
    'https://www.googleapis.com/auth/drive',
    'https://www.googleapis.com/auth/contacts.readonly',
    'https://www.googleapis.com/auth/userinfo.profile',
    
  ], clientId: clientId);
  // DatabaseReference rootRef = FirebaseDatabase.instance.reference();

  Future<bool> islogedin() async {
    var res = await secureStorage.read(key: "user");
    if (res.toString() != 'null') {
      return true;
    } else {
      return false;
    }
  }

  // Future<User?> googleSignin(BuildContext context) async {
  //   User? currentUser;
  //   try {
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser!.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //     // final User user = await FirebaseAuth.instance
  //     //     .signInWithCredential(credential)
  //     //     .then((value) => value.user!);
  //     assert(user.email != null);
  //     assert(user.displayName != null);
  //     assert(!user.isAnonymous);
  //     assert(await user.getIdToken() != null);
  //     // currentUser = FirebaseAuth.instance.currentUser!;
  //     await secureStorage.write(key: "user", value: currentUser.toString());
  //     await secureStorage.write(key: "uid", value: currentUser.uid.toString());
  //     await secureStorage.write(
  //         key: "name", value: currentUser.displayName.toString());
  //     await secureStorage.write(
  //         key: "email", value: currentUser.email.toString());

  //     assert(user.uid == currentUser.uid);
  //     print(currentUser);
  //     final QuerySnapshot result = await FirebaseFirestore.instance
  //         .collection('users')
  //         .where('uid', isEqualTo: currentUser.uid)
  //         .get();
  //     final List<DocumentSnapshot> documents = result.docs;

  //     // if (documents.length == 0) {
  //     //   // Update data to server if new user
  //     //   FirebaseFirestore.instance
  //     //       .collection('users')
  //     //       .doc(currentUser.uid)
  //     //       .set({
  //     //     'name': currentUser.displayName,
  //     //     'photoUrl': currentUser.photoURL,
  //     //     'uid': currentUser.uid,
  //     //     'email': currentUser.email,
  //     //     'PhoneNumber': currentUser.phoneNumber,
  //     //     'Status': 'Hey There!',
  //     //     'AboutMe': 'Developer',
  //     //     'onlineStatus': 'Online'
  //     //   });
  //     //   await secureStorage.write(key: "id", value: currentUser.uid.toString());
  //     //   await secureStorage.write(
  //     //       key: "name", value: currentUser.displayName.toString());
  //     //   await secureStorage.write(
  //     //       key: "photoUrl", value: currentUser.photoURL.toString());
  //     //   await secureStorage.write(
  //     //       key: "email", value: currentUser.email.toString());
  //     // } else {
  //     //   print("User Name : ${documents.length}");
  //     //   FirebaseFirestore.instance
  //     //       .collection('users')
  //     //       .doc(currentUser.uid)
  //     //       .update({
  //     //     'name': documents[0].data()['name'],
  //     //     'photoUrl': documents[0].data()['photoUrl'],
  //     //     'uid': currentUser.uid,
  //     //     'email': currentUser.email,
  //     //     'PhoneNumber': documents[0].data()['PhoneNumber'],
  //     //     'Status': documents[0].data()['Status'],
  //     //     'AboutMe': documents[0].data()['AboutMe'],
  //     //   });
  //     //   await secureStorage.write(key: "id", value: documents[0].data()['uid']);
  //     //   await secureStorage.write(
  //     //       key: "name", value: documents[0].data()['name']);
  //     //   await secureStorage.write(
  //     //       key: "photoUrl", value: documents[0].data()['photoUrl']);
  //     //   await secureStorage.write(
  //     //       key: "email", value: documents[0].data()['email']);
  //     // }

  //     if (documents.isNotEmpty) {
  //       if (documents.length == 0) {
  //         // Update data to server if new user
  //         FirebaseFirestore.instance
  //             .collection('users')
  //             .doc(currentUser.uid)
  //             .set({
  //           'name': currentUser.displayName,
  //           'photoUrl': currentUser.photoURL,
  //           'uid': currentUser.uid,
  //           'email': currentUser.email,
  //           'PhoneNumber': currentUser.phoneNumber,
  //           'Status': 'Hey There!',
  //           'AboutMe': 'Developer',
  //           'onlineStatus': 'Online'
  //         });
  //         await secureStorage.write(
  //             key: "id", value: currentUser.uid.toString());
  //         await secureStorage.write(
  //             key: "name", value: currentUser.displayName.toString());
  //         await secureStorage.write(
  //             key: "photoUrl", value: currentUser.photoURL.toString());
  //         await secureStorage.write(
  //             key: "email", value: currentUser.email.toString());
  //       } else {
  //         print("User Name : ${documents.length}");
  //         Map<String, dynamic>? userData =
  //             documents[0].data() as Map<String, dynamic>?;
  //         if (userData != null) {
  //           FirebaseFirestore.instance
  //               .collection('users')
  //               .doc(currentUser.uid)
  //               .update({
  //             'name':
  //                 userData['name'], // Using null check before accessing fields
  //             'photoUrl': userData['photoUrl'],
  //             'uid': currentUser.uid,
  //             'email': currentUser.email,
  //             'PhoneNumber': userData['PhoneNumber'],
  //             'Status': userData['Status'],
  //             'AboutMe': userData['AboutMe'],
  //           });
  //           await secureStorage.write(key: "id", value: userData['uid']);
  //           await secureStorage.write(key: "name", value: userData['name']);
  //           await secureStorage.write(
  //               key: "photoUrl", value: userData['photoUrl']);
  //           await secureStorage.write(key: "email", value: userData['email']);
  //         }
  //       }
  //     } else {
  //       print('Documents list is empty.');
  //     }

  //     // var newkey = rootRef.child("Users").push().key;
  //     // rootRef.child("Users").orderByChild("uid").equalTo("${currentUser.uid}").once().then((DataSnapshot snapshot) {
  //     //   if (snapshot.value == null) {
  //     //     rootRef.child("Users").child(newkey).set({
  //     //       "name" : "${currentUser.displayName}",
  //     //       "email" : "${currentUser.email}",
  //     //       "PhoneNumber" : "${currentUser.phoneNumber}",
  //     //       "Photo" : "${currentUser.photoURL}",
  //     //       "uid" : "${currentUser.uid}",
  //     //     });
  //     //   }
  //     // });

  //     return user;
  //   } catch (e) {
  //     print(e);
  //     return currentUser;
  //   }
  // }

  Future<User?> googleSignin(BuildContext context) async {
    User? currentUser;

    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      print(googleAuth);

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print("credential : $credential");
      print("googleAuth.accessToken : ${googleAuth.accessToken}");
      print("googleAuth.idToken : ${googleAuth.idToken}");
      print(googleUser);
      print(googleUser?.displayName);
      print(googleUser.runtimeType);
      print('ok');

      if (googleUser == null) {
        return currentUser; // Handle sign-in cancellation
      }

      // Process user data
      currentUser = User(
        name: googleUser?.displayName ?? "",
        email: googleUser?.email ?? "",
        // Other user attributes
      );

      // Store user data locally or perform any necessary actions
      _googleSignIn.signInSilently();
      return currentUser;
    } catch (e) {
      print(e);
      print("Error during Google sign-in: $e");

      return currentUser;
    }
  }

  Future<bool> googleSignout() async {
    // await auth.signOut();
    await _googleSignIn.signOut().then((value) {
      print(value?.displayName);
    });
    return true;
  }

  //   Future<bool> login(String username, String password) async {
  //   // Implement your login logic using Socket.io events
  //   // You'll need to define events on your server to handle login requests
  //   // and send responses with success/failure information

  //   Map<String, dynamic> loginData = {'username': username, 'password': password};

  //   try {
  //     socket.emit('login', loginData); // Emit a login event with user credentials

  //     socket.on('login_response', (data) {
  //       // Handle login response from the server
  //       if (data['success'] == true) {
  //         await secureStorage.write(key: "user", value: data['user']);
  //         // Store additional user data received from the server (optional)
  //         return true;
  //       } else {
  //         print(data['message']); // Handle login failure message
  //         return false;
  //       }
  //     });

  //     // Add a timeout mechanism to handle cases where the server doesn't respond (optional)

  //     return true; // Indicate login attempt initiated (waiting for server response)
  //   } catch (e) {
  //     print('Error during login: $e');
  //     return false;
  //   }
  // }

  // Future<bool> logout() async {
  //   // Implement your logout logic using Socket.io events
  //   // You'll need to define an event on your server to handle logout requests

  //   try {
  //     socket.emit('logout'); // Emit a logout event

  //     await secureStorage.delete(key: "user");
  //     // Clear any other stored user data (optional)

  //     return true;
  //   } catch (e) {
  //     print('Error during logout: $e');
  //     return false;
  //   }
  // }

  // Future<Map<String, dynamic>?> getUserData() async {
  //   String? userId = await secureStorage.read(key: "user");
  //   if (userId == null) return null;

  //   // Implement your logic to retrieve user data using Socket.io events
  //   // You'll need to define an event on your server to handle user data requests

  //   try {
  //     socket.emit('get_user_data', {'userId': userId}); // Emit a request for user data

  //     socket.on('user_data_response', (data) {
  //       // Handle user data response from the server
  //       if (data['success'] == true) {
  //         return data['user']; // Return received user data
  //       } else {
  //         print(data['message']); // Handle data retrieval failure message
  //         return null;
  //       }
  //     });

  //     // Add a timeout mechanism to handle cases where the server doesn't respond (optional)

  //     return null; // Indicate data request initiated (waiting for server response)
  //   } catch (e) {
  //     print('Error retrieving user data: $e');
  //     return null;
  //   }
  // }
}
