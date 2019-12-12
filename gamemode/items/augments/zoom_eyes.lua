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

ITEM.ID					= "zoom_eyes";
ITEM.Name				= "Carl Zeiss Rangefinder Implant";
ITEM.Description		= "An optical implant that permits the user to increase the magnification of their vision.";
ITEM.Model				= "models/props_combine/headcrabcannister01a_skybox.mdl";
ITEM.ItemSubmaterials	= { {0,"models/combine_mine/combine_mine03"} };
ITEM.Weight 			= 0;
ITEM.FOV 				= 14;
ITEM.CamPos 			= Vector( 50, 50, 50 );
ITEM.LookAt 			= Vector( 0, 0, 0 );

ITEM.InstallLocation	= "eyes"
ITEM.CannotRemove		= false;
ITEM.License		= LICENSE_AUG;
ITEM.BulkPrice		= 1200;
ITEM.EnableZoom		= true;
ITEM.StatModifiers		= {
		["Perception"] = 3,
	}