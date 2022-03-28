import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/constants/assets.dart';
import '../../data/constants/colors.dart';
import '../components/widgets/empty_state.dart';
import '../contests/widgets/loading_state.dart';
import 'bloc/feed_bloc.dart';
import 'widgets/feed_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedBloc()..add(const FeedFetch()),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.white,
          title: Text(
            'Feed',
            style: Theme.of(context).textTheme.headline4?.copyWith(
                  fontSize: 22.sp,
                ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                AppAssets.refresh,
                width: 24.r,
                height: 24.r,
              ),
            ),
          ],
        ),
        body: BlocBuilder<FeedBloc, FeedState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const LoadingState();
            }

            if (state.feeds.isEmpty) {
              return const EmptyState(
                description: 'Feed looks empty, search and follow'
                    ' some people to see their updates',
              );
            }

            return Stack(
              children: <Widget>[
                ListView.builder(
                  // controller: _scrollController,
                  itemCount: state.feeds.length,
                  itemBuilder: (context, index) {
                    return FeedCard(
                      feed: state.feeds[index],
                    );
                  },
                ),
                const Visibility(
                  visible: false,
                  child: Positioned(
                    bottom: 0,
                    child: SizedBox(
                      height: 80,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
