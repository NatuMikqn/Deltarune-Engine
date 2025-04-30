var _x, _y
	
draw_set_color(make_color_rgb(64, 0, 0))
for(var i=0;i<ceil(room_width / 100) + 2;i++){
	for(var j=0;j<ceil(room_height / 200) + 2;j++){
		_x = x + (i) * 100 - (timer / 4 % 100)
		_y = y + (j) * 200 - (timer / 8 % 200)
		
		draw_primitive_begin(pr_trianglestrip)
		draw_vertex(_x, _y-100)
		draw_vertex(_x-50, _y)
		draw_vertex(_x, _y+100)
		draw_vertex(_x+50, _y)
		draw_vertex(_x, _y-100)
		draw_primitive_end()
		//draw_vertex(_x, _y-100)
	}
}

draw_set_color(c_maroon)
for(var i=0;i<ceil(room_width / 100) + 2;i++){
	for(var j=0;j<ceil(room_height / 200) + 2;j++){
		_x = x + (i-1) * 100 + (timer / 2 % 100)
		_y = y + (j-1) * 200 + (timer / 4 % 200)
		
		draw_primitive_begin(pr_trianglestrip)
		draw_vertex(_x, _y-100)
		draw_vertex(_x-50, _y)
		draw_vertex(_x, _y+100)
		draw_vertex(_x+50, _y)
		draw_vertex(_x, _y-100)
		draw_primitive_end()
		//draw_vertex(_x, _y-100)
	}
}

/*
draw_set_color(c_lime)
for(var i=0;i<ceil(room_width / 100) + 1;i++){
	_x = (i+1) * 100
	
	draw_line(_x, 0, _x, room_height)
}

for(var i=0;i<ceil(room_height / 100) + 1;i++){
	_y = (i+1) * 100
	
	draw_line(0, _y, room_width, _y)
}*/