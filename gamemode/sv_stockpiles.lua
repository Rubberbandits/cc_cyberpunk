GM.LoadedStockpiles = {};

function CreateNewStockpileEntry( ply, name )

	if( ply:CharID() <= 0 ) then return end
	
	local function NameCheck( ret )
		
		if( #ret == 0 ) then
		
			local function onSuccess( ret, q )
			
				GAMEMODE.LoadedStockpiles[tostring( q:lastInsert() )] = { 
					["Name"] = name, 
					["Inventory"] = {}, 
					["Accessors"] = { math.floor( ply:CharID() ) },
				}
				
			end
			mysqloo.Query( Format( "INSERT INTO cc_stockpiles ( SteamID, Accessors, Inventory, Name ) VALUES ( '%s', '%s', '%s', '%s' )", ply:SteamID(), util.TableToJSON( { math.floor( ply:CharID() ) } ), util.TableToJSON( {} ), mysqloo.Escape( name ) ), onSuccess );
			
		else
		
			net.Start( "nStockpileNameTaken" );
			net.Send( ply );
		
		end
		
	end
	mysqloo.Query( Format( "SELECT * FROM cc_stockpiles WHERE Name = '%s'", mysqloo.Escape( name ) ), NameCheck );
	
end

function RetrieveStockpiles()

	local function onSuccess( ret )
	
		for k,v in next, ret do
	
			GAMEMODE.LoadedStockpiles[tostring( v.id )] = { 
				["Name"] = v.Name, 
				["Inventory"] = util.JSONToTable( v.Inventory ), 
				["Accessors"] = util.JSONToTable( v.Accessors )
			}
			
		end
	
	end
	mysqloo.Query( "SELECT * FROM cc_stockpiles", onSuccess );

end

local function nRequestStockpiles( len, ply )

	if( !DoDistanceCheckForStockpile( ply ) ) then return end
	
	local tbl = {};

	for k,v in next, GAMEMODE.LoadedStockpiles do

		if( table.HasValue( v.Accessors, math.floor( ply:CharID() ) ) ) then

			tbl[k] = { ["Name"] = v.Name, ["Inventory"] = v.Inventory };
			
		end
	
	end

	net.Start( "nPopulateStockpilesMenu" );
		net.WriteString( util.TableToJSON( tbl ) );
	net.Send( ply );

end
net.Receive( "nRequestStockpiles", nRequestStockpiles );

local function nRequestMoveStockpiles( len, ply )

	if( !DoDistanceCheckForStockpile( ply ) ) then return end
	
	local tbl = {};

	for k,v in next, GAMEMODE.LoadedStockpiles do

		if( table.HasValue( v.Accessors, math.floor( ply:CharID() ) ) ) then

			tbl[k] = { ["Name"] = v.Name, ["Inventory"] = v.Inventory };
			
		end
	
	end

	net.Start( "nPopulateMoveToStock" );
		net.WriteString( util.TableToJSON( tbl ) );
	net.Send( ply );

end
net.Receive( "nRequestMoveStockpiles", nRequestMoveStockpiles );

local function nTakeFromStockpile( len, ply )

	local index = net.ReadInt( 32 );
	local id = net.ReadInt( 32 );
	
	if( !DoDistanceCheckForStockpile( ply ) ) then return end
	
	local item = ply.Stockpile[index];
	if( item ) then

		table.insert( ply.Inventory[ply:GetDutyInventory()], item );
		table.remove( ply.Stockpile, index );
		
		GAMEMODE:LogItems( "[G] " .. ply:VisibleRPName() .. " obtained item " .. item .. ".", ply );
		
		GAMEMODE:GetItemByID( item ).OnPlayerPickup( item, ply );
		
		net.Start( "nGiveItem" );
			net.WriteString( item );
			net.WriteUInt( 1, 8 );
		net.Send( ply );

		ply:SaveInventory();
		ply:SaveStockpile();
		
	end

end
net.Receive( "nTakeFromStockpile", nTakeFromStockpile );

local function nMoveToStockpile( len, ply )

	local index = net.ReadInt( 32 );
	local id = net.ReadInt( 32 );
	local item = ply.Inventory[ply:GetDutyInventory()][index];
	
	if( !DoDistanceCheckForStockpile( ply ) ) then return end
	if( item ) then -- check if its an item that can be equipped and if it is equipped.
	
		ply.Stockpile[#ply.Stockpile + 1] = item;
		if( GAMEMODE:GetItemByID( item ).OnRemoved ) then
		
			GAMEMODE:GetItemByID( item ).OnRemoved( item, ply );
			
		end
		table.remove( ply.Inventory[ply:GetDutyInventory()], index );
		ply:SaveInventory();
		ply:SaveStockpile();
		
	end

end
net.Receive( "nMoveToStockpile", nMoveToStockpile );

local function nAdminRequestStockpileMenu( len, ply )

	if( !ply:IsAdmin() ) then return end
	
	local target = GAMEMODE:FindPlayer( net.ReadString(), ply );
	if( target ) then
	
		net.Start( "nAdminPopulateStockpilesMenu" );
			net.WriteString( util.TableToJSON( target.Stockpile ) );
		net.Send( ply );
		
	end

end
net.Receive( "nAdminRequestStockpileMenu", nAdminRequestStockpileMenu );

local function nAdminPopulateTakeAccessMenu( len, ply )

	local function onSuccess( ret )
	
		local tbl = {};
	
		for k,v in next, ret do
		
			local acc = util.JSONToTable( v.Accessors );

			if( table.HasValue( acc, math.floor( ply:CharID() ) ) ) then

				tbl[tostring( v.id )] = { ["Name"] = v.Name };
				
			end
		
		end

		net.Start( "nAdminPopulateTakeAccessMenu" );
			net.WriteString( util.TableToJSON( tbl ) );
		net.Send( ply );
	
	end
	mysqloo.Query( "SELECT * FROM cc_stockpiles", onSuccess );

end
net.Receive( "nAdminPopulateTakeAccessMenu", nAdminPopulateTakeAccessMenu );

local function nAdminPopulateGiveAccessMenu( len, ply )

	local function onSuccess( ret )
	
		local tbl = {};
	
		for k,v in next, ret do
		
			local acc = util.JSONToTable( v.Accessors );
			if( !table.HasValue( acc, math.floor( ply:CharID() ) ) ) then

				tbl[tostring( v.id )] = { ["Name"] = v.Name };
				
			end
		
		end

		net.Start( "nAdminPopulateGiveAccessMenu" );
			net.WriteString( util.TableToJSON( tbl ) );
		net.Send( ply );
	
	end
	mysqloo.Query( "SELECT * FROM cc_stockpiles", onSuccess );

end
net.Receive( "nAdminPopulateGiveAccessMenu", nAdminPopulateGiveAccessMenu );

local function nAdminRemoveStockpile( len, ply )

	local id = net.ReadInt( 32 );

	local function onSuccess( ret )
	
		GAMEMODE.LoadedStockpiles[tostring(id)] = nil;

		net.Start( "nARemovedStockpileSuccess" );
		net.Send( ply );
	
	end
	mysqloo.Query( Format( "DELETE FROM cc_stockpiles WHERE id = '%d'", id ), onSuccess );

end
net.Receive( "nAdminRemoveStockpile", nAdminRemoveStockpile );

local function nSetupStockpile( len, ply ) -- could be sql injected... need prepped queries.

	local name = net.ReadString();
	
	if( ply:HasCharFlag( "M" ) and ply.StartStockpileCreation ) then
	
		CreateNewStockpileEntry( ply, mysqloo.Escape( name ) );
		ply.StartStockpileCreation = false;
		
	end

end
net.Receive( "nSetupStockpile", nSetupStockpile );