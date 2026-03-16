import 'package:flutter/material.dart';
import 'package:quiz_master/core/colors.dart';
import 'package:quiz_master/core/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Option extends StatefulWidget {
  const Option({
    super.key,
    required this.optionText,
    required this.isSelected,
    required this.isCorrect,
    this.onTap,
    required this.isLocked,
  });
  final String optionText;
  final bool isSelected;
  final bool isCorrect;
  final void Function()? onTap;
  final bool isLocked;

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Determine colors and label based on checked state
    Color backgroundColor = Colors.white;
    Color borderColor = AppColors.primaryColor.withValues(alpha: 0.3);
    Color textColor = Colors.black;
    String? labelText;
    Color labelColor = Colors.white;
    
    if (widget.isLocked) {
      // Answer has been checked
      if (widget.isCorrect) {
        // Correct answer - green
        backgroundColor = Colors.green.shade400;
        borderColor = Colors.green.shade600;
        textColor = Colors.white;
        labelText = "TRUE";
        labelColor = Colors.white;
      } else if (widget.isSelected) {
        // Selected but incorrect - red
        backgroundColor = Colors.red.shade400;
        borderColor = Colors.red.shade600;
        textColor = Colors.white;
        labelText = "FALSE";
        labelColor = Colors.white;
      } else {
        // Not selected and not correct - gray out
        backgroundColor = Colors.grey.shade200;
        borderColor = Colors.grey.shade400;
        textColor = Colors.grey.shade600;
      }
    } else {
      // Not checked yet - normal state
      if (widget.isSelected) {
        // Selected answer - highlight it
        backgroundColor = AppColors.primaryColor.withValues(alpha: 0.15);
        borderColor = AppColors.primaryColor;
        textColor = AppColors.primaryColor;
      } else if (_isHovered) {
        backgroundColor = AppColors.primaryColor.withValues(alpha: 0.05);
        borderColor = AppColors.primaryColor;
        textColor = AppColors.primaryColor;
      } else {
        backgroundColor = Colors.white;
        borderColor = AppColors.primaryColor.withValues(alpha: 0.3);
        textColor = Colors.black;
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      child: InkWell(
        onTap: widget.isLocked ? null : widget.onTap,
        child: MouseRegion(
          onEnter: widget.isLocked ? null : (_) => setState(() => _isHovered = true),
          onExit: widget.isLocked ? null : (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: _isHovered && !widget.isLocked ? 0.15 : 0.08,
                  ),
                  blurRadius: _isHovered && !widget.isLocked ? 12 : 8,
                  offset: Offset(0, _isHovered && !widget.isLocked ? 6 : 4),
                ),
              ],
              borderRadius: BorderRadius.circular(28.r),
              border: Border.all(
                color: borderColor,
                width: 2.w,
              ),
              color: backgroundColor,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.optionText,
                    style: TextStyles.font16SubtitleBold.copyWith(
                      color: textColor,
                    ),
                  ),
                ),
                if (labelText != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: labelText == "TRUE" 
                          ? Colors.green.shade700 
                          : Colors.red.shade700,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      labelText,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: labelColor,
                        fontWeight: FontWeight.bold,
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
