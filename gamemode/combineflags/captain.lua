FLAG.PrintName 		= "Captain";
FLAG.Flag 			= "F";
FLAG.Loadout		= { };
FLAG.ItemLoadout 	= { "combineterminal", "backpack", "radio", "smallmedkit", "zipties", "weapon_cc_knife", "weapon_it_tac45", "ammo_45acp", "weapon_cc_flare", "weapon_it_peacekeeper", "ammo_57", "weapon_cc_flashbang", "weapon_cc_grenade" };
FLAG.CharName		= "Captain $NAME";
FLAG.RequestCallsign = true;
FLAG.CanJW			= true;
FLAG.CanEditLoans	= true;
FLAG.CanEditCPs		= true;
FLAG.CanUseDispatch	= true;
FLAG.PromoteTo		= "G";
FLAG.DemoteTo		= "E";
FLAG.ModelSkin = 2

FLAG.EditableRanks = {
	["A"] = true,
	["B"] = true,
	["C"] = true,
	["D"] = true,
	["E"] = true,
};

FLAG.Salary = 24
FLAG.SalaryInterval = 3600

function FLAG.ModelFunc( ply )

	return "models/me2/Mercs/male_00_fixed.mdl";
	
end

function FLAG.OnGiven( ply )

	if( SERVER ) then

		net.Start( "nRequestCallsign" );
		net.Send( ply );
	
	end

end

if( CLIENT ) then

	local function nRequestCallsign( len )
	
		Derma_StringRequest( "Choose Callsign", "You've been promoted. You must now pick a callsign.", "", function( text )

			net.Start( "nRequestCallsign" );
				net.WriteString( string.Trim( text ) );
			net.SendToServer();
		
		end );
	
	end
	net.Receive( "nRequestCallsign", nRequestCallsign );
	
else

	local function nRequestCallsign( len, ply )
	
		if( !GAMEMODE:LookupCombineFlag( ply:CombineFlag() ).RequestCallsign ) then return end;
	
		local callsign = net.ReadString();
		
		ply:SetCombineSquad( callsign:Trim() );
		ply:UpdateCharacterField( "CombineSquad", callsign:Trim() );
	
	end
	net.Receive( "nRequestCallsign", nRequestCallsign );

end