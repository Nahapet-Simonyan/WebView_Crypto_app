import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bin7r4decl/core/utils/date_utils.dart';

import '../../../../core/constants/colors.dart';
import '../../data/models/news_model.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({super.key, required this.news});

  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    DateTime parsedDate = DateFormat("dd.MM.yyyy HH:mm:ss").parse(
      news.resultDateTime,
    );
    String formattedDifferenceDate = getDateDifference(parsedDate);
    String formattedNewsText = news.resultText
        .replaceAll(
          "\n\n        \n\n                    \n        \n        \n                    \n",
          "\n \n",
        )
        .replaceAll(RegExp(r'\n+'), '\n');

    final bool canPop = Navigator.canPop(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 230,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(news.resultImage),
                  fit: BoxFit.cover,
                ),
              ),
              child: AppBar(
                automaticallyImplyLeading: false,
                leading: canPop
                    ? InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(50.0),
                        child: const Icon(Icons.arrow_back_ios_new),
                      )
                    : const SizedBox(),
                backgroundColor: Colors.transparent,
                foregroundColor: AppColors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Text(
                formattedDifferenceDate,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.gray3,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    news.resultTitle,
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    formattedNewsText,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.gray3,
                    ),
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
