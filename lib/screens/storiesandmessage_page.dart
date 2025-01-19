import 'package:Makulay/screens/group_posts_page.dart';
import 'package:Makulay/screens/posts_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class StoriesAndMessagesPage extends StatefulWidget {
  final String profilepicture;
  final String username;
  final String userid;
  const StoriesAndMessagesPage({
    Key? key,
    required this.profilepicture,
    required this.username,
    required this.userid,
  }) : super(key: key);
  @override
  _StoriesAndMessagesPageState createState() => _StoriesAndMessagesPageState();
}

class _StoriesAndMessagesPageState extends State<StoriesAndMessagesPage> {
  bool isExpanded = true; // State to track if the stories section is expanded
  int totalStories = 10; // Total number of stories
  int seenStories = 0; // Number of seen stories
  TextEditingController messageController =
      TextEditingController(); // Controller for message input
  List<String> messages = []; // List to store messages

  // ScrollController for messages
  final ScrollController _messageScrollController = ScrollController();

  String selectedCategory = 'Today';

  FocusNode _focus = FocusNode();

  void _onFocusChange() {
    debugPrint("Focus: ${_focus.hasFocus.toString()}");
  }

  @override
  void initState() {
    _focus.addListener(_onFocusChange);
    super.initState();
    // Listen to scroll events
    _messageScrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
    _messageScrollController.dispose();
    messageController.dispose();
    super.dispose();
  }

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      setState(() {
        messages.add(messageController.text); // Add message to the list
        messageController.clear(); // Clear the input field
      });
    }
  }

  void toggleStories() {
    setState(() {
      isExpanded = !isExpanded; // Toggle the expansion state
    });
  }

  void markStoryAsSeen() {
    if (seenStories < totalStories) {
      setState(() {
        seenStories++; // Increment the count of seen stories
      });
    }
  }

  // Method to handle scroll events
  void _onScroll() {
    if (_messageScrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      // User is scrolling down
      if (isExpanded) {
        setState(() {
          isExpanded = false;
        });
      }
    } /*else if (_messageScrollController.position.userScrollDirection == ScrollDirection.forward) {
      // User is scrolling up
      if (!isExpanded) {
        setState(() {
          isExpanded = true;
        });
      }
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
            surfaceTintColor: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                //statusBarColor: Colors.black,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light),
            toolbarHeight: 0,
            backgroundColor: Colors.white),
        body: new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
            child: Column(
              children: [
                // Top section: Stories (Expandable)
                AnimatedContainer(
                  duration: Duration(milliseconds: 0), // Animation duration
                  height: isExpanded && _focus.hasFocus.toString() != 'true'
                      ? (MediaQuery.of(context).size.height / 3) - 60

                      /// 2 + 120
                      : 60, // Conditional height
                  //padding: EdgeInsets.all(10),
                  color:
                      Colors.white, // Background color for the stories section
                  child: /*Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: new RoundedRectangleBorder(
                        side: new BorderSide(color: Colors.white12, width: .3),
                        borderRadius:
                            new BorderRadius.all(const Radius.circular(10.0)),
                      ),
                      child: */
                      Column(
                    children: [
                      // Title with counter

                      /*Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(20),
                                  backgroundColor:
                                      Colors.grey.shade100, // <-- Button color
                                  foregroundColor:
                                      Colors.black, // <-- Splash color
                                ),
                                child: Icon(Icons.close_rounded),
                                onPressed: () {
                                  Navigator.pop(context, true);
                                }),
                            Text(
                              'Family',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: IconButton(
                                icon: Icon(
                                  isExpanded &&
                                          _focus.hasFocus.toString() != 'true'
                                      ? Icons.expand_less
                                      : Icons.fiber_new_outlined,
                                  size: 32,
                                ),
                                color: Colors.amber,
                                onPressed: toggleStories,
                                tooltip: isExpanded &&
                                        _focus.hasFocus.toString() != 'true'
                                    ? 'Collapse Stories'
                                    : 'Expand Stories',
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                              ),
                            )
                          ],
                        ),
                      ),
                      */
                      //isExpanded && _focus.hasFocus.toString() != 'true'
                      // ?
                      Container(
                        color:
                      Colors.white,
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(5,0,8,0),
                                      child: SizedBox(
                                          width: 39.0,
                                          height: 39.0,
                                          child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                side: BorderSide(width: 0, color: Colors.white),
                                                shape: CircleBorder(),
                                                padding:
                                                    EdgeInsets.only(right: 0),
                                                backgroundColor: Colors.grey
                                                    .shade100, // <-- Button color
                                                foregroundColor: Colors
                                                    .black, // <-- Splash color
                                                  
                                              ),
                                              child: Icon(
                                                Icons.close_rounded,
                                                size: 17,
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context, true);
                                              })),

                                      /*ChoiceChip(
                                        backgroundColor: Colors.grey.shade100,
                                        label: Icon(
                                          //Icons.content_copy_rounded,
                                          Icons.close,
                                          size: 18,
                                          color: Colors.black,
                                        ),
                                        selected: false,
                                        selectedColor: Colors.black,
                                        showCheckmark: false,
                                        onSelected: (bool selected) {
                                          // Handle 'Others' selection
                                          Navigator.pop(context);
                                          //_tabController?.animateTo(2);
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          side: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                      ),*/
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: ChoiceChip(
                                        backgroundColor: Colors.grey.shade100,
                                        label: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 10,
                                              backgroundColor: Colors.black,
                                              backgroundImage:
                                                  CachedNetworkImageProvider(
                                                      'https://picsum.photos/seed/group3/150'),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Jojie Family',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color:
                                                    selectedCategory == 'Today'
                                                        ? Colors.white
                                                        : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        selected: selectedCategory == 'Today',
                                        selectedColor: Colors.black,
                                        showCheckmark: false,
                                        onSelected: (bool selected) {
                                          // Handle 'Others' selection
                                          print(selectedCategory);
                                          setState(() {
                                            selectedCategory = 'Today';
                                            if (isExpanded == isExpanded) {
                                              isExpanded = !isExpanded;
                                            }
                                          });
                                          //_tabController?.animateTo(2);
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          side: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: ChoiceChip(
                                        backgroundColor: Colors.grey.shade100,
                                        label: Text(
                                          'Pinned',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: selectedCategory == 'Pinned'
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        selected: selectedCategory == 'Pinned',
                                        selectedColor: Colors.black,
                                        showCheckmark: false,
                                        onSelected: (bool selected) {
                                          // Handle 'Others' selection
                                          print(selectedCategory);
                                          setState(() {
                                            selectedCategory = 'Pinned';
                                            if (isExpanded == isExpanded) {
                                              isExpanded = !isExpanded;
                                            }
                                          });
                                          //_tabController?.animateTo(2);
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          side: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: ChoiceChip(
                                        backgroundColor: Colors.grey.shade100,
                                        label: Text(
                                          'Events',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: selectedCategory == 'Events'
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        selected: selectedCategory == 'Events',
                                        selectedColor: Colors.black,
                                        showCheckmark: false,
                                        onSelected: (bool selected) {
                                          // Handle 'Others' selection
                                          print(selectedCategory);
                                          setState(() {
                                            selectedCategory = 'Events';
                                            isExpanded = !isExpanded;
                                          });
                                          //_tabController?.animateTo(2);
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          side: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: ChoiceChip(
                                        backgroundColor: Colors.grey.shade100,
                                        label: Text(
                                          'Polls',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: selectedCategory == 'Polls'
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        selected: selectedCategory == 'Polls',
                                        selectedColor: Colors.black,
                                        showCheckmark: false,
                                        onSelected: (bool selected) {
                                          // Handle 'Others' selection
                                          print(selectedCategory);
                                          setState(() {
                                            selectedCategory = 'Polls';
                                            isExpanded = !isExpanded;
                                          });
                                          //_tabController?.animateTo(2);
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          side: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: ChoiceChip(
                                        backgroundColor: Colors.grey.shade100,
                                        label: Text(
                                          'Stickers',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color:
                                                selectedCategory == 'Stickers'
                                                    ? Colors.white
                                                    : Colors.black,
                                          ),
                                        ),
                                        selected:
                                            selectedCategory == 'Stickers',
                                        selectedColor: Colors.black,
                                        showCheckmark: false,
                                        onSelected: (bool selected) {
                                          // Handle 'Others' selection
                                          print(selectedCategory);
                                          setState(() {
                                            selectedCategory = 'Stickers';
                                            isExpanded = !isExpanded;
                                          });
                                          //_tabController?.animateTo(2);
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          side: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0),
                                      child: ChoiceChip(
                                        backgroundColor: Colors.grey.shade100,
                                        label: Text(
                                          'Location',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color:
                                                selectedCategory == 'Location'
                                                    ? Colors.white
                                                    : Colors.black,
                                          ),
                                        ),
                                        selected:
                                            selectedCategory == 'Location',
                                        selectedColor: Colors.black,
                                        showCheckmark: false,
                                        onSelected: (bool selected) {
                                          // Handle 'Others' selection
                                          print(selectedCategory);
                                          setState(() {
                                            selectedCategory = 'Location';
                                            isExpanded = !isExpanded;
                                          });
                                          //_tabController?.animateTo(2);
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          side: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                      ),
                                    ),
                                  ]),
                            )),
                      ),
                      //: Container(),
                      // Stories List
                      isExpanded &&
                              _focus.hasFocus.toString() != 'true' &&
                              selectedCategory == 'Today'
                          ? Expanded(
                              child: Container(
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    totalStories, // Total number of stories to display
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap:
                                        markStoryAsSeen, // Mark story as seen on tap
                                    child: Container(
                                      padding: index == 0
                                          ? EdgeInsets.fromLTRB(23, 0, 5, 0)
                                          : index == totalStories - 1 ? EdgeInsets.fromLTRB(5, 0, 20, 0) :  EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      child: Container(
                                        width:
                                            120, // Fixed width for each story
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Story $index',
                                            style:
                                                TextStyle(color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ))
                          : /*Container(),
                      isExpanded &&
                              _focus.hasFocus.toString() != 'true' &&
                              selectedCategory == 'Today'
                          ? Expanded(
                              child: Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  height: 200,
                                  //width: MediaQuery.sizeOf(context).width,
                                  child: GroupPostsPage(
                                      profilepicture: widget.profilepicture,
                                      username: widget.username,
                                      userid: widget.userid)))
                          : */ Container(),

                      /*Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpanded =
                                  !isExpanded; // Toggle the expansion state
                            });
                          },
                          child: Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                              child: Card(
                                child: ListView.builder(
                                    controller:
                                        _messageScrollController, // Attach the scroll controller
                                    itemCount: 5, // Number of messages
                                    padding: EdgeInsets.all(8.0),
                                    reverse: true, // Start from the bottom
                                    itemBuilder: (context, index) {
                                      bool isMe = index % 2 ==
                                          0; // Alternate between user and other person
                                      return Align(
                                          alignment: isMe
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                          child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 15),
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              decoration: BoxDecoration(
                                                color: isMe
                                                    ? Colors.blue
                                                    : Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                isMe
                                                    ? 'My message $index'
                                                    : 'Their message $index',
                                                style: TextStyle(
                                                  color: isMe
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              )));
                                    }),
                              )),
                        ),
                      ),*/
                    ],
                  ),
                  //)
                ),

                // Bottom section: Messages (Taking up the remaining space)
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: ListView.builder(
                      controller:
                          _messageScrollController, // Attach the scroll controller
                      itemCount: 20, // Number of messages
                      padding: EdgeInsets.all(8.0),
                      reverse: true, // Start from the bottom
                      itemBuilder: (context, index) {
                        bool isMe = index % 2 ==
                            0; // Alternate between user and other person
                        return index != 0
                            ? Padding(
                                padding: isMe
                                    ? EdgeInsets.only(right: 10)
                                    : EdgeInsets.only(left: 10),
                                child: Align(
                                    alignment: isMe
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        decoration: BoxDecoration(
                                          color: isMe
                                              ? Colors.blue
                                              : Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          isMe
                                              ? 'My message $index'
                                              : 'Their message $index',
                                          style: TextStyle(
                                            color: isMe
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ))),
                              )
                            : Container(
                                height: _focus.hasFocus.toString() != 'true'
                                    ? 140
                                    : 200,
                                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                child: Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            child: TextField(
                                              focusNode: _focus,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              textInputAction:
                                                  TextInputAction.newline,
                                              maxLines: null,
                                              style: TextStyle(fontSize: 17),
                                              decoration: InputDecoration(
                                                hintStyle: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w300),
                                                hintText: "Say something...",
                                                //hintStyle: TextStyle(color: Colors.black),
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.all(10),
                                                iconColor: Colors.black,
                                                suffixIconColor: Colors.black,
                                              ),
                                              cursorHeight: 15,
                                            ),
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  icon: Icon(Icons.call),
                                                  onPressed: () {
                                                    // Call action
                                                  },
                                                ),
                                                // Video Call Icon
                                                IconButton(
                                                  icon: Icon(Icons.videocam),
                                                  onPressed: () {
                                                    // Video call action
                                                  },
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.mic),
                                                  onPressed: () {
                                                    // Video call action
                                                  },
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.image),
                                                  onPressed: () {
                                                    // Call action
                                                  },
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons
                                                      .file_present_rounded),
                                                  onPressed: () {
                                                    // Call action
                                                  },
                                                ),
                                                Spacer(),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 8, 0),
                                                  child: ChoiceChip(
                                                    label: Text('Send'),
                                                    selectedColor: Colors.black,
                                                    selected: false,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      side: BorderSide(
                                                          color: Colors
                                                              .transparent),
                                                    ),
                                                    backgroundColor:
                                                        Colors.amber,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 16,
                                                            vertical: 8),
                                                  ),
                                                )
                                              ],
                                            )),
                                      ],
                                    )),
                              );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          //bottomNavigationBar:
          /*Padding(
        padding: const EdgeInsets.fromLTRB(8, 10, 0, 40),
        child: Row(
          children: [
            // Call Icon
            IconButton(
              icon: Icon(Icons.call),
              onPressed: () {
                // Call action
              },
            ),
            // Video Call Icon
            IconButton(
              icon: Icon(Icons.videocam),
              onPressed: () {
                // Video call action
              },
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                ),
              ),
            ),
            SizedBox(width: 8.0),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: sendMessage, // Call sendMessage on press
            ),
          ],
        ),
      ),*/
        ));
  }
}
