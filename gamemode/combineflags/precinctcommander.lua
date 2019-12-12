FLAG.PrintName 		= "Precinct Commander";
FLAG.Flag 			= "G";
FLAG.Loadout		= { };
FLAG.ItemLoadout 	= { "combineterminal", "backpack", "radio", "smallmedkit", "zipties", "weapon_cc_knife", "weapon_it_tac45", "ammo_45acp", "weapon_cc_flare", "weapon_it_peacekeeper", "ammo_57", "weapon_cc_flashbang", "weapon_cc_grenade" };
FLAG.CharName		= "Precinct Commander $NAME";
FLAG.RequestCallsign = true;
FLAG.CanJW			= true;
FLAG.CanEditLoans	= true;
FLAG.CanEditCPs		= true;
FLAG.CanUseDispatch	= true;
FLAG.DemoteTo		= "F";
FLAG.ModelSkin = 2

FLAG.EditableRanks = {
	["A"] = true,
	["B"] = true,
	["C"] = true,
	["D"] = true,
	["E"] = true,
	["F"] = true,
	["G"] = true,
};

function FLAG.ModelFunc( ply )
	
	return "models/me2/Mercs/male_00_fixed.mdl";
	
end

function FLAG.OnGiven( ply )

	if( SERVER ) then

		if( ply:CombineSquad() == "" ) then
	
			net.Start( "nRequestCallsign" );
			net.Send( ply );
			
		end
	
	end

end