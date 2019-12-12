FLAG.PrintName 		= "Patrol Officer";
FLAG.Flag 			= "B";
FLAG.Loadout		= { };
FLAG.ItemLoadout 	= { "backpack", "radio", "smallmedkit", "zipties", "weapon_cc_knife", "weapon_it_tac45", "ammo_45acp", "weapon_cc_flare", "weapon_it_peacekeeper", "ammo_57", "weapon_cc_flashbang" };
FLAG.CharName		= "Patrol Officer $NAME";
FLAG.CanEditLoans	= true;
FLAG.DemoteTo		= "";
FLAG.PromoteTo		= "C";
FLAG.ModelSkin = 2

FLAG.Salary = 15
FLAG.SalaryInterval = 3600

function FLAG.ModelFunc( ply )

	return "models/me2/Mercs/male_00_fixed.mdl";
	
end
