import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class StoriesAndMessagesPage extends StatefulWidget {
  @override
  _StoriesAndMessagesPageState createState() => _StoriesAndMessagesPageState();
}

class _StoriesAndMessagesPageState extends State<StoriesAndMessagesPage> {
  bool isExpanded = true; // State to track if the stories section is expanded
  int totalStories = 10; // Total number of stories
  int seenStories = 0; // Number of seen stories
  TextEditingController messageController = TextEditingController(); // Controller for message input
  List<String> messages = []; // List to store messages

  // ScrollController for messages
  final ScrollController _messageScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Listen to scroll events
    _messageScrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
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
    if (_messageScrollController.position.userScrollDirection == ScrollDirection.reverse) {
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
      appBar: AppBar(surfaceTintColor: Colors.black,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.transparent,
                        //statusBarColor: Colors.black,
                        statusBarIconBrightness: 
                            Brightness.light,
                        statusBarBrightness: Brightness.dark
                      ),
                      
                      toolbarHeight: 0,
                      backgroundColor: Colors.black),
      body: Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Column(
        children: [
          // Top section: Stories (Expandable)
          AnimatedContainer(
            duration: Duration(milliseconds: 300), // Animation duration
            height: isExpanded ? MediaQuery.of(context).size.height / 3 : 80, // Conditional height
            padding: EdgeInsets.symmetric(vertical: 8.0),
            color: Colors.black, // Background color for the stories section
            child: Column(
              children: [
                // Title with counter
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close_rounded),
                        onPressed: (){
                          Navigator.pop(context, true);
                        }
                      ),
                      Text('Family', style: TextStyle(fontSize: 20, color: Colors.white),),
                      IconButton(
                        icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
                        onPressed: toggleStories,
                        tooltip: isExpanded ? 'Collapse Stories' : 'Expand Stories',
                      ),
                    ],
                  ),
                ),
                // Stories List
                isExpanded ? 
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: totalStories, // Total number of stories to display
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: markStoryAsSeen, // Mark story as seen on tap
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            width: 120, // Fixed width for each story
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                'Story $index',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ) : Container()
              ],
            ),
          ),

          // Bottom section: Messages (Taking up the remaining space)
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: ListView.builder(
                controller: _messageScrollController, // Attach the scroll controller
                itemCount: 15, // Number of messages
                padding: EdgeInsets.all(8.0),
                reverse: true, // Start from the bottom
                itemBuilder: (context, index) {
                  bool isMe = index % 2 == 0; // Alternate between user and other person
                  return Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.blue : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        isMe ? 'My message $index' : 'Their message $index',
                        style: TextStyle(
                          color: isMe ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          
        ],
      ),
      
      ), 
      bottomNavigationBar: Padding(
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
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
      ),
    );
  }
}