

///枠の情報を更新します
///ポリゴングループ名を指定することでそのグループのみ更新します
///@arg {String} polygon_name ポリゴングループ名
function board_update(polygon_name = undefined){
	var _parentnames, _name, _count, _e, _tag, _polytemp;
	
	with (obj_battle_board){
		//polygons_dataからorder順に並び変えます
		//数値が若い順に並べられます
		
		if (polygon_name){
			if (variable_struct_exists(polygons_data, polygon_name)){
				_parentnames = [polygons_data[$polygon_name]];
				_count = 1;
			}else throw "doesn't exists" + polygon_name;
			
		}else{
			_parentnames = struct_get_names(polygons_data);
			_count = array_length(_parentnames);
		}
		
		for (var i = 0; i < _count; i++) {
			_name = _parentnames[i]
			_e = polygons_data[$_name];
			
			_polytemp = [];
			
			//polygons_data.[name].[tag].posの中身をpolygons.[name]にコピー
			struct_foreach(_e, method({_polytemp}, function (_name, _value) {
				array_push(_polytemp, _value);
			}))
			
			array_sort(_polytemp, function(_a, _b){
				return _a.order - _b.order;
			})
			
			polygons[$_name] = [];
			
			array_foreach(_polytemp, method({_name}, function (_e) {
				array_push(obj_battle_board.polygons[$_name], _e.pos);
			}))
			
			polygons_offset[$_name] = offset_point_jtmiter(polygons[$_name], 5);
		}
	}
	
}

///ポリゴンを追加します
///@arg {String} polygon_name ポリゴングループ名
///@arg {String} tag ポリゴンのタグ
///@arg {Real} x x座標
///@arg {Real} y y座標
///@arg {Real} order 順番-低いほど最初に呼ばれる(-1の場合は自動で0から登録される)
function board_polygon_add(polygon_name, tag, _x, _y, order = -1){
	with (obj_battle_board){
		
		if !variable_struct_exists(polygons_data, polygon_name){
			polygons_data[$polygon_name] = {}
		}
		
		polygons_data[$polygon_name][$tag] = {
			pos : new Vector2(_x, _y),
			order : (order < 0 ? struct_names_count(polygons_data[$polygon_name]) : order)
		};
	}
}

///ポリゴンの位置を編集します
///@arg {String} polygon_name ポリゴングループ名
///@arg {String} tag ポリゴンのタグ
///@arg {Real} x x座標
///@arg {Real} y y座標
function board_polygon_set(polygon_name, tag, _x, _y){
	with (obj_battle_board){
		
		if (board_polygon_is_exists(polygon_name, tag)){
			polygons_data[$polygon_name][$tag].pos.set(_x, _y);
		};
	}
}

///ポリゴンの位置データを取得します
///@arg {String} polygon_name ポリゴングループ名
///@arg {String} tag ポリゴンのタグ
///@return {Struct.Vector2}
function board_polygon_get(polygon_name, tag){
	with (obj_battle_board){
		return polygons_data[$polygon_name][$tag].pos;
	}throw "doesn't exists obj_battle_board"
}

///ポリゴンを消去します
///@arg {String} polygon_name
function board_polygon_remove(polygon_name, tag){
	with (obj_battle_board){
		if (board_polygon_is_exists(polygon_name, tag)){
			delete polygons_data[$polygon_name][$tag];
			struct_remove(polygons_data[$polygon_name], tag);
		};
	}
}

///ポリゴンを全消去します
///@arg {String} polygon_name
function board_polygon_clear(polygon_name){
	with (obj_battle_board){
		if (variable_struct_exists(polygons_data, polygon_name)){
			delete polygons_data[$polygon_name];
			struct_remove(polygons_data, polygon_name);
		}
	}
}

///ポリゴンが存在するかどうか
///@arg {String} polygon_name ポリゴングループ名
///@arg {String} tag ポリゴンのタグ
///@return {Bool}
function board_polygon_is_exists(polygon_name, tag){
	with (obj_battle_board){
		return (variable_struct_exists(polygons_data, polygon_name) && variable_struct_exists(polygons_data[$polygon_name], tag));
	}
	return false;
}