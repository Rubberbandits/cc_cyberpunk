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

ITEM.ID					= "anti_heatsig";
ITEM.Name				= "General Dynamics Thermal Cloak";
ITEM.Description		= "A subdermal web that passively masks the user's heat signature. An extremely invasive procedure, but invisible to the naked eye once installed.";
ITEM.Model				= "models/props_combine/headcrabcannister01a_skybox.mdl";
ITEM.ItemSubmaterials	= { {0,"models/combine_mine/combine_mine03"} };
ITEM.Weight 			= 0;
ITEM.FOV 				= 14;
ITEM.CamPos 			= Vector( 50, 50, 50 );
ITEM.LookAt 			= Vector( 0, 0, 0 );

ITEM.InstallLocation	= "skin"
ITEM.CannotRemove		= false;
ITEM.License		= LICENSE_AUG;
ITEM.BulkPrice		= 6000;