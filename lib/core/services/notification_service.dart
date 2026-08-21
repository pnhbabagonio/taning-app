class NotificationService {
	NotificationService._();

	static final NotificationService instance = NotificationService._();

	static Future<void> initialize() async {
		await instance._initialize();
	}

	Future<void> _initialize() async {}
}
