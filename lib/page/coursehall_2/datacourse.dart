import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DataCourse extends StatefulWidget {
  const DataCourse({super.key});

  @override
  _DataCourseState createState() => _DataCourseState();
}

class _DataCourseState extends State {
  final String downloadLink = "https://UPPSKILL.com";

  void _shareLink() async {
    try {
      String message = 'Download our app using this link: $downloadLink';
      await Share.share(message);
    } catch (error) {
      log('Error sharing link: $error');
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
        title: const Text('Data Analysis Course',
            style: TextStyle(color: Colors.white)),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const YoutubePlayerWidget(
                  'https://www.youtube.com/watch?v=CaqJ65CIoMw'),
              const SizedBox(height: 20),
              EpisodeListItem(
                episodeTitle: 'Episode 1: Bilangan Real,Estimasi,Logika',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const YoutubePlayerWidget(
                              'https://youtu.be/4lgPiAITfuk?si=0FRt7NuQVtXuZ960')));
                },
              ),
              EpisodeListItem(
                episodeTitle: 'Episode 2: Pertidaksamaan dan Nilai Mutlak',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const YoutubePlayerWidget(
                              'https://youtu.be/amI0Xqav9gA?si=LXEHmYq_GwojiMjh')));
                },
              ),
              EpisodeListItem(
                episodeTitle: 'Episode 3: Sistem Koordinat Kartesian',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const YoutubePlayerWidget(
                              'https://youtu.be/CtDy2IZL1Go?si=-J40gbxI5PGRCWDX')));
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'User Reviews   (237)',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const UserReview(
                username: 'John Doe',
                rating: 4,
                review: 'Thanks Bud, very useful!',
              ),
              const UserReview(
                username: 'Alice Smith',
                rating: 5,
                review: 'Excellent experience, highly recommend!',
              ),
              const UserReview(
                username: 'Bob Johnson',
                rating: 3,
                review: 'This is so cool, maybe could use some improvements.',
              ),
              const SizedBox(height: 20),
              const Text(
                'Write your review:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const ReviewTextBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class EpisodeListItem extends StatelessWidget {
  final String episodeTitle;
  final VoidCallback onPressed;

  const EpisodeListItem({
    super.key,
    required this.episodeTitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const Icon(Icons.play_arrow),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                episodeTitle,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
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
                style: const TextStyle(fontWeight: FontWeight.bold),
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
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            String review = _controller.text;
            log('Review submitted: $review');
            _controller.clear();
          },
          child: const Text('Submit Review',
              style: TextStyle(color: Colors.white)),
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
