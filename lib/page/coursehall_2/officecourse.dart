import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class OfficeCourse extends StatefulWidget {
  const OfficeCourse({super.key});

  @override
  _OfficeCourse createState() => _OfficeCourse();
}

class _OfficeCourse extends State {
  final String downloadLink = "https://UPPSKILL.com";

  void _shareLink() async {
    try {
      String message = 'Download our app using this link: $downloadLink';
      await Share.share(message);
    } catch (error) {
      print('Error sharing link: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sharing link: $error')),
      );
    }
  }

  void _copyLink() {
    Clipboard.setData(ClipboardData(text: downloadLink));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Download link copied to clipboard!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.grey,
        title:
            const Text('Office Course', style: TextStyle(color: Colors.white)),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              switch (result) {
                case 'Copy Link':
                  _copyLink();
                  break;
                case 'Share Link':
                  _shareLink();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Copy Link',
                child: ListTile(
                  leading: Icon(Icons.copy),
                  title: Text('Copy Link'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Share Link',
                child: ListTile(
                  leading: Icon(Icons.share),
                  title: Text('Share Link'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YoutubePlayerWidget(
                  'https://www.youtube.com/watch?v=s8Fu0i1Q3rQ'),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EpisodeListItem(
                    title: 'Episode 1: Pembahasan Kimia Organik',
                    url: 'https://www.youtube.com/watch?v=s8Fu0i1Q3rQ',
                  ),
                  Divider(),
                  EpisodeListItem(
                    title: 'Episode 2: Hidrokarbon dan Alkana',
                    url: 'https://www.youtube.com/watch?v=5vvbkdTD6Jg',
                  ),
                  Divider(),
                  EpisodeListItem(
                    title: 'Episode 3: alkana,alkena,alkuna',
                    url: 'https://www.youtube.com/watch?v=D8y8-iejawc',
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'User Reviews   (653)',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              UserReview(
                username: 'John Doe',
                rating: 4,
                review: 'Thanks Bud, very useful!',
              ),
              UserReview(
                username: 'Alice Smith',
                rating: 5,
                review: 'Excellent experience, highly recommend!',
              ),
              UserReview(
                username: 'Bob Johnson',
                rating: 3,
                review: 'This is so cool, maybe could use some improvements.',
              ),
              SizedBox(height: 20),
              Text(
                'Write your review:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              ReviewTextBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class EpisodeListItem extends StatelessWidget {
  final String title;
  final String url;

  const EpisodeListItem({
    super.key,
    required this.title,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 20),
      ),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => YoutubePlayerWidget(url)),
          );
        },
        child: const Text('Watch Now',
            style: TextStyle(fontSize: 12, color: Colors.white)),
      ),
    );
  }
}

class UserReview extends StatelessWidget {
  final String username;
  final int rating;
  final String review;

  const UserReview({
    super.key,
    required this.username,
    required this.rating,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                child: Icon(Icons.person),
              ),
              const SizedBox(width: 10),
              Text(
                username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: Colors.yellow,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(review),
        ],
      ),
    );
  }
}

class ReviewTextBox extends StatefulWidget {
  const ReviewTextBox({super.key});

  @override
  _ReviewTextBoxState createState() => _ReviewTextBoxState();
}

class _ReviewTextBoxState extends State<ReviewTextBox> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _controller,
          maxLines: 5,
          decoration: const InputDecoration(
            hintText: 'Write your review here...',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          onPressed: () {
            String review = _controller.text.trim();
            if (review.isNotEmpty) {
              print('Review submitted: $review');
              _controller.clear();
            } else {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Error'),
                  content:
                      const Text('Please write your review before submitting.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            }
          },
          child: const Text('Submit Review',
              style: TextStyle(fontSize: 14, color: Colors.white)),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class YoutubePlayerWidget extends StatelessWidget {
  final String url;

  const YoutubePlayerWidget(this.url, {super.key});

  @override
  Widget build(BuildContext context) {
    final videoId = YoutubePlayer.convertUrlToId(url);

    if (videoId == null) {
      return const Text('Invalid YouTube URL');
    }

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ),
        ),
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) {
        return Column(
          children: [
            player,
          ],
        );
      },
    );
  }
}
