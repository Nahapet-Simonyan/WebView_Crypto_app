import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:bin7r4decl/core/constants/colors.dart';
import 'package:bin7r4decl/core/utils/date_utils.dart';
import 'package:bin7r4decl/features/news/view/pages/news_details_screen.dart';

import '../../data/models/news_model.dart';
import '../manager/data_bloc/news_bloc.dart';
import '../manager/data_bloc/news_state.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is NewsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is NewsError) {
          return Center(child: Text(state.error.toString()));
        }
        if (state is NewsDone) {
          return _NewsBody(state: state);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class _NewsBody extends StatelessWidget {
  const _NewsBody({required this.state});

  final NewsState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.builder(
      itemCount: state.news?.length,
      itemBuilder: (context, index) {
        NewsModel news = state.news![index];
        DateTime parsedDate = DateFormat("dd.MM.yyyy HH:mm:ss").parse(
          news.resultDateTime,
        );
        String formattedDifferenceDate = getDateDifference(parsedDate);

        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsDetailsScreen(
                news: state.news![index],
              ),
            ),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Container(
              color: theme.cardColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Column(
                            children: [
                              Text(
                                news.resultTitle,
                                style: theme.textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                news.resultText,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: AppColors.gray3,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: Image.network(
                            news.resultImage,
                            width: 129,
                            height: 129,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
