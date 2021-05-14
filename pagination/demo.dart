//controller

class NotificationsCubit extends Cubit<NotificationsState>
    with PaginationHelper<AppNotification> {
  NotificationsCubit() : super(NotificationsInitial());

  Future<void> getNotifications() async {
    emit(GetNotificationsLoading());
    try {
      await Future.delayed(Duration(seconds: 2)); //call api here
      final listFromApi = List.generate(
          limit,
          (index) => AppNotification(
              title: 'this is title',
              subtitle: 'this is subtitle',
              leadImage:
                  'https://interactive-examples.mdn.mozilla.net/media/cc0-images/grapefruit-slice-332-332.jpg',
              trailImage:
                  'https://interactive-examples.mdn.mozilla.net/media/cc0-images/grapefruit-slice-332-332.jpg'));

      items.addAll(listFromApi);
      emit(GetNotificationsSuccess());
    } catch (e) {
      emit(GetNotificationsFailure());
    }
  }

  @override
  bool get canLoadMore => true;

  @override
  bool get isLoading => state is GetNotificationsLoading;

  @override
  int get limit => 15;

  @override
  Future<void> loadMore() async {
    await getNotifications();
  }

  @override
  Future<void> refresh() async {
    reset();
    await getNotifications();
  }

  @override
  void reset() {
    items = [];
    //reset current page
  }
}

//ui
   return PaginationListView(
            controller: bloc,
            itemBuilder: (_, i) {
              return buildNotificationItem();
            },
            loadingEffectItemBuilder: (_, __) {
              return NotificationLoadingItem();
            },
            separatorBuilder: (_, __) => SizedBox(
              height: 8,
            ),
            listPaddingStartAndEnd: 16,
          );