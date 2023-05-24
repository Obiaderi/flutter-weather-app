import 'package:flutter/material.dart';
import 'package:weather_app/core/contants/color.dart';

class WeatherItemWidget extends StatelessWidget {
  const WeatherItemWidget(
      {super.key,
      required this.imageUrl,
      required this.label,
      required this.value,
      this.c1,
      this.c2});

  final String imageUrl;
  final String label;
  final String value;
  final Color? c1;
  final Color? c2;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        width: 160,
        height: 180,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                width: 136,
                height: 160,
                decoration: BoxDecoration(
                  color: c1 != null
                      ? c1!.withOpacity(0.10)
                      : AppColor.blue.withOpacity(0.10),
                  // borderRadius:
                  //     BorderRadius.circular(16.r)
                ),
              ),
            ),
            Positioned(
              right: -20,
              top: -15,
              child: Container(
                width: 107,
                height: 107,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: c1 != null
                      ? c1!.withOpacity(0.10)
                      : AppColor.blue.withOpacity(0.10),
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  imageUrl,
                  width: 45,
                  height: 45,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
                bottom: 8,
                left: 12,
                right: 12,
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        value,
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: AppColor.black),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        label,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 13,
                            color: AppColor.dipBlack,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
