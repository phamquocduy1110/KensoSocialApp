import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/models/AppUser.dart';
import '/views/auth/login_view.dart';
import '/views/chat/chat_view.dart';
import '/views/favourite/favourite_view.dart';
import '/views/profile/profile_view.dart';
import '/views/timeline/timeline_view.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

final Reference storageRef = FirebaseStorage.instance.ref();
final usersRef = FirebaseFirestore.instance.collection('users');
final postsRef = FirebaseFirestore.instance.collection('posts');
final commentsRef = FirebaseFirestore.instance.collection('comments');
final activityFeedRef = FirebaseFirestore.instance.collection('feed');
final followersRef = FirebaseFirestore.instance.collection('followers');
final followingRef = FirebaseFirestore.instance.collection('following');
final DateTime timestamp = DateTime.now();

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  int _currentIndex = 0;
  final List<Widget> _views = [
     TimelineView(),
    const ChatView(),
    const FavouriteView(),
    Profile(),
  ];

  @override
  void initState() {
    isUserAuth();
    super.initState();
  }

  isUserAuth() {
    _firebaseAuth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginView()),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _firebaseAuth.currentUser == null
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            body: IndexedStack(
              children: _views,
              index: _currentIndex,
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Theme.of(context).iconTheme.color,
              unselectedItemColor: Colors.grey,
              showSelectedLabels: false,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(UniconsLine.history), label: 'Timeline'),
                BottomNavigationBarItem(
                    icon: Icon(UniconsLine.comment_dots), label: 'Chat'),
                BottomNavigationBarItem(
                    icon: Icon(UniconsLine.heart), label: 'Favourite'),
                BottomNavigationBarItem(
                    icon: Icon(UniconsLine.user), label: 'Profile')
              ],
            ),
          );
  }
}
