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

	ITEM.ID					= "strongarm_left";
	ITEM.Name				= "Dyna-Tronic Strong-Arm (Left)";
	ITEM.Description		= "A brawny replacement for the left arm. Equipped with hydraulics for addded lifting power - slow but steady. Installs to a standardized limb replacement socket, which itself can pull painfully on the shoulder blade and is prone to infection.";
	ITEM.Model				= "models/props_combine/headcrabcannister01a_skybox.mdl";
	ITEM.Weight 			= 0;
	ITEM.FOV 				= 14;
	ITEM.CamPos 			= Vector( 50, 50, 50 );
	ITEM.LookAt 			= Vector( 0, 0, 0 );

	ITEM.InstallLocation	= "leftarm"
	ITEM.CannotRemove		= false;
	ITEM.License		= LICENSE_AUG;
	ITEM.BulkPrice		= 5000;

	ITEM.StatModifiers		= {
		["Strength"] = 2,
		["Agility"] = -2
	}
	ITEM.CarryWeightModifier = 5;