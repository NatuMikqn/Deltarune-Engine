//////////////////////////////////////////////
// system

//初期起動時、言語の自動設定機能を有効にします
//PCの言語に合わせて自動で設定されます
#macro AUTO_LANGUAGE false

//Dialogのリストにて、下までカーソルを動かすと一番上に戻されます
//逆も同じです
//オフにすると、originalと同じになります
#macro BETTER_DIALOGSELECT true

//シード値の固定化
//0未満の場合は完全ランダムとなります
//符号なし32bit値
#macro RANDOM_SEED -1

//////////////////////////////////////////////
// performance

//枠のポリゴンポイントが重複しているかどうかを確認します
//不要な場合はfalseにしてください
//trueにすると、負荷が少し増えます
#macro BOARD_POINT_OVERLAPPING_CHECKER false

//枠のポリゴンポイントから正転か逆転かを判定します
//falseにした場合、必ず枠のポリゴンポイントの設定順は反時計回りに配置してください
//trueにすると、負荷が少し増えます
#macro BOARD_CCW_CHECKER true

//////////////////////////////////////////////
// draw

//TPにアウトラインを描画するようにします
#macro TP_OUTLINE true

//////////////////////////////////////////////
// deprecated

//nothing...

//////////////////////////////////////////////
// debug

//枠背景のポリゴン描画を可視化
#macro BOARD_BG_COLOR_DEBUG false