class_name StatsHelper;

static func create_stats(old_stats: Resource, new_stats: Resource, signal_name: StringName, callback: Callable) -> Resource:
	if old_stats and old_stats.has_signal(signal_name) and old_stats.is_connected(signal_name, callback):
		old_stats.disconnect(signal_name, callback);
	
	var result = new_stats.duplicate(true) if new_stats else null;
	
	if result and result.has_signal(signal_name):
		result.connect(signal_name, callback);
	
	return result;
