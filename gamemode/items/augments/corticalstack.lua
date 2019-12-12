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

ITEM.ID					= "corticalstack";
ITEM.Name				= "Cortical Stack";
ITEM.Description		= "A high tech memory storage device containing an entire human mind - all of its memories and even its stream of consciousness.";
ITEM.Model				= "models/cards/chip.mdl";
ITEM.ItemSubmaterials	= { {0,"models/props_combine/weaponstripper_sheet"} };
ITEM.Weight 			= 0;
ITEM.FOV 				= 14;
ITEM.CamPos 			= Vector( 50, 50, 50 );
ITEM.LookAt 			= Vector( 0, 0, 0 );

ITEM.InstallLocation	= "corticalstack"
ITEM.CannotRemove		= true;
ITEM.License		= LICENSE_AUG;