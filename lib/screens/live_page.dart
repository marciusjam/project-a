import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

// Dummy data for live streams by category
Map<String, List<LiveStream>> categorizedStreams = {
  'Cooking': [
    LiveStream(
      title: 'Cooking Live 1',
      thumbnailUrl: 'https://via.placeholder.com/150',
      streamUrl: 'https://your-live-stream-url-1',
    ),
    LiveStream(
      title: 'Cooking Live 2',
      thumbnailUrl: 'https://via.placeholder.com/150',
      streamUrl: 'https://your-live-stream-url-2',
    ),
    LiveStream(
      title: 'Cooking Live 3',
      thumbnailUrl: 'https://via.placeholder.com/150',
      streamUrl: 'https://your-live-stream-url-1',
    ),
    LiveStream(
      title: 'Cooking Live 4',
      thumbnailUrl: 'https://via.placeholder.com/150',
      streamUrl: 'https://your-live-stream-url-2',
    ),
    LiveStream(
      title: 'Cooking Live 5',
      thumbnailUrl: 'https://via.placeholder.com/150',
      streamUrl: 'https://your-live-stream-url-1',
    ),
    LiveStream(
      title: 'Cooking Live 6',
      thumbnailUrl: 'https://via.placeholder.com/150',
      streamUrl: 'https://your-live-stream-url-2',
    ),
    LiveStream(
      title: 'Cooking Live 7',
      thumbnailUrl: 'https://via.placeholder.com/150',
      streamUrl: 'https://your-live-stream-url-1',
    ),
    LiveStream(
      title: 'Cooking Live 8',
      thumbnailUrl: 'https://via.placeholder.com/150',
      streamUrl: 'https://your-live-stream-url-2',
    ),
  ],
  'Gaming': [
    LiveStream(
      title: 'Gaming Live 1',
      thumbnailUrl: 'https://via.placeholder.com/150',
      streamUrl: 'https://your-live-stream-url-3',
    ),
    LiveStream(
      title: 'Gaming Live 2',
      thumbnailUrl: 'https://via.placeholder.com/150',
      streamUrl: 'https://your-live-stream-url-4',
    ),
    LiveStream(
      title: 'Gaming Live 3',
      thumbnailUrl: 'https://via.placeholder.com/150',
      streamUrl: 'https://your-live-stream-url-3',
    ),
    LiveStream(
      title: 'Gaming Live 4',
      thumbnailUrl: 'https://via.placeholder.com/150',
      streamUrl: 'https://your-live-stream-url-4',
    ),
    LiveStream(
      title: 'Gaming Live 5',
      thumbnailUrl: 'https://via.placeholder.com/150',
      streamUrl: 'https://your-live-stream-url-3',
    ),
    LiveStream(
      title: 'Gaming Live 6',
      thumbnailUrl: 'https://via.placeholder.com/150',
      streamUrl: 'https://your-live-stream-url-4',
    ),
    
  ],
  'Music': [
    LiveStream(
      title: 'Music Live 1',
      thumbnailUrl: 'https://via.placeholder.com/150',
      streamUrl: 'https://your-live-stream-url-5',
    ),
    LiveStream(
      title: 'Music Live 2',
      thumbnailUrl: 'https://via.placeholder.com/150',
      streamUrl: 'https://your-live-stream-url-6',
    ),
    LiveStream(
      title: 'Music Live 3',
      thumbnailUrl: 'https://via.placeholder.com/150',
      streamUrl: 'https://your-live-stream-url-6',
    ),
    LiveStream(
      title: 'Music Live 4',
      thumbnailUrl: 'https://via.placeholder.com/150',
      streamUrl: 'https://your-live-stream-url-6',
    ),
    LiveStream(
      title: 'Music Live 5',
      thumbnailUrl: 'https://via.placeholder.com/150',
      streamUrl: 'https://your-live-stream-url-6',
    ),
    LiveStream(
      title: 'Music Live 6',
      thumbnailUrl: 'https://via.placeholder.com/150',
      streamUrl: 'https://your-live-stream-url-6',
    ),
  ],
  'Art': [
    LiveStream(
      title: 'Art Live 1',
      thumbnailUrl: 'https://via.placeholder.com/150',
      streamUrl: 'https://your-live-stream-url-7',
    ),
    LiveStream(
      title: 'Art Live 2',
      thumbnailUrl: 'https://via.placeholder.com/150',
      streamUrl: 'https://your-live-stream-url-8',
    ),
    LiveStream(
      title: 'Art Live 3',
      thumbnailUrl: 'https://via.placeholder.com/150',
      streamUrl: 'https://your-live-stream-url-8',
    ),
    LiveStream(
      title: 'Art Live 4',
      thumbnailUrl: 'https://via.placeholder.com/150',
      streamUrl: 'https://your-live-stream-url-8',
    ),
    LiveStream(
      title: 'Art Live 5',
      thumbnailUrl: 'https://via.placeholder.com/150',
      streamUrl: 'https://your-live-stream-url-8',
    ),
  ],
};

class LivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,160,0,0),
      child: Column(
        children: categorizedStreams.entries.map((entry) {
          String category = entry.key;
          List<LiveStream> streams = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Title
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
                child: Text(
                  category,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              // Live Stream Row
              /*Container(
                height: 150, // Set a fixed height for the row list
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: streams.length,
                  itemBuilder: (context, index) {
                    final stream = streams[index];
                    return GestureDetector(
                      onTap: () {
                        // Handle stream tap
                        print('Tapped on ${stream.title}');
                        // You can navigate to a stream player page here
                      },
                      child: Container(
                        width: 150,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                stream.thumbnailUrl,
                                fit: BoxFit.cover,
                                height: 120,
                                width: 150,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              stream.title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            */],
          );
        }).toList(),
      ),
    );
  }
}

class LiveStream {
  final String title;
  final String thumbnailUrl;
  final String streamUrl;

  LiveStream({
    required this.title,
    required this.thumbnailUrl,
    required this.streamUrl,
  });
}