local meta = FindMetaTable( "Player" );

function meta:LoadItemsFromString( str )
	
	self.Inventory = {
		["offduty"] = {},
		["onduty"] = {},
	};
	
	self.Inventory = util.JSONToTable( str ) or self.Inventory;
	
	net.Start( "nLoadInventory" );
		net.WriteTable( self.Inventory );
	net.Send( self );
	
end

function meta:LoadStockpile( szInv )

	self.Stockpile = {};
	self.Stockpile = util.JSONToTable( szInv ) or self.Stockpile;
	
	net.Start( "nLoadStockpile" );
		net.WriteString( szInv );
	net.Send( self );

end

function meta:LoadAugments( szAugs )

	self.Augments = {};
	self.Augments = util.JSONToTable( szAugs ) or self.Augments;
	
	net.Start( "nLoadAugments" );
		net.WriteEntity( self );
		net.WriteString( szAugs );
	net.Broadcast()

end

function meta:SaveInventory()
	
	local str = util.TableToJSON( self.Inventory );
	
	self:UpdateCharacterField( "Inventory", str );
	
end

function meta:SaveStockpile()

	local str = util.TableToJSON( self.Stockpile );
	
	self:UpdateCharacterField( "Stockpile", str );

end

function meta:SaveAugments()

	local str = util.TableToJSON( self.Augments );
	self:UpdateCharacterField( "Augments", str );

end

if( CLIENT ) then
	
	local function nLoadInventory( len )
		
		local inv = net.ReadTable();
		
		LocalPlayer().Inventory = inv;
		
	end
	net.Receive( "nLoadInventory", nLoadInventory );
	
	local function nLoadStockpile( len )
	
		local inv = net.ReadString();
		
		LocalPlayer().Stockpile = util.JSONToTable( inv ) or {};
	
	end
	net.Receive( "nLoadStockpile", nLoadStockpile );
	
	local function nLoadAugments( len )
	
		local ent = net.ReadEntity();
		local augs = net.ReadString();
		ent.Augments = util.JSONToTable( augs ) or {};
	
	end
	net.Receive( "nLoadAugments", nLoadAugments );
	
	local function nGiveItem( len )
		
		local item = net.ReadString();
		local n = net.ReadUInt( 8 );
		
		LocalPlayer():GiveItem( item, n );
		
	end
	net.Receive( "nGiveItem", nGiveItem );
	
	local function nRemoveItem( len )
		
		local k = net.ReadUInt( 24 );
		
		LocalPlayer():RemoveItem( k );
		
	end
	net.Receive( "nRemoveItem", nRemoveItem );
	
	local function nTooHeavy( len )
		
		GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "That's too heavy for you to carry.", { CB_ALL, CB_IC } );
		
	end
	net.Receive( "nTooHeavy", nTooHeavy );
	
	local function nTakeFromStockpile( len )
	
		local index = net.ReadInt( 32 );
		table.remove( LocalPlayer().Stockpile, index );
		
	end
	net.Receive( "nTakeFromStockpile", nTakeFromStockpile );
	
else
	
	local function nUseItem( len, ply )
		
		local k = net.ReadUInt( 24 );
		
		ply:UseItem( k );
		
	end
	net.Receive( "nUseItem", nUseItem );
	
	local function nRemoveItem( len, ply )
		
		local k = net.ReadUInt( 24 );
		local s = net.ReadBit();
		
		ply:RemoveItem( k, s );
		
	end
	net.Receive( "nRemoveItem", nRemoveItem );
	
	local function nDropItem( len, ply )
		
		local k = net.ReadUInt( 24 );
		
		local item = ply.Inventory[ply:GetDutyInventory()][k];
		
		if( !k ) then return end
		
		GAMEMODE:LogItems( "[D] " .. ply:VisibleRPName() .. " dropped item " .. item .. ".", ply );
		
		ply:RemoveItem( k, 1 );
		
		GAMEMODE:CreateItem( ply, item );
		
	end
	net.Receive( "nDropItem", nDropItem );
	
end

function meta:GetNumItems( itemid )
	
	if( !self.Inventory ) then return 0 end
	
	local c = 0;
	
	for _, v in pairs( self.Inventory[self:GetDutyInventory()] ) do
		
		if( v == itemid ) then
			
			c = c + 1;
			
		end
		
	end
	
	return c;
	
end

function meta:HasItem( itemid )
	
	if( self:GetNumItems( itemid ) > 0 ) then return true; end
	
	return false;
	
end

function meta:GetInventoryItem( itemid )
	
	if( !self.Inventory ) then return end
	
	for k, v in pairs( self.Inventory[self:GetDutyInventory()] ) do
		
		if( v == itemid ) then
			
			return k;
			
		end
		
	end
	
end

function meta:InventoryWeight()
	
	if( !self.Inventory ) then return 0 end
	
	local w = 0;
	
	for _, v in pairs( self.Inventory[self:GetDutyInventory()] ) do
		
		if( GAMEMODE:GetItemByID( v ) and GAMEMODE:GetItemByID( v ).Weight ) then
			
			w = w + GAMEMODE:GetItemByID( v ).Weight;
			
		end
		
	end
	
	return w;
	
end

function meta:InventoryMaxWeight()
	
	local w = 10 + math.Round( self:Strength() * 0.2 );
	
	if( self:HasCombineModel() ) then
		
		w = 30 + math.Round( self:Strength() * 0.2 );
		
	end
	
	if( self.Inventory ) then
		
		local tab = { };
		
		for _, n in pairs( self.Inventory[self:GetDutyInventory()] ) do
			
			if( !table.HasValue( tab, n ) and GAMEMODE:GetItemByID( n ) and GAMEMODE:GetItemByID( n ).CarryAdd ) then
				
				w = w + GAMEMODE:GetItemByID( n ).CarryAdd;
				table.insert( tab, n );
				
			end
			
		end
		
	end
	
	if( self:HasTrait( TRAIT_MULE ) ) then
		
		w = w + 15;
		
	end
	
	if( self.Augments ) then
	
		for k,v in next, self.Augments do
		
			local metaitem = GAMEMODE:GetItemByID( k );
			if( !metaitem ) then continue end
			if( metaitem.CarryWeightModifier ) then
			
				w = w + metaitem.CarryWeightModifier;
				
			end
			
		end
		
	end
	
	if( self.ActiveStims ) then
	
		for k,v in next, self.ActiveStims do
		
			local metaitem = GAMEMODE:GetItemByID( k );
			if( !metaitem ) then continue end
			if( metaitem.CarryWeightModifier ) then
			
				w = w + metaitem.CarryWeightModifier;
				
			end
			
		end
		
	end
	
	return w;
	
end

function meta:CanTakeItem( item )
	
	if( GAMEMODE:GetItemByID( item ).Weight > 0 and self:InventoryWeight() + GAMEMODE:GetItemByID( item ).Weight > self:InventoryMaxWeight() ) then return false end
	
	return true;
	
end

function meta:GiveItem( item, n, nosave )
	
	n = n or 1;
	
	if( CLIENT ) then
		
		for i = 1, n do
			
			table.insert( self.Inventory[self:GetDutyInventory()], item );
			
		end
		
		GAMEMODE:GetItemByID( item ).OnPlayerPickup( item, self );
		
		GAMEMODE:PMUpdateInventory();
		
	else
		
		for i = 1, n do
			
			table.insert( self.Inventory[self:GetDutyInventory()], item );
			
		end
		
		GAMEMODE:LogItems( "[G] " .. self:VisibleRPName() .. " obtained item " .. item .. ".", self );
		
		GAMEMODE:GetItemByID( item ).OnPlayerPickup( item, self );
		
		net.Start( "nGiveItem" );
			net.WriteString( item );
			net.WriteUInt( n, 8 );
		net.Send( self );
		
		if( !nosave ) then
			
			self:SaveInventory();
			
		end
		
	end
	
end

function meta:RemoveItem( k, s )
	
	if( self:PassedOut() ) then return end
	if( self:TiedUp() ) then return end
	
	if( CLIENT ) then
		
		if( self.Inventory[self:GetDutyInventory()][k] and GAMEMODE:GetItemByID( self.Inventory[self:GetDutyInventory()][k] ) and GAMEMODE:GetItemByID( self.Inventory[self:GetDutyInventory()][k] ).OnRemoved ) then
			
			GAMEMODE:GetItemByID( self.Inventory[self:GetDutyInventory()][k] ).OnRemoved( self.Inventory[self:GetDutyInventory()][k], self );
			table.remove( self.Inventory[self:GetDutyInventory()], k );
			
		end
		
		GAMEMODE:PMUpdateInventory();
		
	else
		
		if( self.Inventory[self:GetDutyInventory()][k] ) then
			
			GAMEMODE:GetItemByID( self.Inventory[self:GetDutyInventory()][k] ).OnRemoved( self.Inventory[self:GetDutyInventory()][k], self );
			GAMEMODE:LogItems( "[R] " .. self:VisibleRPName() .. "'s item " .. self.Inventory[self:GetDutyInventory()][k] .. " was removed.", self );
			table.remove( self.Inventory[self:GetDutyInventory()], k );
			
		else
			
			return;
			
		end
		
		if( s != 1 ) then
			
			net.Start( "nRemoveItem" );
				net.WriteUInt( k, 24 );
			net.Send( self );
			
		end
		
		self:SaveInventory();
		
	end
	
end

function meta:UseItem( k )
	
	if( self:PassedOut() ) then return end
	if( self:TiedUp() ) then return end
	
	if( GAMEMODE:GetItemByID( self.Inventory[self:GetDutyInventory()][k] ).CanPlayerUse ) then
	
		if( GAMEMODE:GetItemByID( self.Inventory[self:GetDutyInventory()][k] ).CanPlayerUse( self.Inventory[self:GetDutyInventory()][k], self ) == false ) then
		
			return;
		
		end	
		
	end
	
	if( CLIENT ) then
		
		local ret = GAMEMODE:GetItemByID( self.Inventory[self:GetDutyInventory()][k] ).OnPlayerUse( self.Inventory[self:GetDutyInventory()][k], self );
		
		net.Start( "nUseItem" );
			net.WriteUInt( k, 24 );
		net.SendToServer();
		
		if( GAMEMODE:GetItemByID( self.Inventory[self:GetDutyInventory()][k] ).DeleteOnUse and !ret ) then
			
			self:RemoveItem( k, 1 );
			GAMEMODE:PMResetText();
			
		end
		
		GAMEMODE:PMUpdateInventory();
		
	else
		
		if( !self.Inventory[self:GetDutyInventory()][k] ) then
			
			return;
			
		end
		
		GAMEMODE:LogItems( "[U] " .. self:VisibleRPName() .. " used item " .. self.Inventory[self:GetDutyInventory()][k] .. ".", self );
		local ret = GAMEMODE:GetItemByID( self.Inventory[self:GetDutyInventory()][k] ).OnPlayerUse( self.Inventory[self:GetDutyInventory()][k], self );
		
		if( GAMEMODE:GetItemByID( self.Inventory[self:GetDutyInventory()][k] ).DeleteOnUse and !ret ) then
			
			self:RemoveItem( k, 1 );
			
		end
		
	end
	
end

function meta:ThrowOutItem( k )
	
	if( self:PassedOut() ) then return end
	if( self:TiedUp() ) then return end
	
	if( CLIENT ) then
		
		net.Start( "nRemoveItem" );
			net.WriteUInt( k, 32 );
			net.WriteBit( true );
		net.SendToServer();
		
		GAMEMODE:PMUpdateInventory();
		
	end
	
	CC.Me( self, Format( "destroys their %s.", GAMEMODE:GetItemByID( self.Inventory[self:GetDutyInventory()][k] ).Name ), true );
	
end

function meta:DropItem( k )
	
	if( self:PassedOut() ) then return end
	if( self:TiedUp() ) then return end
	
	if( CLIENT ) then
		
		table.remove( self.Inventory[self:GetDutyInventory()], k );
		
		net.Start( "nDropItem" );
			net.WriteUInt( k, 24 );
		net.SendToServer();
		
		GAMEMODE:PMUpdateInventory();
		
	end
	
end

function meta:MoveToStockpile( k )
	
	if( self:PassedOut() ) then return end
	if( self:TiedUp() ) then return end
	if( self:IsItemEquipped( self.Inventory[self:GetDutyInventory()][k] ) ) then return end
	
	if( CLIENT ) then
		
		table.insert( self.Stockpile, self.Inventory[self:GetDutyInventory()][k] );
		table.remove( self.Inventory[self:GetDutyInventory()], k );

		net.Start( "nMoveToStockpile" );
			net.WriteInt( k, 32 );
		net.SendToServer();
		
		GAMEMODE:PMUpdateInventory();
		
	end
	
end

function meta:TakeFromStockpile( k )

	if( self:PassedOut() ) then return end
	if( self:TiedUp() ) then return end
	
	if( CLIENT ) then
	
		table.remove( self.Stockpile, k );

		net.Start( "nTakeFromStockpile" );
			net.WriteInt( k, 32 );
		net.SendToServer();
		
	end

end