var _cid = string(data.get_cid())

if (struct_exists(obj_typewriter_manager.choice, _cid)){
	struct_remove(obj_typewriter_manager.choice, _cid)
}