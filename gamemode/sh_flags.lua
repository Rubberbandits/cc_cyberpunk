local meta = FindMetaTable( "Player" );

GM.CombineFlags = { };
GM.CharFlags = { };

function GM:LookupCombineFlag( f )
	
	for _, v in pairs( self.CombineFlags ) do
		
		if( v.Flag == f ) then
			
			return v;
			
		end
		
	end
	
end

function GM:LookupCharFlag( f )
	
	local tab = { };
	
	for _, v in pairs( self.CharFlags ) do
		
		if( string.find( f, v.Flag ) ) then
			
			table.insert( tab, v );
			
		end
		
	end
	
	return tab;
	
end

function GM:FlagPrintName( flag )
	
	for _, v in pairs( self.CombineFlags ) do
		
		if( v.Flag == flag ) then
			
			return v.PrintName;
			
		end
		
	end
	
	for _, v in pairs( self.CharFlags ) do
		
		if( v.Flag == flag ) then
			
			return v.PrintName;
			
		end
		
	end
	
	return flag;
	
end

function GM:CharFlagPrintName( flag )
	
	for _, v in pairs( self.CharFlags ) do
		
		if( v.Flag == flag ) then
			
			return v.PrintName;
			
		end
		
	end
	
	return flag;
	
end

function meta:HasAnyCombineFlag()
	
	for _, v in pairs( GAMEMODE.CombineFlags ) do
		
		if( self:HasCombineFlag( v.Flag ) ) then return true; end
		
	end
	
	if( self:HasCharFlag( "O" ) ) then return true end
	
	return false;
	
end

function meta:CombineBuyDoors()
	
	if( GAMEMODE.OffDutyCombineCanBuyDoors ) then
		
		if( GAMEMODE:LookupCombineFlag( self:ActiveFlag() ) ) then
			
			return false;
			
		end
		
		return true;
		
	end
	
	if( self:HasAnyCombineFlag() ) then return false end
	
	return true;
	
end

function meta:HasCombineFlag( f )
	
	if( self:CombineFlag() == f ) then return true; end
	return false;
	
end

function meta:HasCharFlag( f )
	
	return (self:CharFlags():find( f ) ~= nil);
	
end

GM.PlayerFlags = {};

if( SERVER ) then

	function meta:AddFlag( szFlag )
	
		if( !isstring( szFlag ) ) then return end
		if( szFlag:find( "[^%a]" ) ) then return end
		if( self:PlayerFlags():find( szFlag ) ) then return end

		self:SetPlayerFlags( self:PlayerFlags()..szFlag );
		self:UpdatePlayerField( "PlayerFlags", self:PlayerFlags() );
		
		hook.Run( "PlayerFlagsChanged", self, szFlag );
	
	end
	
	function meta:TakeFlag( szFlag )
	
		if( !isstring( szFlag ) ) then return end
		if( szFlag:find( "[^%a]" ) ) then return end
		if( !szFlag:find( szFlag ) ) then return end
		
		self:SetPlayerFlags( self:PlayerFlags():gsub( szFlag, "" ) );
		self:UpdatePlayerField( "PlayerFlags", self:PlayerFlags() );
		
		hook.Run( "PlayerFlagsChanged", self, szFlag );
	
	end
	
	function meta:SetFlags( szFlags )

		if( !isstring( szFlags ) ) then return end
		if( szFlags:find( "[^%a]" ) ) then return end

		self:SetPlayerFlags( szFlags );
		self:UpdatePlayerField( "PlayerFlags", szFlags );
		
		hook.Run( "PlayerFlagsChanged", self, szFlags );
	
	end
	
	function meta:AddCharFlag( szFlag )
	
		if( !isstring( szFlag ) ) then return end
		if( szFlag:find( "[^%a]" ) ) then return end
		if( self:CharFlags():find( szFlag ) ) then return end

		self:SetCharFlags( self:CharFlags()..szFlag );
		self:UpdateCharacterField( "CharFlags", self:CharFlags() );
		
		hook.Run( "CharacterFlagsChanged", self, szFlag );
	
	end
	
	function meta:TakeCharFlag( szFlag )
	
		if( !isstring( szFlag ) ) then return end
		if( szFlag:find( "[^%a]" ) ) then return end
		if( !szFlag:find( szFlag ) ) then return end
		
		self:SetCharFlags( self:CharFlags():gsub( szFlag, "" ) );
		self:UpdateCharacterField( "CharFlags", self:CharFlags() );
		
		hook.Run( "CharacterFlagsChanged", self, szFlag );
	
	end
	
	function GM:PlayerFlagsChanged( ply, szFlags )
	
		for i = 0, #szFlags do
		
			if( self.PlayerFlags[szFlags[i]] ) then
			
				self.PlayerFlags[szFlags[i]].Callback( ply );
				
			end
		
		end
	
	end
	
	function GM:CharacterFlagsChanged( ply, szFlags )
	
		for i = 0, #szFlags do
		
			if( self.CharFlags[szFlags[i]] and self.CharFlags[szFlags[i]].Callback ) then
			
				self.CharFlags[szFlags[i]].Callback( ply );
				
			end
		
		end
	
	end
	
end

function meta:HasFlag( szFlag )
	
	-- since our value isnt a bool and we always want to use it as a bool
	-- compare to nil
	return (self:PlayerFlags():find( szFlag ) ~= nil);

end

local files = file.Find( GM.FolderName .. "/gamemode/combineflags/*.lua", "LUA", "namedesc" );

if( #files > 0 ) then

	for _, v in pairs( files ) do
		
		FLAG = { };
		FLAG.PrintName 		= "";
		FLAG.Flag 			= "";
		FLAG.Color			= Color( 255, 255, 255, 255 );
		FLAG.ItemLoadout 	= { };
		FLAG.ModelFunc 		= function( ply ) return ply.CharModel; end
		FLAG.CanSpawn		= true;
		FLAG.CanBroadcast	= true;
		
		AddCSLuaFile( "combineflags/" .. v );
		include( "combineflags/" .. v );
		
		table.insert( GM.CombineFlags, FLAG );
		
		MsgC( Color( 200, 200, 200, 255 ), "Police flag " .. v .. " loaded.\n" );
		
	end
	
else
	
	if( SERVER ) then
		
		GM:LogBug( "Warning: No police flags found.", true );
		
	end
	
end

local files = file.Find( GM.FolderName .. "/gamemode/charflags/*.lua", "LUA", "namedesc" );

if( #files > 0 ) then

	for _, v in pairs( files ) do
		
		FLAG = { };
		FLAG.PrintName 		= "";
		FLAG.Flag 			= "";
		FLAG.Color			= Color( 255, 255, 255, 255 );
		FLAG.Loadout 		= { };
		FLAG.ItemLoadout 	= { };
		FLAG.ModelFunc 		= function( ply ) return ply.CharModel; end
		FLAG.OnSpawn 		= function( ply ) end
		
		AddCSLuaFile( "charflags/" .. v );
		include( "charflags/" .. v );
		
		table.insert( GM.CharFlags, FLAG );
		
		MsgC( Color( 200, 200, 200, 255 ), "Character flag " .. v .. " loaded.\n" );
		
	end
	
else
	
	if( SERVER ) then
		
		GM:LogBug( "Warning: No character flags found.", true );
		
	end
	
end