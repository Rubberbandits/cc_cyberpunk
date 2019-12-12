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

ITEM.ID					= "diffusor";
ITEM.Name				= "Autodiffusor";
ITEM.Description		= "An arterial implant that automates the formerly risky procedure of using advanced stims and drugs.";
ITEM.Model				= "models/props_combine/headcrabcannister01a_skybox.mdl";
ITEM.ItemSubmaterials	= { {0,"models/combine_mine/combine_mine03"} };
ITEM.Weight 			= 0;
ITEM.FOV 				= 14;
ITEM.CamPos 			= Vector( 50, 50, 50 );
ITEM.LookAt 			= Vector( 0, 0, 0 );

ITEM.InstallLocation	= "neck"
ITEM.CannotRemove		= false;
ITEM.License		= LICENSE_AUG;
ITEM.BulkPrice		= 1500;