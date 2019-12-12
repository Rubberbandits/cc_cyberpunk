FLAG.PrintName 		= "Sergeant";
FLAG.Flag 			= "D";
FLAG.Loadout		= { };
FLAG.ItemLoadout 	= { "backpack", "radio", "smallmedkit", "zipties", "weapon_cc_knife", "weapon_it_tac45", "ammo_45acp", "weapon_cc_flare", "weapon_it_peacekeeper", "ammo_57", "weapon_cc_flashbang", "weapon_cc_grenade" };
FLAG.CharName		= "Sergeant $NAME";
FLAG.CanEditLoans	= true;
FLAG.DemoteTo		= "C";
FLAG.PromoteTo		= "E";
FLAG.ModelSkin = 2

FLAG.Salary = 18
FLAG.SalaryInterval = 3600

function FLAG.ModelFunc( ply )
	
	return "models/me2/Mercs/male_00_fixed.mdl";
	
end
