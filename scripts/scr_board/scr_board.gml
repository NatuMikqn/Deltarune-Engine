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
function PolygonGroup(_x, _y, _order) : BoardData(_x, _y, _order) constructor {
	type = BOARD_TYPE.POLYGON;
	
	polygons_data = {};
	
	///ポリゴンを追加します
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
	function clear(){
		delete polygons_data;
		polygons_data = {};
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
	
	///円の角度を指定します
	///@arg {Real} ang
	static set_angle = function(ang){
		angle = ang;
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
		lists = [];
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
				angle : 0,
				order : _e.order
			};
			
			//ポリゴンの場合
			if (_e.type == BOARD_TYPE.POLYGON){
				_polytemp = []
				
				//PolygonGroup.[tag].posの中身を_polytemp.[name]にコピー
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
				array_foreach(_polytemp, method({data : _data.polydata}, function(_e){
					array_push(data, _e.pos)
				}));
				
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
				
				var _ccw = polygon_is_ccw(_data.polydata);
				_data.ccw = _ccw;
				
				//ポリゴンのオフセットをする
				_data.polyoffset = offset_point_jtmiter(_data.polydata, 5, _ccw);
			}
			//円形の場合
			else if (_e.type == BOARD_TYPE.CIRCLE){
				//データを移すための構造体に情報を追加する
				_data.scale = _e.scale;
				_data.precision = _e.precision;
			}
			
			_is_lastpos = true;
			for (var j = 0; j < array_length(lists); j++) {
				if (_data.order < lists[j].order){
					array_insert(lists, j, _data)
					_is_lastpos = false;
					break;
				}
			}
			if (_is_lastpos) array_push(lists, _data)
			
			
		}
		
		//ソウルが存在すればあたり判定用のポリゴンを作成
		if (instance_exists(obj_battle_soul)){
			board_update_hitbox()
		}
	}
}

///枠の当たり判定を更新します
function board_update_hitbox(){
	var _e;
	with (obj_battle_board){
		for (var i = 0; i < array_length(lists); i++) {
			_e = lists[i];
			_e.polyhitbox = offset_point_jtmiter(_e.polydata, obj_battle_soul.collision_size.copy().mul(-1), _e.ccw);
		}
	}
}

///枠を登録します
///@arg {Struct.BoardData} boarddata 枠
///@arg {String} name 名前
function board_data_register(boarddata, name){
	with (obj_battle_board){
		data[$name] = boarddata;
	}
}

///枠を削除します
///@arg {String} board_name 枠名
function board_data_delete(board_name){
	with (obj_battle_board){
		delete data[$ board_name];
		struct_remove(data, board_name);
	}
}