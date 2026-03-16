import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:quiz_master/core/extensions.dart';
import 'package:quiz_master/core/routes.dart';
import 'package:quiz_master/core/spacing.dart';
import 'package:quiz_master/core/colors.dart';
import 'package:quiz_master/core/text_styles.dart';
import 'package:quiz_master/data/question.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category});

  final Category category;
  
  @override
  Widget build(BuildContext context) {
    final questionCount = category.questions.length;
    
    return InkWell(
      onTap: () {
        context.pushNamed(Routes.quiz, arguments: category);
      },
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryColor.withValues(alpha: 0.1),
              AppColors.secondaryColor,
            ],
          ),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: AppColors.primaryColor.withValues(alpha: 0.2),
            width: 1.5.w,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SVG Icon with background circle
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                category.iconPath,
                width: 40.w,
                height: 40.h,
                colorFilter: ColorFilter.mode(
                  AppColors.primaryColor,
                  BlendMode.srcIn,
                ),
                placeholderBuilder: (context) => Icon(
                  FontAwesomeIcons.folder,
                  size: 40.sp,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            verticalSpace(12),
            // Category Name
            Text(
              category.name,
              style: TextStyles.font16TitleBold,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            verticalSpace(8),
            // Question Count
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    FontAwesomeIcons.circleQuestion,
                    size: 12.sp,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    '$questionCount ${questionCount == 1 ? 'Question' : 'Questions'}',
                    style: TextStyles.font12PrimarySemiBold,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
