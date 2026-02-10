import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapiecommerce/features/products/domain/model/product.dart';
import 'package:flutterapiecommerce/features/products/presentation/cubits/carousel_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailPage extends StatefulWidget {
  final Product product;
  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ecommerce app api")),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: BlocBuilder<CarouselCubit, int>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                  widget.product.images.length == 1
                      ? CachedNetworkImage(
                        imageUrl: widget.product.images.first,

                        placeholder:
                            (context, url) =>
                                Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )
                      : CarouselSlider(
                        items:
                            widget.product.images.map((url) {
                              return Builder(
                                builder: (context) {
                                  return CachedNetworkImage(
                                    width: double.infinity,
                                    height: 500,
                                    imageUrl: url,
                                    placeholder:
                                        (context, url) => Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                    errorWidget:
                                        (context, url, error) =>
                                            Icon(Icons.error),
                                  );

                                  // Image.network(
                                  //   width: double.infinity,
                                  //   height: 500,
                                  //   url,
                                  // );
                                },
                              );
                            }).toList(),
                        options: CarouselOptions(
                          height: 250,
                          autoPlay: false,
                          //autoPlayInterval: Duration(seconds: 3),
                          onPageChanged: (index, reason) {
                            context.read<CarouselCubit>().changeIndicator(
                              index,
                            );
                          },
                        ),
                      ),

                  SizedBox(height: 12),
                  if (widget.product.images.length > 1)
                    Center(
                      child: AnimatedSmoothIndicator(
                        activeIndex: state,
                        count: widget.product.images.length,
                        effect: WormEffect(
                          spacing: 8.0,
                          dotWidth: 13,
                          dotHeight: 13,
                          activeDotColor: Colors.pink,
                          dotColor: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  SizedBox(height: 20),
                  Text(
                    widget.product.description * 200,
                    style: TextStyle(fontSize: 19, color: Colors.grey.shade700),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
