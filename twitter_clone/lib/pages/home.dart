import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/models/tweet.dart';
import 'package:twitter_clone/providers/tweet_provider.dart';
import 'package:twitter_clone/providers/user_provider.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LocalUser currentUser = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.blue,
            height: 1,
          ),
        ),
        title:
            const Icon(FontAwesomeIcons.twitter, size: 42, color: Colors.blue),
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    currentUser.user.profilePic,
                  ),
                  onBackgroundImageError: (exception, stackTrace) {},
                ),
              ),
            );
          },
        ),
      ),
      body: ref.watch(feedProvider).when(
          data: (List<Tweet> tweets) {
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                color: Colors.blue,
              ),
              itemCount: tweets.length,
              itemBuilder: (context, count) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      foregroundImage: NetworkImage(
                        tweets[count].profilePic,
                      ),
                    ),
                    title: Text(
                      tweets[count].name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      tweets[count].tweet,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            );
          },
          error: (error, stackTrace) => const Center(
                child: Text("error"),
              ),
          loading: () => const CircularProgressIndicator()),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Image.network(
                  currentUser.user.profilePic,
                ),
                ListTile(
                  title: RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      children: [
                        const TextSpan(text: "Hello,  "),
                        TextSpan(
                          text: currentUser.user.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                ListTile(
                  title: const Text(
                    "Settings",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/settings");
                  },
                ),
                ListTile(
                  title: const Text(
                    "Sign Out",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    ref.read(userProvider.notifier).logout();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, "/create");
          },
          elevation: 8,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, size: 30),
        ),
      ),
    );
  }
}
