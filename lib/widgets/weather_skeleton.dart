import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WeatherSkeleton extends StatelessWidget {
  const WeatherSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white.withOpacity(0.15),
      highlightColor: Colors.white.withOpacity(0.3),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            height: 160,
            width: 160,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 40,
            width: 100,
            color: Colors.white,
          ),
          const SizedBox(height: 12),
          Container(
            height: 20,
            width: 80,
            color: Colors.white,
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              3,
              (_) => Container(
                height: 40,
                width: 70,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            height: 90,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, __) => Container(
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
