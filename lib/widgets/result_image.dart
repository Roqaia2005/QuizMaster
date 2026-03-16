import 'package:flutter/material.dart';
import 'package:quiz_master/core/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultImage extends StatelessWidget {
  const ResultImage({super.key, this.isSuccess = true});

  final bool isSuccess;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              isSuccess
                  ? "assets/images/success.png"
                  : "assets/images/failure.png",
              fit: BoxFit.cover,
              width: 300.w,
              height: 300.h,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 200.w,
                  height: 200.h,
                  decoration: BoxDecoration(
                    color: isSuccess
                        ? Colors.green.shade100
                        : Colors.red.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    isSuccess ? Icons.check_circle : Icons.cancel,
                    size: 100.sp,
                    color: isSuccess ? Colors.green : Colors.red,
                  ),
                );
              },
            ),
          ),
        ),

        if (isSuccess) ...[
          Positioned(
            top: -12,
            right: -15,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.star, color: Colors.white, size: 25),
            ),
          ),

          Positioned(
            bottom: -6,
            left: -6,
            child: Icon(
              Icons.celebration,
              color: AppColors.primaryColor,
              size: 35,
            ),
          ),
        ] else ...[
          Positioned(
            top: -12,
            right: -15,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, color: Colors.white, size: 25),
            ),
          ),
        ],
      ],
    );
  }
}
