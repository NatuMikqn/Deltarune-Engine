enum ASSET_TYPE{
	FONT,
	SPRITE
}
enum ASSETS_FONT{
	DIALOG
}
enum ASSETS_SPRITE{
	BUTTON_FIGHT,
	BUTTON_ACT,
	BUTTON_TECH,
	BUTTON_ITEM,
	BUTTON_SPARE,
	BUTTON_DEFEND,
	NAME_KRIS,
	NAME_SUSIE,
	NAME_RALSEI,
	NAME_NOELLE
}

function l10n_assets_sprite(){
	
	lang_set(LANG.EN)
	
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.BUTTON_FIGHT, spr_battle_button_fight)
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.BUTTON_ACT, spr_battle_button_act)
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.BUTTON_TECH, spr_battle_button_tech)
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.BUTTON_ITEM, spr_battle_button_item)
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.BUTTON_SPARE, spr_battle_button_spare)
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.BUTTON_DEFEND, spr_battle_button_defend)
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.NAME_KRIS, spr_charbox_name_kris)
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.NAME_SUSIE, spr_charbox_name_susie)
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.NAME_RALSEI, spr_charbox_name_ralsei)
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.NAME_NOELLE, spr_charbox_name_noelle)
	
	lang_set(LANG.JA)
	
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.BUTTON_FIGHT, spr_battle_button_fight_jp)
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.BUTTON_ACT, spr_battle_button_act_jp)
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.BUTTON_TECH, spr_battle_button_tech_jp)
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.BUTTON_ITEM, spr_battle_button_item_jp)
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.BUTTON_SPARE, spr_battle_button_spare_jp)
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.BUTTON_DEFEND, spr_battle_button_defend_jp)
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.NAME_KRIS, spr_charbox_name_kris_ja)
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.NAME_SUSIE, spr_charbox_name_susie_ja)
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.NAME_RALSEI, spr_charbox_name_ralsei_ja)
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.NAME_NOELLE, spr_charbox_name_noelle_ja)
	
	lang_set(LANG.ZH)
	
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.BUTTON_FIGHT, spr_battle_button_fight_zh)
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.BUTTON_ACT, spr_battle_button_act_zh)
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.BUTTON_TECH, spr_battle_button_tech_zh)
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.BUTTON_ITEM, spr_battle_button_item_zh)
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.BUTTON_SPARE, spr_battle_button_spare_zh)
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.BUTTON_DEFEND, spr_battle_button_defend_zh)
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.NAME_KRIS, spr_charbox_name_kris)
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.NAME_SUSIE, spr_charbox_name_susie)
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.NAME_RALSEI, spr_charbox_name_ralsei)
	l10n_set_assets(ASSET_TYPE.SPRITE, ASSETS_SPRITE.NAME_NOELLE, spr_charbox_name_noelle)
}
