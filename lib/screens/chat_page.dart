import 'package:Makulay/widgets/login.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  MessageUsersListScreen createState() => MessageUsersListScreen();
}

class MessageUsersListScreen extends State<ChatPage> {
  bool userIsLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkUserLoggedIn();
  }

  Future<void> _checkUserLoggedIn() async {
    final isLoggedIn = await isUserLoggedIn();
    setState(() {
      userIsLoggedIn = isLoggedIn;
    });
  }

  Future<bool> isUserLoggedIn() async {
    try {
      final authUser = await Amplify.Auth.getCurrentUser();

      if (authUser != null) {
        return true; // A user is logged in
      } else {
        return false; // No user is logged in
      }
    } catch (e) {
      print('Error checking if a user is logged in: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return userIsLoggedIn ? MessageUsersList() : Login();
  }
}



class MessageUsersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _users.length,
      itemBuilder: (context, index) {
        final user = _users[index];
        return MessageUserItem(user: user);
      },
    );
  }
}

class MessageUserItem extends StatelessWidget {
  final ChatUsers user;

  MessageUserItem({required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 28.0,
        // You can set the user's profile picture here.
        backgroundImage: AssetImage(user.profilePicture),
      ),
      title: Text(
        user.username,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(user.lastMessage),
      trailing: Text(user.timestamp),
    );
  }
}

class ChatUsers {
  final String username;
  final String profilePicture;
  final String lastMessage;
  final String timestamp;

  ChatUsers({
    required this.username,
    required this.profilePicture,
    required this.lastMessage,
    required this.timestamp,
  });
}

// Sample user data
final List<ChatUsers> _users = [
  ChatUsers(
    username: 'user1',
    profilePicture: 'assets/story_image_2.jpg',
    lastMessage: 'Hello there!',
    timestamp: '2h ago',
  ),
  ChatUsers(
    username: 'user2',
    profilePicture: 'assets/story_image_4.jpg',
    lastMessage: 'Hi!',
    timestamp: '4h ago',
  ),
  ChatUsers(
    username: 'user3',
    profilePicture: 'assets/story_image_5.jpg',
    lastMessage: 'How are you?',
    timestamp: '1d ago',
  ),
  // Add more users as needed
];
