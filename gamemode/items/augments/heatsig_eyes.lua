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

ITEM.ID					= "heatsig_eyes";
ITEM.Name				= "General Dynamics Thermal Spectrum Receptors";
ITEM.Description		= "A full eyeball replacement augment that captures infra-red light, displaying heat signatures through objects.";
ITEM.Model				= "models/props_combine/headcrabcannister01a_skybox.mdl";
ITEM.ItemSubmaterials	= { {0,"models/combine_mine/combine_mine03"} };
ITEM.Weight 			= 0;
ITEM.FOV 				= 14;
ITEM.CamPos 			= Vector( 50, 50, 50 );
ITEM.LookAt 			= Vector( 0, 0, 0 );

ITEM.InstallLocation	= "eyes"
ITEM.CannotRemove		= false;
ITEM.License		= LICENSE_AUG;
ITEM.BulkPrice		= 17500;