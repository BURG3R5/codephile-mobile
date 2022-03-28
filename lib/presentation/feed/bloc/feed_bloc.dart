import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/feed.dart';
import '../../../domain/models/grouped_feed.dart';
import '../../../domain/repositories/cp_repository.dart';

part 'feed_bloc.freezed.dart';
part 'feed_state.dart';
part 'feed_event.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc() : super(const FeedState()) {
    on<FeedFetch>(_onFeedFetch);
  }

  void _onFeedFetch(FeedFetch event, Emitter<FeedState> emit) async {
    feeds = await CPRepository.getFeed() ?? <Feed>[];
    for (final feed in feeds) {
      final groupFeed = groupedFeeds.firstWhere(
        (element) => element.name == feed.submission?.name,
        orElse: () {
          groupedFeeds.add(feed.toGroupedFeed());
          return groupedFeeds.last;
        },
      );
      groupFeed.submissions!.add(
        Submissions(
          createdAt: feed.submission?.createdAt,
          status: feed.submission?.status,
          points: feed.submission?.points,
          tags: feed.submission?.tags,
          rating: feed.submission?.rating,
        ),
      );
    }
    emit(
      state.copyWith(
        isLoading: false,
        feeds: groupedFeeds,
      ),
    );
  }

  List<Feed> feeds = <Feed>[];
  List<GroupedFeed> groupedFeeds = <GroupedFeed>[];
}

extension on Feed {
  GroupedFeed toGroupedFeed() {
    return GroupedFeed(
      username: username,
      userId: userId,
      fullname: fullname,
      picture: picture,
      name: submission?.name,
      url: submission?.url,
      language: submission?.language,
      submissions: [],
    );
  }
}
