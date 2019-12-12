local function nPopulateStockpilesMenu( len )
	
	local inv = util.JSONToTable( net.ReadString() );
	
	GAMEMODE:PopulateStockpilesMenu( inv );
	
end
net.Receive( "nPopulateStockpilesMenu", nPopulateStockpilesMenu );

local function nOpenStockpilesMenu( len )

	GAMEMODE:PMCreateStockpile();

end
net.Receive( "nOpenStockpilesMenu", nOpenStockpilesMenu );

local function nAdminPopulateStockpilesMenu( len )

	local stockpiles = util.JSONToTable( net.ReadString() );
	local line = CCP.AdminMenu.PlayerList:GetLine( CCP.AdminMenu.SelectedID );

	GAMEMODE:AdminCreateStockpileMenu( line.Player:RPName(), stockpiles, line.SteamID );

end
net.Receive( "nAdminPopulateStockpilesMenu", nAdminPopulateStockpilesMenu );

local function nPopulateMoveToStock( len )

	local inv = util.JSONToTable( net.ReadString() );

	GAMEMODE:PopulateMoveToStock( inv );

end
net.Receive( "nPopulateMoveToStock", nPopulateMoveToStock );

local function nPopulateStockpilesMenu( len )

	local inv = util.JSONToTable( net.ReadString() );
	
	GAMEMODE:PopulateStockpilesMenu( inv );
	
end
net.Receive( "nPopulateStockpilesMenu", nPopulateStockpilesMenu );

local function nRequestStockpileName( len )

	Derma_StringRequest(
		"Stockpile Name",
		"Enter the name of your new stockpile.",
		"",
		function( text )
			
			net.Start( "nSetupStockpile" );
				net.WriteString( text );
			net.SendToServer();
			
		end,
		nil
	)

end
net.Receive( "nRequestStockpileName", nRequestStockpileName );

local function nStockpileNameTaken()

	GAMEMODE:AddChat( Color( 255, 20, 20 ), "CombineControl.ChatNormal", "This stockpile name is already taken!", { CB_ALL, CB_OOC } );

end
net.Receive( "nStockpileNameTaken", nStockpileNameTaken );

function nARemovedStockpileSuccess()

	GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Stockpile successfully removed.", { CB_ALL, CB_OOC } );

end
net.Receive( "nARemovedStockpileSuccess", nARemovedStockpileSuccess );