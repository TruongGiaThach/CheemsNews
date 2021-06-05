import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_chat_app/controllers/AuthenticController.dart';
import 'package:demo_chat_app/controllers/ChatController.dart';
import 'package:demo_chat_app/controllers/HomeController.dart';
import 'package:demo_chat_app/models/ChatUser.dart';
import 'package:demo_chat_app/models/Message.dart';
import 'package:demo_chat_app/views/chat/ChatScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final _homeController = Get.put(HomeController());

  HomeScreen(ChatUser _user, int _signInType) {
    _homeController.user = _user;
    _homeController.signInType = _signInType;
    _homeController.getChatGroup();
    _homeController.startListenToChange();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(_homeController.selectedIndex.value == 0
            ? "Chats"
            : "People (" + _homeController.people.length.toString() + ")")),
        leading: IconButton(
            icon: ClipOval(
              child: CachedNetworkImage(
                imageUrl: _homeController.user.photoUrl,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            onPressed: () {
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(5, 45, 100, 100),
                items: [
                  PopupMenuItem<String>(
                    child: TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.logout),
                          Text('Logout'),
                        ],
                      ),
                      onPressed: () {
                        if (_homeController.signInType == 1)
                          Get.put(AuthenticController()).signOutGoogle();
                        else
                          Get.put(AuthenticController()).signOutFacebook();
                      },
                    ),
                    value: 'Logout',
                  ),
                ],
              );
            }),
      ),
      body: Obx(
        () => (_homeController.selectedIndex.value == 0)
            ? (_homeController.isLoading.value)
                ? Center(child: CircularProgressIndicator())
                : (_homeController.chatGroups.length == 0)
                    ? Center(
                        child: Text(
                          "Hmmmm...\nSeem like you have not had conversations.",
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.builder(
                        itemCount: _homeController.chatGroups.length,
                        itemBuilder: (context, index) {
                          return OutlinedButton(
                            child: ListTile(
                              dense: true,
                              title: Text(
                                _homeController.chatGroups[index].name,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight:
                                        (_homeController.chatGroups[index].seen)
                                            ? FontWeight.normal
                                            : FontWeight.bold),
                                overflow: TextOverflow.fade,
                              ),
                              subtitle: lastMessage(
                                  _homeController.chatGroups[index].lastMessage,
                                  index),
                              leading: Hero(
                                tag:
                                    "avatar ${_homeController.chatGroups[index].id}",
                                child: SizedBox(
                                  child: (_homeController
                                                  .chatGroups[index].photoUrl !=
                                              null &&
                                          _homeController
                                                  .chatGroups[index].photoUrl !=
                                              "")
                                      ? ClipOval(
                                          child: CachedNetworkImage(
                                            imageUrl: _homeController
                                                .chatGroups[index].photoUrl,
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        )
                                      : Icon(
                                          Icons.photo,
                                          size: 45,
                                          color: Colors.grey,
                                        ),
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ),
                            onPressed: () {
                              _homeController.chatGroups[index].seen = true;
                              _homeController.chatGroups.value =
                                  List.from(_homeController.chatGroups.value);
                              Get.to(() => ChatScreen(
                                  _homeController.chatGroups[index],
                                  _homeController.user));
                            },
                            onLongPress: () {},
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero))),
                          );
                        },
                      )
            : (_homeController.isLoading.value)
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _homeController.people.length,
                    itemBuilder: (context, index) {
                      return OutlinedButton(
                        child: ListTile(
                          dense: false,
                          title: Text(
                            _homeController.people[index].displayName,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          leading: SizedBox(
                            width: 40,
                            height: 40,
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl:
                                    _homeController.people[index].photoUrl,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Get.to(() => ChatScreen.chatWithUser(
                              _homeController.people[index],
                              _homeController.user));
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero))),
                      );
                    },
                  ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: _homeController.selectedIndex.value,
          onTap: (index) async {
            _homeController.selectedIndex.value = index;
            if (index == 1) {
              await _homeController.getPeople();
            } else
              await _homeController.getChatGroup();
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
            BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    Icon(
                      Icons.people,
                      size: 32,
                    ),
                    new Positioned(
                      right: 0.0,
                      top: 1.0,
                      child: Stack(
                        children: [
                          Container(
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 15,
                              minHeight: 15,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(1),
                            decoration: new BoxDecoration(
                              color: Colors.green.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 12,
                              minHeight: 12,
                            ),
                            child: new Text(
                              _homeController.people.length.toString(),
                              style: new TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.green,
                                fontSize: 9,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                label: "People"),
          ],
        ),
      ),
    );
  }

  Widget lastMessage(Message message, int index) {
    String txt = "";
    if (message.senderUID == _homeController.user.uid) {
      txt += "You";
    } else {
      txt += _homeController.chatGroups[index].name;
    }
    if (message.type == 0) {
      txt += ": " + message.content;
    } else {
      txt += " sent you a image.";
    }
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: Text(
            txt,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: (_homeController.chatGroups[index].seen)
                  ? FontWeight.normal
                  : FontWeight.bold,
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Text(
            " - " + ChatController.getTime(message.timeStamp),
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontWeight: (_homeController.chatGroups[index].seen)
                  ? FontWeight.normal
                  : FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
