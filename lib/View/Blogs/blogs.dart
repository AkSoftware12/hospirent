import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class Blog {
  final String title;
  final String imageUrl;
  final DateTime date;
  final String description;

  Blog({
    required this.title,
    required this.imageUrl,
    required this.date,
    required this.description,
  });
}

class BlogsScreen extends StatefulWidget {
  const BlogsScreen({super.key});

  @override
  _BlogsScreenState createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final List<Blog> blogs = [
    Blog(
      title: "Top 5 Essential Medical Equipment Every Home Should Have!",
      imageUrl: "https://hospirent.in/public//storage/photos/blogs/Why%20Home-Based.png",
      date: DateTime(2025, 5, 20),
      description: "A deep dive into AI advancements.",
    ),
    Blog(
      title: "A Comprehensive Guide to Using Oxygen concentrator in Healthcare",
      imageUrl: "https://hospirent.in/public//storage/photos/blogs/3%20jan%20hospirent%201.png",
      date: DateTime(2025, 5, 18),
      description: "Best practices for Flutter apps.",
    ),
    Blog(
      title: "Choosing the Right Wheelchair: A Comprehensive Guide",
      imageUrl: "https://hospirent.in/public//storage/photos/blogs/4jan%20hospirent%20.png",
      date: DateTime(2025, 5, 15),
      description: "Creating smooth UI animations.",
    ),
    Blog(
      title: "Why Home-Based Medical Services are on the Rise",
      imageUrl: "https://hospirent.in/public//storage/photos/blogs/3%20jan%20wabsite.png",
      date: DateTime(2025, 5, 15),
      description: "Creating smooth UI animations.",
    ),
    Blog(
      title: "Top 5 Essential Medical Equipment Every Home Should Have!",
      imageUrl: "https://hospirent.in/public//storage/photos/blogs/Why%20Home-Based.png",
      date: DateTime(2025, 5, 20),
      description: "A deep dive into AI advancements.",
    ),
    Blog(
      title: "A Comprehensive Guide to Using Oxygen concentrator in Healthcare",
      imageUrl: "https://hospirent.in/public//storage/photos/blogs/3%20jan%20hospirent%201.png",
      date: DateTime(2025, 5, 18),
      description: "Best practices for Flutter apps.",
    ),
    Blog(
      title: "Choosing the Right Wheelchair: A Comprehensive Guide",
      imageUrl: "https://hospirent.in/public//storage/photos/blogs/4jan%20hospirent%20.png",
      date: DateTime(2025, 5, 15),
      description: "Creating smooth UI animations.",
    ),
    Blog(
      title: "Why Home-Based Medical Services are on the Rise",
      imageUrl: "https://hospirent.in/public//storage/photos/blogs/3%20jan%20wabsite.png",
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
      backgroundColor: AppColors.backgroud, // Ensure AppColors.background is defined
      body: SingleChildScrollView(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: GridView.builder(
            shrinkWrap: true, // Makes GridView take only the space it needs
            physics: const NeverScrollableScrollPhysics(), // Disable GridView scrolling
            padding: EdgeInsets.all(3.sp),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.sp, // Maximum width for each item
              crossAxisSpacing: 0.sp,
              mainAxisSpacing: 0.sp,
              mainAxisExtent: 200.sp, // Explicit height for each grid item
            ),
            itemCount: blogs.length,
            itemBuilder: (context, index) {
              return BlogCard(blog: blogs[index], index: index);
            },
          ),
        ),
      ),
    );
  }
}

class BlogCard extends StatefulWidget {
  final Blog blog;
  final int index;

  const BlogCard({super.key, required this.blog, required this.index});

  @override
  _BlogCardState createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> with SingleTickerProviderStateMixin {
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
        child: Card(
          elevation: 6,
          color: AppColors.backgroud, // Ensure AppColors.background is defined
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: InkWell(
            onTap: () {
              // Navigate to blog details or handle tap
            },
            borderRadius: BorderRadius.circular(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(5.0)),
                  child: CachedNetworkImage(
                    imageUrl: widget.blog.imageUrl,
                    height: 120.sp,
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
                    padding: EdgeInsets.all(8.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.blog.title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.sp),
                        Text(
                          DateFormat('MMM dd, yyyy').format(widget.blog.date),
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
    );
  }
}