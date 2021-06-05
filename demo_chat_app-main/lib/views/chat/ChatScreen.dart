import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_chat_app/controllers/ChatController.dart';
import 'package:demo_chat_app/models/ChatGroup.dart';
import 'package:demo_chat_app/models/ChatUser.dart';
import 'package:demo_chat_app/models/Message.dart';
import 'package:demo_chat_app/views/chat/FullImageScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  final _chatController = Get.put(ChatController());
  ChatScreen(ChatGroup _chatGroup, ChatUser _mainUser) {
    _chatController.chatGroup = _chatGroup;
    _chatController.mainUser = _mainUser;
    _chatController.getMessage();
    _chatController.startListenToChange();
  }
  ChatScreen.chatWithUser(ChatUser partner, ChatUser mainUser) {
    _chatController.partner = partner;
    print(partner.displayName);
    _chatController.mainUser = mainUser;
    _chatController.isNewChatUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: -10.0,
        title: Obx(
          () => (_chatController.isLoading.value)
              ? CircularProgressIndicator()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Hero(
                        tag: _chatController.chatNewUser.value
                            ? "avatar ${_chatController.partner.uid}"
                            : "avatar ${_chatController.chatGroup.id}",
                        child: SizedBox(
                          width: 45,
                          height: 45,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: _chatController.chatNewUser.value
                                  ? _chatController.partner.photoUrl
                                  : _chatController.chatGroup.photoUrl,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    Text(_chatController.chatNewUser.value
                        ? _chatController.partner.uid ==
                                _chatController.mainUser.uid
                            ? "You"
                            : _chatController.partner.displayName
                        : _chatController.chatGroup.name),
                  ],
                ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              buildListMessage(),
              buildInput(),
            ],
          ),

          // Loading
        ],
      ),
    );
  }

  Widget buildListMessage() {
    return Flexible(
      child: Obx(
        () => (_chatController.isLoading.value)
            ? Center(child: CircularProgressIndicator())
            : (_chatController.chatNewUser.value)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: ClipOval(
                          clipBehavior: Clip.hardEdge,
                          child: CachedNetworkImage(
                            imageUrl: _chatController.chatNewUser.value
                                ? _chatController.partner.photoUrl
                                : _chatController.chatGroup.photoUrl,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _chatController.chatNewUser.value
                            ? _chatController.partner.displayName
                            : _chatController.chatGroup.name,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Start chatting with " +
                            (_chatController.chatNewUser.value
                                ? _chatController.partner.displayName
                                : _chatController.chatGroup.name) +
                            " right now.",
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 50),
                    ],
                  )
                : Scrollbar(
                    showTrackOnHover: true,
                    thickness: 5.0,
                    controller: _chatController.scrollController,
                    child: ListView.builder(
                      controller: _chatController.scrollController,
                      itemCount: _chatController.messages.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          dense: true,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          title: buildMessageItem(
                              _chatController.messages[index], index),
                        );
                      },
                      reverse: true,
                    ),
                  ),
      ),
    );
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: Icon(Icons.image),
                onPressed: _chatController.getImage,
              ),
            ),
            color: Colors.white,
          ),

          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                controller: _chatController.mainTextController,
                onSubmitted: (value) {
                  _chatController.sendMessage(0);
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),

          // Button send message
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  _chatController.sendMessage(0);
                },
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
          color: Colors.white),
    );
  }

  Widget buildMessageItem(Message message, int index) {
    if (message.senderUID == _chatController.mainUser.uid) {
      switch (message.type) {
        case 0:
          return Column(
            children: [
              (_chatController.needShowTime(index))
                  ? Center(
                      child: Text(ChatController.getTime(message.timeStamp)))
                  : Container(height: 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Container(
                      child: Text(
                        message.content,
                        style: TextStyle(color: Colors.white, fontSize: 13.5),
                      ),
                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      margin: EdgeInsets.only(top: 5.0, left: 25.0),
                    ),
                  ),
                  Container(width: 5.0),
                ],
              ),
            ],
          );
          break;
        case 1:
          return Column(
            children: [
              (_chatController.needShowTime(index))
                  ? Center(
                      child: Text(ChatController.getTime(message.timeStamp)))
                  : Container(height: 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: Get.width / 2,
                          maxHeight: Get.height / 2,
                          minHeight: 50,
                          minWidth: 100),
                      child: TextButton(
                        onPressed: () {
                          Get.to(() => FullImageScreen(
                                imageURL: message.content,
                                name: _chatController.chatGroup.name,
                              ));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: CachedNetworkImage(
                            imageUrl: message.content,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(width: 0),
                ],
              ),
            ],
          );
          break;
        default:
          return Container();
          break;
      }
    } else {
      switch (message.type) {
        case 0:
          return Column(
            children: [
              (_chatController.needShowTime(index))
                  ? Center(
                      child: Text(ChatController.getTime(message.timeStamp)))
                  : Container(height: 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _chatController.isLastLeft(index)
                      ? Container(
                          width: 30,
                          height: 30,
                          child: ClipOval(
                            child: Image(
                                image: CachedNetworkImageProvider(
                                    _chatController.chatNewUser.value
                                        ? _chatController.partner.photoUrl
                                        : _chatController.chatGroup.photoUrl)),
                          ),
                        )
                      : Container(width: 30),
                  Flexible(
                    child: Container(
                      child: Text(
                        message.content,
                        style: TextStyle(color: Colors.black, fontSize: 13.5),
                      ),
                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      margin: EdgeInsets.only(top: 5.0, right: 25.0, left: 5.0),
                    ),
                  )
                ],
              ),
            ],
          );
          break;
        case 1:
          return Column(
            children: [
              (_chatController.needShowTime(index))
                  ? Center(
                      child: Text(ChatController.getTime(message.timeStamp)))
                  : Container(height: 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _chatController.isLastRight(index)
                      ? Container(
                          width: 30,
                          height: 30,
                          child: ClipOval(
                            child: Image(
                                image: CachedNetworkImageProvider(
                                    _chatController.chatGroup.photoUrl)),
                          ),
                        )
                      : Container(width: 30),
                  Flexible(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: Get.width / 2,
                          maxHeight: Get.height / 2,
                          minHeight: 50,
                          minWidth: 100),
                      child: TextButton(
                        onPressed: () {
                          Get.to(() => FullImageScreen(
                                imageURL: message.content,
                                name: _chatController.chatGroup.name,
                              ));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: CachedNetworkImage(
                            imageUrl: message.content,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
          break;
        default:
          return Container();
          break;
      }
    }
  }
}
