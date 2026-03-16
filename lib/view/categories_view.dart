import 'package:flutter/material.dart';
import 'package:quiz_master/core/colors.dart';
import 'package:quiz_master/core/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_master/data/question.dart';
import 'package:quiz_master/widgets/categories_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key, required this.categories});

  final List<Category> categories;

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  final TextEditingController _searchController = TextEditingController();
  List<Category> _filteredCategories = [];

  @override
  void initState() {
    super.initState();
    _filteredCategories = widget.categories;
    _searchController.addListener(_filterCategories);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCategories() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      if (query.isEmpty) {
        _filteredCategories = widget.categories;
      } else {
        _filteredCategories = widget.categories
            .where((category) =>
                category.name.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: AppColors.primaryColor),
        centerTitle: true,
        title: Text("Choose a Category", style: TextStyles.font18TitleBold),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SearchBar(
                controller: _searchController,
                padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                ),
                overlayColor: WidgetStatePropertyAll(AppColors.secondaryColor),
                leading: Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: AppColors.primaryColor,
                  size: 16.sp,
                ),
                trailing: _searchController.text.isNotEmpty
                    ? [
                        IconButton(
                          icon: Icon(
                            FontAwesomeIcons.xmark,
                            size: 14.sp,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: () {
                            _searchController.clear();
                          },
                        ),
                      ]
                    : null,
                backgroundColor: WidgetStatePropertyAll(Colors.white),
                hintText: "Search categories...",
                hintStyle: WidgetStateProperty.all(
                  TextStyles.font14SubtitleSemiBold,
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    side: BorderSide(
                      color: AppColors.primaryColor.withValues(alpha: 0.3),
                      width: 1.5.w,
                    ),
                  ),
                ),
              ),
            ),
            if (_filteredCategories.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        size: 48.sp,
                        color: AppColors.subtitleTextColor,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'No categories found',
                        style: TextStyles.font18SubtitleBold,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Try a different search term',
                        style: TextStyles.font14SubtitleSemiBold,
                      ),
                    ],
                  ),
                ),
              )
            else
              CategoriesGridView(categories: _filteredCategories),
          ],
        ),
      ),
    );
  }
}
