var _debug = "";
_debug += $"now ===================\n";
_debug += $"{now_point}, {now_id}, {disable ? "disable" : "enable"}\n";
_debug += $"points ===================\n";
for (var i = 0; i < array_length(points); i++) {
	_debug += $"{points[i]}\n";
}

draw_text(20, 160, _debug);