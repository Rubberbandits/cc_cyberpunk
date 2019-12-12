/*
	Possible vars:
	JumpHeightModifier
	RunSpeedModifier
	HealthModifier
	ArmorModifier
	DescriptionModifier
	CarryWeightModifier
	StatModifiers
	EnableZoom
*/

ITEM.ID					= "armorskin";
ITEM.Name				= "Dermatek Subdermal Composite Armor";
ITEM.Description		= "Flexible armor plating installed beneath the skin provides passive resistance to ballistic and blunt force. NIJ Level II protection (ie, most pistol rounds) across most of the body with gaps around joints. Hands, feet, the head, and sensitive areas are not covered.";
ITEM.Model				= "models/props_combine/headcrabcannister01a_skybox.mdl";
ITEM.ItemSubmaterials	= { {0,"models/combine_mine/combine_mine03"} };
ITEM.Weight 			= 0;
ITEM.FOV 				= 14;
ITEM.CamPos 			= Vector( 50, 50, 50 );
ITEM.LookAt 			= Vector( 0, 0, 0 );

ITEM.InstallLocation	= "skin"
ITEM.CannotRemove		= false;
ITEM.License		= LICENSE_AUG;
ITEM.BulkPrice		= 10000;
ITEM.ArmorModifier		= 50;