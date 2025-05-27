import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hospirent/View/Videos/video.dart';
import 'package:hospirent/constants.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';




class Video {
  final String title;
  final String imageUrl;
  final DateTime date;
  final String description;

  Video({
    required this.title,
    required this.imageUrl,
    required this.date,
    required this.description,
  });
}

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final List<Video> videos = [
    Video(
      title: "Medical Service at Home",
      imageUrl: "https://hospirent.in/public//storage/photos/videos/hospirent%20thmbnail.png",
      date: DateTime(2025, 5, 20),
      description: "A deep dive into AI advancements.",
    ),
    Video(
      title: "Home Medical Equipment Setup",
      imageUrl: "https://hospirent.in/public//storage/photos/videos/WhatsApp%20Image%202023-10-27%20at%2019.38.45.jpeg",
      date: DateTime(2025, 5, 18),
      description: "Best practices for Flutter apps.",
    ),
    Video(
      title: "Nursing Staff for Patient Homecare",
      imageUrl: "https://hospirent.in/public//storage/photos/videos/Nursing%20Staff%20for%20Patient%20Homecare.png",
      date: DateTime(2025, 5, 15),
      description: "Creating smooth UI animations.",
    ),
    Video(
      title: "Rental Hospital Equipment",
      imageUrl: "https://hospirent.in/public//storage/photos/videos/5%20jan.png",
      date: DateTime(2025, 5, 15),
      description: "Creating smooth UI animations.",
    ),
    Video(
      title: "Medical Equipment Supplier in Dehradun",
      imageUrl: "https://hospirent.in/public//storage/photos/videos/ytVideo1Img.png",
      date: DateTime(2025, 5, 15),
      description: "Creating smooth UI animations.",
    ),
    Video(
      title: "Medical Service at Home",
      imageUrl: "https://hospirent.in/public//storage/photos/videos/hospirent%20thmbnail.png",
      date: DateTime(2025, 5, 20),
      description: "A deep dive into AI advancements.",
    ),
    Video(
      title: "Home Medical Equipment Setup",
      imageUrl: "https://hospirent.in/public//storage/photos/videos/WhatsApp%20Image%202023-10-27%20at%2019.38.45.jpeg",
      date: DateTime(2025, 5, 18),
      description: "Best practices for Flutter apps.",
    ),
    Video(
      title: "Nursing Staff for Patient Homecare",
      imageUrl: "https://hospirent.in/public//storage/photos/videos/Nursing%20Staff%20for%20Patient%20Homecare.png",
      date: DateTime(2025, 5, 15),
      description: "Creating smooth UI animations.",
    ),
    Video(
      title: "Rental Hospital Equipment",
      imageUrl: "https://hospirent.in/public//storage/photos/videos/5%20jan.png",
      date: DateTime(2025, 5, 15),
      description: "Creating smooth UI animations.",
    ),
    Video(
      title: "Medical Equipment Supplier in Dehradun",
      imageUrl: "https://hospirent.in/public//storage/photos/videos/ytVideo1Img.png",
      date: DateTime(2025, 5, 15),
      description: "Creating smooth UI animations.",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroud,
      body: SingleChildScrollView(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: GridView.builder(
            shrinkWrap: true, // Makes GridView take only the space it needs
            physics:  NeverScrollableScrollPhysics(), // Disable GridView scrolling
            padding: EdgeInsets.all(3.sp),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.sp, // Maximum width for each item
              crossAxisSpacing: 0.sp,
              mainAxisSpacing: 0.sp,
              mainAxisExtent: 200.sp, // Explicit height for each grid item
            ),
            itemCount: videos.length,
            itemBuilder: (context, index) {
              return VideoCard(video: videos[index], index: index);
            },
          ),
        ),
      ),
    );
  }
}


class VideoCard extends StatefulWidget {
  final Video video;
  final int index;

  const VideoCard({super.key, required this.video, required this.index});

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 800 + (widget.index * 200)),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Padding(
          padding: EdgeInsets.all(0.sp),
          child: Card(
            elevation: 6,
            color: AppColors.backgroud,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: InkWell(
              onTap: () {
                // Navigate to Video details or handle tap
              },
              borderRadius: BorderRadius.circular(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(5.0)),
                    child: CachedNetworkImage(
                      imageUrl: widget.video.imageUrl,
                      height: 120.sp, // Reduced height
                      width: double.infinity,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Container(
                        height: 120.sp,
                        color: Colors.grey[300],
                        child: Center(
                          child: CupertinoActivityIndicator(radius: 20, color: AppColors.primary),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 120.sp,
                        color: Colors.grey[300],
                        child: const Icon(Icons.error, color: Colors.red),
                      ),
                      memCacheHeight: 200,
                      memCacheWidth: (MediaQuery.of(context).size.width * 0.8).toInt(),
                      fadeInDuration: const Duration(milliseconds: 300),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(6.sp), // Reduced padding
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.video.title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 2.sp), // Reduced spacing
                          Text(
                            DateFormat('MMM dd, yyyy').format(widget.video.date),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}