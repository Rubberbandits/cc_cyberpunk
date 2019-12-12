local meta = FindMetaTable( "Player" );

function meta:AddAugment( augment )

	local metaitem = GAMEMODE:GetItemByID( augment )
	if( metaitem and metaitem.Augment ) then
	
		self.Augments[augment] = true;
		for k,v in next, self.Augments do
		
			local item = GAMEMODE:GetItemByID( k );
			item.OnAugmentTaken( k, self );
			
		end
		for k,v in next, self.Augments do
		
			local item = GAMEMODE:GetItemByID( k );
			item.OnAugmentSpawn( k, self );
			
		end
		net.Start( "nLoadAugments" );
			net.WriteEntity( self );
			net.WriteString( util.TableToJSON( self.Augments ) );
		net.Broadcast()
		self:SaveAugments();
	
	end

end

function meta:RemoveAugment( augment )

	if( !self.Augments[augment] ) then return end

	local metaitem = GAMEMODE:GetItemByID( augment )
	if( metaitem and metaitem.Augment ) then
	
		for k,v in next, self.Augments do
		
			local item = GAMEMODE:GetItemByID( k );
			item.OnAugmentTaken( k, self );
			
		end
		self.Augments[augment] = nil;
		for k,v in next, self.Augments do
		
			local item = GAMEMODE:GetItemByID( k );
			item.OnAugmentSpawn( k, self );
			
		end
		net.Start( "nLoadAugments" );
			net.WriteEntity( self );
			net.WriteString( util.TableToJSON( self.Augments ) );
		net.Broadcast()
		self:SaveAugments();
	
	end

end

util.AddNetworkString( "nStartAugmentInstall" );
util.AddNetworkString( "nEndAugmentInstall" );
util.AddNetworkString( "nStartAugmentRemove" );
util.AddNetworkString( "nEndAugmentRemove" );
util.AddNetworkString( "nReceiveAugmentStart" );

local function nStartAugmentInstall( len, ply )

	local target = net.ReadEntity();
	local augment = net.ReadString();
	
	local metaitem = GAMEMODE:GetItemByID( augment );
	if( !metaitem ) then return end;
	if( !metaitem.Augment ) then return end;

	if( !ply:CanInstallAugment( target, augment ) ) then return end

	ply.AugmentTarget = target;
	ply.AugmentStart = CurTime();
	ply.Augment = augment;
	
	net.Start( "nReceiveAugmentStart" );
		net.WriteString( augment );
		net.WriteInt( GAMEMODE:CalculateInstallTime( ply, augment ), 32 );
	net.Send( target );
	
	timer.Create( "AugmentTimer"..target:CharID(), GAMEMODE:CalculateInstallTime( ply, augment ) + 2, 1, function()
	
		ply.AugmentTarget = nil;
		ply.AugmentStart = nil;
		ply.Augment = nil;
	
	end );

end
net.Receive( "nStartAugmentInstall", nStartAugmentInstall );

local function nEndAugmentInstall( len, ply )

	local target = ply.AugmentTarget;
	local start = ply.AugmentStart;
	local augment = ply.Augment;
	
	if( !ply:CanInstallAugment( target, augment ) ) then return end
	if( start + GAMEMODE:CalculateInstallTime( ply, augment ) > CurTime() ) then return end
	
	timer.Remove( "AugmentTimer"..target:CharID() );
	
	target:AddAugment( augment );
	for k,v in next, ply.Inventory[ply:GetDutyInventory()] do
	
		if( v == augment ) then
		
			ply:RemoveItem( k );
			break;
			
		end
		
	end
	ply.AugmentTarget = nil;
	ply.AugmentStart = nil;
	ply.Augment = nil;

end
net.Receive( "nEndAugmentInstall", nEndAugmentInstall );

local function nStartAugmentRemove( len, ply )

	local target = net.ReadEntity();
	local augment = net.ReadString();
	
	local metaitem = GAMEMODE:GetItemByID( augment );
	if( !metaitem ) then return end;
	if( !metaitem.Augment ) then return end;

	if( target and target:IsValid() ) then

		if( !ply:CanRemoveAugment( target, augment ) ) then return end

		ply.RemoveAugmentTarget = target;
		ply.RemoveAugmentStart = CurTime();
		ply.Augment = augment;
		
		net.Start( "nReceiveAugmentStart" );
			net.WriteString( augment );
			net.WriteInt( GAMEMODE:CalculateInstallTime( ply, augment ), 32 );
		net.Send( target );
		
		timer.Create( "RemoveAugmentTimer"..target:CharID(), GAMEMODE:CalculateInstallTime( ply, augment ) + 2, 1, function()
		
			ply.RemoveAugmentTarget = nil;
			ply.RemoveAugmentStart = nil;
			ply.Augment = nil;
		
		end );
	
	end

end
net.Receive( "nStartAugmentRemove", nStartAugmentRemove );

local function nEndAugmentRemove( len, ply )

	local target = ply.RemoveAugmentTarget;
	local start = ply.RemoveAugmentStart;
	local augment = ply.Augment;
	
	if( !ply:CanRemoveAugment( target, augment ) ) then return end
	if( start + GAMEMODE:CalculateInstallTime( ply, augment ) > CurTime() ) then return end
	
	timer.Remove( "RemoveAugmentTimer"..target:CharID() );
	
	target:RemoveAugment( augment );
	ply:GiveItem( augment, 1 );

	ply.RemoveAugmentTarget = nil;
	ply.RemoveAugmentStart = nil;
	ply.Augment = nil;

end
net.Receive( "nEndAugmentRemove", nEndAugmentRemove );

local function nRequestAugments(len, ply)
	local tbl = {}
	for k,v in next, player.GetAll() do
		tbl[v:UserID()] = util.TableToJSON(v.Augments)
	end
	
	net.Start("nReceiveAugments")
		net.WriteString(util.TableToJSON(tbl))
	net.Send(ply)
end
net.Receive("nRequestAugments", nRequestAugments)