import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyGridContainer extends StatelessWidget {
  final String title;
  final String thumbnail;
  final String price;
  final String rating;
  const MyGridContainer({
    super.key,
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: CachedNetworkImage(
              height: 120,
              width: double.infinity,
              imageUrl: thumbnail,
              placeholder:
                  (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget:
                  (context, url, error) => Center(child: Icon(Icons.error)),
            ),
          ),

          SizedBox(height: 10),
          Text(
            overflow: TextOverflow.ellipsis,
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  SizedBox(width: 5),
                  Text(
                    rating,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
