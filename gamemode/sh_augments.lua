local meta = FindMetaTable( "Player" );

function GM:CalculateInstallTime( ply, augment )

	local metaitem = GAMEMODE:GetItemByID( augment );
	if( metaitem ) then
	
		if( ply:Intelligence() < 5 ) then
	
			return math.Clamp( (metaitem.InstallTime or 30) + ply:Intelligence() * 2, 5, 600 );
			
		elseif( ply:Intelligence() > 5 ) then

			return math.Clamp( (metaitem.InstallTime or 30) - ply:Intelligence() * 2, 5, 600 );
		
		end
		
		return math.Clamp( (metaitem.InstallTime or 30), 5, 600 );
		
	end
	
end

function meta:CanInstallAugment( target, augment )

	if( !target or !target:IsValid() ) then return false end
	if( !target:IsPlayer() ) then return false end
	if( target == self ) then return false end
	if( !self:HasCharFlag( "Q" ) ) then return false end
	if( !self:HasItem( augment ) ) then return false end
	if( target:HasAugment( augment ) ) then return false end
	if( target:GetPos():Distance( self:GetPos() ) > 100 ) then return false end
	
	local metaitem = GAMEMODE:GetItemByID( augment );
	for k,v in next, target.Augments or {} do
	
		if( metaitem.Blacklist ) then
			
			if( metaitem.Blacklist[k] ) then return end
			
		end
		
		if( metaitem.InstallLocation ) then
		
			local item = GAMEMODE:GetItemByID( k );
			if( item.InstallLocation == metaitem.InstallLocation ) then return end
			
		end
		
		if( metaitem.Whitelist ) then
		
			if( !metaitem.Whitelist[k] ) then return end
			
		end
		
	end
	
	local found = false;
	for k,v in next, ents.FindInSphere( self:GetPos(), 150 ) do
	
		if( v:GetClass() == "cc_augdoc" ) then
		
			found = true;
			break;
			
		end
		
	end
	if( !found ) then return false end
	
	return true

end

function meta:CanRemoveAugment( target, augment )

	if( !target or !target:IsValid() ) then return false end
	if( !target:IsPlayer() ) then return false end
	if( target == self ) then return false end
	if( !self:HasCharFlag( "Q" ) ) then return false end
	if( !target:HasAugment( augment ) ) then return false end
	if( target:GetPos():Distance( self:GetPos() ) > 100 ) then return false end
	
	local metaitem = GAMEMODE:GetItemByID( augment );
	if( metaitem and metaitem.CannotRemove ) then
	
		return false
		
	end
	
	for k,v in next, target.Augments or {} do
		
		local item = GAMEMODE:GetItemByID( k );
		if( item.Whitelist ) then
		
			if( item.Whitelist[augment] ) then return false end
			
		end
		
	end
	
	local found = false;
	for k,v in next, ents.FindInSphere( self:GetPos(), 150 ) do
	
		if( v:GetClass() == "cc_augdoc" ) then
		
			found = true;
			break;
			
		end
		
	end
	if( !found ) then return false end
	
	return true

end

function meta:HasAugment( augment )
	
	if !self.Augments then return false end
	return (self.Augments[augment] ~= nil);

end