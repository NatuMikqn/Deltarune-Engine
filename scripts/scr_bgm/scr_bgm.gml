enum BGM_ID {
	AREA,
	BATTLE,
	USER1,
	USER2,
	USER3
}

global.bgm_list = array_create(5);

///@arg {real} id
///@arg {Asset.GMSound} bgm
///@arg {bool} loop
function bgm_play(_id, _bgm, _loop = true)
{
	if (array_length(global.bgm_list) <= _id) return;
	
	if (audio_is_playing(global.bgm_list[_id])){
		audio_pause_sound(global.bgm_list[_id]);
	}
	if (audio_exists(_bgm)){
		var _audio = audio_play_sound(_bgm, 10, _loop)
		global.bgm_list[_id] = _audio;
	}
}

///@arg {real} id
///@arg {real} volume
///@arg {real} milliseconds
function bgm_set_volume(_id, _volume, _time)
{
	if (array_length(global.bgm_list) <= _id) return;
	
	var _audio = global.bgm_list[_id]
	audio_sound_gain(_audio, _volume, _time)
}

///@arg {real} id
function bgm_pause(_id)
{
	if (array_length(global.bgm_list) <= _id) return;
	
	var _audio = global.bgm_list[_id]
	audio_pause_sound(_audio)
}

///@arg {real} id
function bgm_is_playing(_id)
{
	if (array_length(global.bgm_list) <= _id) return;
	
	var _audio = global.bgm_list[_id]
	return audio_is_playing(_audio)
}

///@arg {real} id
function bgm_resume(_id)
{
	if (array_length(global.bgm_list) <= _id) return;
	
	var _audio = global.bgm_list[_id]
	audio_resume_sound(_audio)
}

///@arg {real} id
function bgm_stop(_id)
{
	if (array_length(global.bgm_list) <= _id) return;
	
	var _audio = global.bgm_list[_id]
	audio_stop_sound(_audio)
}