function nCreateCharacter( len, ply )
	
	if( ply:SQLGetNumChars() >= GAMEMODE.MaxCharacters ) then return end
	
	local name = net.ReadString();
	local desc = net.ReadString();
	local titleone = net.ReadString();
	local titletwo = net.ReadString();
	local model = net.ReadString();
	local stats = util.JSONToTable( net.ReadString() );
	local traits = util.JSONToTable( net.ReadString() );
	local skin = net.ReadInt( 8 );
	local bodygroups = util.JSONToTable( net.ReadString() );
	local sum = 0;
	
	for _, v in pairs( stats ) do
		
		sum = sum + math.Round( v );
		
	end
	
	local r, err = GAMEMODE:CheckCharacterValidity( name, desc, titleone, titletwo, model, sum, traits );
	if( r ) then
		
		ply:SaveNewCharacter( name, desc, titleone, titletwo, model, traits, stats, skin, bodygroups );
		
	end
	
end
net.Receive( "nCreateCharacter", nCreateCharacter );

function nSelectCharacter( len, ply )
	
	local id = net.ReadUInt( 32 );
	
	if( ply:SQLCharExists( id ) ) then
		
		if( ply:CharID() == id ) then return end
		
		if( GAMEMODE.CurrentLocation and ply:GetCharFromID( id ).Location != GAMEMODE.CurrentLocation and !ply:IsAdmin() ) then return end
		
		ply:LoadCharacter( ply:GetCharFromID( id ) );
		
	end
	
end
net.Receive( "nSelectCharacter", nSelectCharacter );

function nDeleteCharacter( len, ply )
	
	local id = net.ReadUInt( 32 );
	
	if( ply:SQLCharExists( id ) ) then
		
		if( ply:CharID() == id ) then return end
		
		local char = ply:GetCharFromID( id );
		
		if( tonumber( char.Loan ) and tonumber( char.Loan ) > 0 ) then return end
		
		ply:DeleteCharacter( id, char.RPName );
		
	end
	
end
net.Receive( "nDeleteCharacter", nDeleteCharacter );

local allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 -'";

function nChangeRPName( len, ply )
	
	local name = net.ReadString();
	
	if( string.len( string.Trim( name ) ) <= GAMEMODE.MaxNameLength and string.len( string.Trim( name ) ) >= GAMEMODE.MinNameLength ) then
		
		if( !string.find( allowedChars, name, 1, true ) ) then
			
			ply:SetRPName( string.Trim( name ) );
			ply:UpdateCharacterField( "RPName", name );
			
		end
		
	end
	
end
net.Receive( "nChangeRPName", nChangeRPName );

function nChangeTitle( len, ply )
	
	local desc = net.ReadString();
	
	if( string.len( string.Trim( desc ) ) <= GAMEMODE.MaxDescLength ) then
		
		local charData = ply:GetCharFromID( ply:CharID() );
		local Description = util.JSONToTable( charData.Title );
		Description[ply:GetDutyInventory()] = mysqloo.Escape( string.Trim( desc ) );

		ply:SetDescription( string.Trim( desc ) );
		ply:UpdateCharacterField( "Title", util.TableToJSON( Description ), nil, true );
		
	end
	
end
net.Receive( "nChangeTitle", nChangeTitle );

function nChangeTitleOne( len, ply )

	local title = net.ReadString();
	
	if( string.len( string.Trim( title ) ) <= 128 ) then
		
		local charData = ply:GetCharFromID( ply:CharID() );
		local TitleOne = util.JSONToTable( charData.TitleOne );
		TitleOne[ply:GetDutyInventory()] = mysqloo.Escape( string.Trim( title ) );
		
		ply:SetTitleOne( string.Trim( title ) );
		ply:UpdateCharacterField( "TitleOne", util.TableToJSON( TitleOne ), nil, true );
		
	end

end
net.Receive( "nChangeTitleOne", nChangeTitleOne );

function nChangeTitleTwo( len, ply )

	local title = net.ReadString();
	
	if( string.len( string.Trim( title ) ) <= 128 ) then
		
		local charData = ply:GetCharFromID( ply:CharID() );
		local TitleTwo = util.JSONToTable( charData.TitleTwo );
		TitleTwo[ply:GetDutyInventory()] = mysqloo.Escape( string.Trim( title ) );
		
		ply:SetTitleTwo( string.Trim( title ) );
		ply:UpdateCharacterField( "TitleTwo", util.TableToJSON( TitleTwo ), nil, true );
		
	end

end
net.Receive( "nChangeTitleTwo", nChangeTitleTwo );

function nSetNewbieStatus( len, ply )
	
	local status = 1 - net.ReadBit();
	
	ply:SetNewbieStatus( status );
	ply:UpdatePlayerField( "NewbieStatus", status );
	
end
net.Receive( "nSetNewbieStatus", nSetNewbieStatus );