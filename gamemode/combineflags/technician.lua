FLAG.PrintName 		= "Technician";
FLAG.Flag 			= "A";
FLAG.Loadout		= { };
FLAG.ItemLoadout 	= { "backpack", "radio", "smallmedkit", "zipties", "weapon_cc_knife", "weapon_it_tac45", "ammo_45acp" };
FLAG.CharName		= "Technician $NAME";
FLAG.CanSpawn		= false;
FLAG.CanBroadcast	= false;
FLAG.PromoteTo		= "B";
FLAG.ModelSkin = 2

FLAG.Salary = 12
FLAG.SalaryInterval = 3600

function FLAG.ModelFunc( ply )
	
	return "models/me2/Mercs/male_00_fixed.mdl";
	
end