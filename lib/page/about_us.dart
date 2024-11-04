import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  List<String> names = ["John", "Sarah", "Michael", "Emily", "David", "Alice"];
  List<String> additionalInfo = [
    "Spesialis dalam pengembangan perangkat lunak dengan fokus pada aplikasi web. Memiliki keahlian dalam bahasa pemrograman seperti JavaScript, Python, dan Ruby on Rails.",
    "Ahli dalam analisis data dan kecerdasan buatan. Berpengalaman dalam menggunakan algoritma machine learning untuk memecahkan masalah kompleks dalam berbagai industri.",
    "Pakar keamanan cyber dengan pemahaman mendalam tentang serangan siber dan teknik pertahanan. Berdedikasi untuk menjaga keamanan data dan sistem informasi.",
    "Ahli jaringan komputer dengan pengalaman dalam merancang dan mengelola infrastruktur TI skala besar. Mengutamakan kinerja dan kehandalan dalam setiap implementasi.",
    "Spesialis UX/UI dengan fokus pada pengalaman pengguna yang intuitif dan menarik. Memiliki keahlian dalam desain antarmuka untuk aplikasi web dan mobile.",
    "Pengembang permainan dan aplikasi multimedia dengan visi kreatif yang unik. Menggabungkan teknologi informatika dengan seni untuk menciptakan pengalaman yang menarik."
  ];

  final List<String> avatarImages = [
    '../assets/jhon.jpeg',
    '../assets/sarah.jpeg',
    '../assets/michael.jpeg',
    '../assets/emily.jpeg',
    '../assets/david.jpeg',
    '../assets/alice.jpeg',
  ];

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late List<GlobalKey<_ListItemState>> _itemKeys;

  @override
  void initState() {
    super.initState();
    _itemKeys = List.generate(names.length, (_) => GlobalKey<_ListItemState>());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAnimations();
    });
  }

  void _startAnimations() async {
    for (int i = 0; i < names.length; i++) {
      await Future.delayed(const Duration(milliseconds: 300));
      _listKey.currentState!.insertItem(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: const Text(
          "About Us",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey, Colors.pink],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: AnimatedList(
          key: _listKey,
          initialItemCount: 0,
          itemBuilder: (context, index, animation) {
            return _buildListItem(names[index], additionalInfo[index],
                avatarImages[index], animation, index);
          },
        ),
      ),
    );
  }

  Widget _buildListItem(String name, String info, String avatarImage,
      Animation<double> animation, int index) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return SizeTransition(
          sizeFactor: animation,
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: _ListItem(
          key: _itemKeys[index],
          name: name,
          additionalInfo: info,
          avatarImage: avatarImage,
        ),
      ),
    );
  }
}

class _ListItem extends StatefulWidget {
  final String name;
  final String additionalInfo;
  final String avatarImage;

  const _ListItem({
    super.key,
    required this.name,
    required this.additionalInfo,
    required this.avatarImage,
  });

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<_ListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(widget.avatarImage),
                ),
                const SizedBox(width: 16),
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 16,
            endIndent: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.additionalInfo,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
