/*
	Possible vars:
	JumpHeightModifier
	RunSpeedModifier
	HealthModifier
	CarryWeightModifier
	StatModifiers
*/

ITEM.ID					= "stim_test";
ITEM.Name				= "Stimulant";
ITEM.Description		= "A stimulant.";
ITEM.Duration			= 10;
ITEM.Model				= "models/items/boxsrounds_old.mdl";
ITEM.Weight 			= 0;
ITEM.FOV 				= 14;
ITEM.CamPos 			= Vector( 50, 50, 50 );
ITEM.LookAt 			= Vector( 0, 0, 0 );

ITEM.BulkPrice			= 25000;
ITEM.License			= LICENSE_MEDICAL;
ITEM.StatModifiers		= {
	["Strength"] = 4
}
ITEM.RunSpeedModifier	= 200;
ITEM.JumpHeightModifier = 200;
ITEM.CarryWeightModifier= 200;
ITEM.HealthModifier		= 200;