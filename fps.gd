# Godot Sponza: Custom FPS counter implementation
# Inspired by <http://www.growingwiththeweb.com/2017/12/fast-simple-js-fps-counter.html>
#
# Copyright © 2017-2020 Hugo Locurcio and contributors - MIT License
# See `LICENSE.md` included in the source distribution for details.

# This processes more than once per second, which is the unchangable default for
# Engine.get_frames_per_second()

extends Label

# Display rendered frames per second, itself updated multiple times per second, but capped at 1000 FPS.
# Typically right-aligned to prevent text shifting on addition/removal of a power-of-ten digit (e.g. 99 to 100).
# The first second of so after launching will have erratic text until this collects enough frame data.

# How often to refresh this display text
export(int, 1, 1000) var updates_per_sec := 10

# Timestamps of frames rendered in the last second
var times := []
# Frames per second
var fps := 0
# Most recent timestamp when this was refreshed
var last_update_ms := 0


func _process(_delta: float) -> void:
	var now_ms := OS.get_ticks_msec()

	Utils.front_clip_array(times, now_ms - Utils.MS_PER_SECOND)

	times.append(now_ms)
	fps = times.size()

	if _should_update(now_ms):
		text = str(fps) + " FPS"
		last_update_ms = now_ms


# Whether or not this display should be updated.
func _should_update(moment_ms: int) -> bool:
	# TODO: check if this is fine if moment_ms is negative (first second of game running)
	# warning-ignore:integer_division
	var update_threshold_ms: int = Utils.MS_PER_SECOND / updates_per_sec
	# TODO: validate update_threshold_ms

	if (last_update_ms + update_threshold_ms) <= moment_ms:
		return true

	return false
