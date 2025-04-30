alpha -= startalpha / time;
if (alpha <= 0){
	instance_destroy();
}