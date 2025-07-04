enum BOARD_TYPE {
	POLYGON,
	CIRCLE
}

///@arg {Real} x 中心x座標
///@arg {Real} y 中心y座標
///@arg {Real} order 順番
///@ignore
function BoardData(_x, _y, _order) constructor {
	x = _x;
	y = _y;
	order = _order;
	
	type = -1;
}

///@arg {Real} x 中心x座標
///@arg {Real} y 中心y座標
///@arg {Real} order 順番
function BoardPolygonGroup(_x, _y, _order) : BoardData(_x, _y, _order) constructor {
	type = BOARD_TYPE.POLYGON;
	
	polygons_data = {};
	angle = 0;
	
	///ポリゴンを追加(又は編集)します
	///@arg {String} tag ポリゴンのタグ
	///@arg {Real} x x座標
	///@arg {Real} y y座標
	///@arg {Real} order 順番-低いほど最初に呼ばれる(-1の場合は自動で0から登録される)
	static add = function(tag, _x, _y, order = -1){
		polygons_data[$tag] = {
			pos : new Vector2(_x, _y),
			order : (order < 0 ? struct_names_count(polygons_data) : order)
		}; 
	}
	
	///ポリゴンを削除します
	///@arg {String} tag ポリゴンのタグ
	static remove = function(tag){
		delete polygons_data[$tag];
		struct_remove(polygons_data, tag);
	}
	
	///ポリゴンを全消去します
	static clear = function(){
		delete polygons_data;
		polygons_data = {};
	}
	
	///枠の角度を指定します
	///@arg {Real} ang
	static set_angle = function(ang){
		angle = ang;
	}
}

///@arg {Real} x 中心x座標
///@arg {Real} y 中心y座標
///@arg {Real} order 順番
///@arg {Real} scale 大きさ
function BoardCircle(_x, _y, _order, _scale) : BoardData(_x, _y, _order) constructor {
	scale = _scale;
	
	type = BOARD_TYPE.CIRCLE;
	
	precision = 36;
	
	///円の精度を指定します
	///値が低いと、見た目がカクつきます
	///@arg {Real} precision
	static set_precision = function(c){
		precision = c;
	}
}

///枠の情報を更新します
///枠名を指定することでその枠のみ更新します
///@arg {String} polygon_name 枠名
function board_update(polygon_name = undefined){
	var _parentnames, _name, _count, _e, _tag, _polytemp, _data, _len, _is_lastpos;
	
	with (obj_battle_board){
		//dataからorder順に並び変えます
		//数値が若い順に並べられます
		original_list = [];
		//枠名を_parentnamesに代入していきます
		if (is_undefined(polygon_name)){
			_parentnames = struct_get_names(data);
			_count = array_length(_parentnames);
			
		}else{
			//指定されている場合は一つに限定します
			if (variable_struct_exists(data, polygon_name)){
				_parentnames = [data[$polygon_name]];
				_count = 1;
			}else throw "doesn't exists " + polygon_name;
		}
		
		for (var i = 0; i < _count; i++) {
			_name = _parentnames[i];
			
			//データ取得
			_e = data[$_name];
			
			//polygonsにデータを移すための構造体を作成
			_data = {
				type : _e.type,
				pos : new Vector2(_e.x, _e.y),
				order : _e.order
			};
			
			//ポリゴンの場合
			if (_e.type == BOARD_TYPE.POLYGON){
				_polytemp = []
				
				//polygons_data.[tag]の中身を_polytempに入れていく
				struct_foreach(_e.polygons_data, method({_polytemp}, function (_name, _value) {
					array_push(_polytemp, _value);
				}))
				
				//orderによって順番を入れ替える
				array_sort(_polytemp, function(_a, _b){
					return _a.order - _b.order;
				})
				
				//データを移すための構造体に情報を追加する
				_data.polydata = [];
				_data.polyoffset = [];
				_data.polyhitbox = [];
				_data.ccw = true;
				
				//orderのデータはいらないので、posデータのみをpolydataの配列にぶち込む
				//ついでに回転もする
				array_foreach(_polytemp, method({data : _data.polydata, ang : _e.angle}, function(_e){
					array_push(data, _e.pos.copy().rot(ang))
				}));
				
				if (BOARD_POINT_OVERLAPPING_CHECKER){
					//前後で重複するポリゴンがあれば除外
					_len = array_length(_data.polydata);
					for (var j = 0; j < _len; j++) {
						var _points = [
							_data.polydata[(j + _len - 1) % _len],
							_data.polydata[j],
							_data.polydata[(j + 1) % _len]
						]
						for (var k = 0; k < 2; k++) {
							if (_points[k].equals(_points[k + 1])) {
								array_delete(_data.polydata, j, 1)
								j--
								break;
							};
						}
						_len = array_length(_data.polydata);
					}
				}
				
				if (BOARD_CCW_CHECKER){
					//左回りか右回りか
					var _ccw = polygon_is_ccw(_data.polydata);
					_data.ccw = _ccw;
				}else{
					_data.ccw = true;
				}
				
				//ポリゴンのオフセットをする
				_data.polyoffset = offset_point_jtmiter(_data.polydata, 5, _data.ccw);
			}
			//円形の場合
			else if (_e.type == BOARD_TYPE.CIRCLE){
				//データを移すための構造体に情報を追加する
				_data.scale = _e.scale;
				_data.scalehitbox = 0;
				_data.precision = _e.precision;
			}
			
			_is_lastpos = true;
			for (var j = 0; j < array_length(original_list); j++) {
				if (_data.order < original_list[j].order){
					array_insert(original_list, j, _data)
					_is_lastpos = false;
					break;
				}
			}
			if (_is_lastpos) array_push(original_list, _data)
			
		}
		
		//ソウルが存在すればあたり判定用のポリゴンを作成
		if (instance_exists(obj_battle_soul)){
			board_update_hitbox()
		}
	}
}

///枠の当たり判定を更新します
function board_update_hitbox(){
	var _e, _scale, _of; 
	_scale = obj_battle_soul.scale;
	with (obj_battle_board){
		for (var i = 0; i < array_length(original_list); i++) {
			_e = original_list[i];
			if (_e.type == BOARD_TYPE.POLYGON){
				_of = obj_battle_soul.collision_size.copy().mul(-1).mul(_scale);
				
				_e.polyhitbox = offset_point_jtmiter(_e.polydata, _of, _e.ccw);
			}
			else if (_e.type == BOARD_TYPE.CIRCLE){
				_e.scalehitbox -= obj_battle_soul.collision_size.get_min();
			}
		}
	}
}

///長方形の枠を作成します
///@arg {String} name boardName
///@arg {Real} ox offsetX
///@arg {Real} oy offsetY
///@arg {Real} left left
///@arg {Real} up up
///@arg {Real} right right
///@arg {Real} down down
///@arg {Real} angle angle
///@arg {Real} order order
function board_create_rectangle(name, ox, oy, left, up, right, down, angle, order){
	
	var _board = new BoardPolygonGroup(ox, oy, order);
	
	_board.add("upperLeft", -left, -up)
	_board.add("lowerLeft", -left, down)
	_board.add("lowerRight", right, down)
	_board.add("upperRight", right, -up)
	
	_board.set_angle(angle);
	
	board_register_data(_board, name);
}

///枠データを取得します
///@arg {String} name 名前
///@return {Struct.BoardData}
function board_get_data(name){
	with (obj_battle_board){
		return data[$name];
	}
}

///枠を登録します
///@arg {Struct.BoardData} boarddata 枠
///@arg {String} name 名前
function board_register_data(boarddata, name){
	with (obj_battle_board){
		data[$name] = boarddata;
	}
}

///枠を削除します
///@arg {String} board_name 枠名
function board_delete_data(board_name){
	with (obj_battle_board){
		delete data[$ board_name];
		struct_remove(data, board_name);
	}
}


function battle_board_get_surface(){
	if (instance_exists(obj_battle_board) && surface_exists(obj_battle_board.srf_clipping)){
		return obj_battle_board.srf_clipping;
	}
	return -1;
}