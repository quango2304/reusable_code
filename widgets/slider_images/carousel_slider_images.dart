import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_resume/constants/app_colors.dart';
import 'package:my_resume/widgets/dot_indicator/dot_decorator.dart';
import 'package:my_resume/widgets/dot_indicator/dot_indicator.dart';


class CarouselBanner extends StatefulWidget {
  final List<String> images;
  final double indicatorBottomMargin;

  CarouselBanner({Key? key, required this.images, this.indicatorBottomMargin = 8}) : super(key: key);

  @override
  _CarouselBannerState createState() => _CarouselBannerState();
}

class _CarouselBannerState extends State<CarouselBanner> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider.builder(
          itemCount: widget.images.length,
          itemBuilder: (BuildContext context, int itemIndex, _) {
            return Image.asset(
              widget.images[itemIndex],
              fit: BoxFit.cover,
            );
          },
          options: CarouselOptions(
              height: 273.0,
              viewportFraction: 1,
              autoPlay: true,
              onPageChanged: (index, _) {
                setState(() {
                  currentIndex = index;
                });
              }),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: widget.indicatorBottomMargin),
          child: DotsIndicator(
            dotsCount: widget.images.length,
            position: currentIndex.toDouble(),
            decorator: DotsDecorator(
              size: const Size.square(8.0),
              activeSize: const Size(27.0, 8.0),
              activeColor: AppColors.cFFFFFF,
              color: AppColors.cCACACA,
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)),
            ),
          ),
        )
      ],
    );
  }
}
