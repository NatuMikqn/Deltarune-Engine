global.bgm_list = []

///@arg {real} id
///@arg {Asset.GMSound} bgm
///@arg {bool} loop
function bgm_play(_id, _bgm, _loop = true){
	var _audio = audio_play_sound(_bgm, 10, _loop)
	array_push(global.bgm_list, _audio)
}

///@arg {real} id
///@arg {real} volume
///@arg {real} milliseconds
function bgm_set_volume(_id, _volume, _time){
	var _audio = global.bgm_list[_id]
	audio_sound_gain(_audio, _volume, _time)
}

///@arg {real} id
function bgm_pause(_id){
	var _audio = global.bgm_list[_id]
	audio_pause_sound(_audio)
}

///@arg {real} id
function bgm_resume(_id){
	var _audio = global.bgm_list[_id]
	audio_resume_sound(_audio)
}

///@arg {real} id
function bgm_stop(_id){
	var _audio = global.bgm_list[_id]
	audio_stop_sound(_audio)
}