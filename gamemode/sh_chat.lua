local meta = FindMetaTable( "Player" );
CC = { }; -- Table of chat command functions.

if( SERVER ) then
	
	function nSay( len, ply )
		
		ply:SetTyping( 0 );
		
		if( !ply.LastChat ) then ply.LastChat = 0 end
		if( CurTime() - ply.LastChat < 0.05 ) then return end
		ply.LastChat = CurTime();
		
		local text = net.ReadString();
		
		if( string.len( text ) > 500 ) then
			
			return;
			
		end
		
		GAMEMODE:OnChat( ply, text );
		
	end
	net.Receive( "nSay", nSay );
	
	function nChangeRadio( len, ply )
		
		if( GAMEMODE:LookupCombineFlag( ply:ActiveFlag() ) ) then return end
		
		if( !ply:HasItem( "radio" ) ) then return end
		
		local val = net.ReadFloat();
		
		if( val >= 0 ) then
			
			if( val <= 999 ) then
				
				ply:SetRadioFreq( val );
				
			end
			
		end
		
	end
	net.Receive( "nChangeRadio", nChangeRadio );
	
else
	
	function nConSay( len )
		
		local str = net.ReadString();
		GAMEMODE:AddChat( Color( 255, 0, 0, 255 ), "CombineControl.ChatNormal", "Console: " .. str, { CB_ALL, CB_OOC } );
		
	end
	net.Receive( "nConSay", nConSay );
	
	function nChatLocal( len )
		
		local ply = net.ReadEntity();
		local str = net.ReadString();
		
		GAMEMODE:ChatLocal( ply, str );
		
	end
	net.Receive( "nChatLocal", nChatLocal );
	
	function nChatYell( len )
		
		local ply = net.ReadEntity();
		local str = net.ReadString();
		
		CC.Yell( ply, str );
		
	end
	net.Receive( "nChatYell", nChatYell );
	
	function nChatWhisper( len )
		
		local ply = net.ReadEntity();
		local str = net.ReadString();
		
		CC.Whisper( ply, str );
		
	end
	net.Receive( "nChatWhisper", nChatWhisper );
	
	function nChatMe( len )
		
		local ply = net.ReadEntity();
		local str = net.ReadString();
		
		CC.Me( ply, str, true );
		
	end
	net.Receive( "nChatMe", nChatMe );
	
	function nChatIt( len )
		
		local ply = net.ReadEntity();
		local str = net.ReadString();
		
		CC.It( ply, str );
		
	end
	net.Receive( "nChatIt", nChatIt );
	
	function nChatAn( len )
		
		local ply = net.ReadEntity();
		local str = net.ReadString();
		
		CC.An( ply, str );
		
	end
	net.Receive( "nChatAn", nChatAn );
	
	function nChatOOC( len )
		
		local ply = net.ReadEntity();
		local str = net.ReadString();
		
		CC.OOC( ply, str, true );
		
	end
	net.Receive( "nChatOOC", nChatOOC );
	
	function nChatLOOC( len )
		
		local ply = net.ReadEntity();
		local str = net.ReadString();
		
		CC.LOOC( ply, str );
		
	end
	net.Receive( "nChatLOOC", nChatLOOC );
	
	function nChatAdmin( len )
		
		local ply = net.ReadEntity();
		local str = net.ReadString();
		
		CC.Admin( ply, str );
		
	end
	net.Receive( "nChatAdmin", nChatAdmin );
	
	function nChatPM( len )
		
		local name = net.ReadString();
		local tname = net.ReadString();
		local str = net.ReadString();
		local mode = net.ReadBit();
		
		local text = "[PM to " .. tname .. "] " .. name .. ": " .. str;
		
		if( mode == 0 ) then
			
			text = "[PM to " .. tname .. "]: " .. str;
			
		else
			
			text = "[PM from " .. name .. "]: " .. str;
			
		end
		
		GAMEMODE:AddChat( Color( 255, 183, 58, 255 ), "CombineControl.ChatNormal", text, { CB_ALL, CB_OOC } );
		
	end
	net.Receive( "nChatPM", nChatPM );
	
	function nChatRadioDeath( len )
		
		local ply = net.ReadEntity();
		GAMEMODE:AddChat( Color( 160, 160, 160, 255 ), "CombineControl.ChatRadio", "[Radio] " .. string.Replace( GAMEMODE.CombineDeathLine, "$COMBINENAME", ply:VisibleRPName() ), { CB_ALL, CB_IC } );
		
	end
	net.Receive( "nChatRadioDeath", nChatRadioDeath );
	
	function nChatRadio( len )
		
		local ply = net.ReadEntity();
		local str = net.ReadString();
		
		CC.Radio( ply, str );
		
	end
	net.Receive( "nChatRadio", nChatRadio );
	
	function nChatPDAGlobal( len )
		
		local ply = net.ReadEntity();
		local str = net.ReadString();
		
		CC.PDAGlobal( ply, str );
		
	end
	net.Receive( "nChatPDAGlobal", nChatPDAGlobal );
	
	function nChatPDAPrivate( len )
		
		local name = net.ReadString();
		local tname = net.ReadString();
		local str = net.ReadString();
		local mode = net.ReadBit();
		
		local text = "[PDA to " .. tname .. "] " .. name .. ": " .. str;
		
		if( mode == 0 ) then
			
			text = "[PDA to " .. tname .. "]: " .. str;
			
		else
			
			text = "[PDA from " .. name .. "]: " .. str;
			
		end
		
		GAMEMODE:AddChat( Color( 255, 0, 255, 255 ), "CombineControl.ChatNormal", text, { CB_ALL, CB_IC } );
		
	end
	net.Receive( "nChatPDAPrivate", nChatPDAPrivate );
	
	function nChatBigRadio( len )
		
		local ply = net.ReadEntity();
		local str = net.ReadString();
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		
		GAMEMODE:AddChat( Color( 128, 128, 128, 255 ), "CombineControl.ChatRadio", "[Stationary Radio] " .. name .. ": " .. str, { CB_ALL, CB_IC } );
		
	end
	net.Receive( "nChatBigRadio", nChatBigRadio );
	
	function nChatRadioSurround( len )
		
		local ply = net.ReadEntity();
		local str = net.ReadString();
		
		CC.Radio( ply, str, true );
		
	end
	net.Receive( "nChatRadioSurround", nChatRadioSurround );
	
	function nChatDispatch( len )
		
		local ply = net.ReadEntity();
		local str = net.ReadString();
		
		CC.Dispatch( ply, str );
		
	end
	net.Receive( "nChatDispatch", nChatDispatch );
	
	function nChatCRDevice( len )
		
		local ply = net.ReadEntity();
		local str = net.ReadString();
		
		CC.CR( ply, str );
		
	end
	net.Receive( "nChatCRDevice", nChatCRDevice );
	
	function nChatCRDeviceSurround( len )
		
		local ply = net.ReadEntity();
		local str = net.ReadString();
		
		CC.CR( ply, str, true );
		
	end
	net.Receive( "nChatCRDeviceSurround", nChatCRDeviceSurround );
	
	function nChatBroadcast( len )
		
		local ply = net.ReadEntity();
		local str = net.ReadString();
		
		CC.Broadcast( ply, str );
		
	end
	net.Receive( "nChatBroadcast", nChatBroadcast );
	
	function nChatEvent( len )
		
		local ply = net.ReadEntity();
		local str = net.ReadString();
		
		CC.Event( ply, str );
		
	end
	net.Receive( "nChatEvent", nChatEvent );
	
	function nChatAdvertise( len )
		
		local ply = net.ReadEntity();
		local str = net.ReadString();
		
		CC.Advertise( ply, str, true );
		
	end
	net.Receive( "nChatAdvertise", nChatAdvertise );
	
	function nRoll( len )
		
		local ply = net.ReadEntity();
		local val = net.ReadUInt( 7 );
		
		CC.Roll( ply, nil, val );
		
	end
	net.Receive( "nRoll", nRoll );
	
	function nCIDTooLow( len )
		
		GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: ID number must be greater than zero.", { CB_ALL, CB_OOC } );
		
	end
	net.Receive( "nCIDTooLow", nCIDTooLow );
	
	function nCIDTooHigh( len )
		
		GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: ID number must be under six digits.", { CB_ALL, CB_OOC } );
		
	end
	net.Receive( "nCIDTooHigh", nCIDTooHigh );
	
	function nCIDNumber( len )
		
		GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: ID number must be a number.", { CB_ALL, CB_OOC } );
		
	end
	net.Receive( "nCIDNumber", nCIDNumber );
	
end

GM.ChatCommands = { };

function GM:AddChatCommand( text, color, func )
	
	table.insert( self.ChatCommands, { text, color, func } );
	
end

function GM:StringHasCommand( str )
	
	local tab = self.ChatCommands;
	
	table.sort( tab, function( a, b )
		
		return string.len( a[1] ) > string.len( b[1] );
		
	end );
	
	for _, v in pairs( self.ChatCommands ) do
		
		if( str ) then
			
			if( string.find( string.lower( str ), string.lower( v[1] ), nil, true ) == 1 ) then
				
				return v;
				
			end
			
		end
		
	end
	
	return false;
	
end

function meta:GetRF( maxd, muffled, inclself )
	
	local rf = { };
	
	for _, v in pairs( player.GetAll() ) do
		
		if( v != self or inclself ) then
			
			local dist = maxd;
			
			if( maxd != muffled and !self:CanHear( v ) ) then
				
				dist = muffled;
				
			end
			
			if( v:GetPos():Distance( self:GetPos() ) < dist ) then
				
				table.insert( rf, v );
				
			end
			
		end
		
	end
	
	return rf;
	
end

function GM:OnChat( ply, text )
	
	local cc = self:StringHasCommand( text );
	
	if( cc ) then
		
		local f = string.Trim( string.sub( text, string.len( cc[1] ) + 1 ) );
		local ret = cc[3]( ply, f );
		
		if( ret ) then
			
			GAMEMODE.NextChatText = text;
			
		end
		
	else
		
		self:ChatLocal( ply, text );
		
	end
	
end

function GM:ChatLocal( ply, arg )
	
	if( string.len( arg ) == 0 ) then return end
	
	if( !ply:Alive() ) then
		
		if( CLIENT ) then
			
			self:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're dead. You can't talk.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( ply:PassedOut() ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're unconscious. You can't talk.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( ply:HasCharFlag( "S" ) ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're a stalker. You have no mouth.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( ply:HasTrait( TRAIT_FOREIGNER ) ) then
	
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You don't speak the local language.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( SERVER ) then
		
		local rf = ply:GetRF( 400, 150 );
		
		net.Start( "nChatLocal" );
			net.WriteEntity( ply );
			net.WriteString( arg );
		net.Send( rf );
		
		local name = ply:VisibleRPName();
		
		GAMEMODE:LogChat( "[ ] " .. name .. ": " .. arg, ply );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		self:AddChat( Color( 114, 160, 193, 255 ), "CombineControl.ChatNormal", name .. ": " .. arg, { CB_ALL, CB_IC }, nil, ply );
		
	end
	
end

function CC.Yell( ply, arg )
	
	if( string.len( arg ) == 0 ) then return end
	
	if( !ply:Alive() ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're dead. You can't talk.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( ply:PassedOut() ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're unconscious. You can't talk.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( ply:HasCharFlag( "S" ) ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're a stalker. You have no mouth.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( ply:HasTrait( TRAIT_FOREIGNER ) ) then
	
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You don't speak the local language.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( SERVER ) then
		
		local rf = ply:GetRF( 1000, 800 );
		
		net.Start( "nChatYell" );
			net.WriteEntity( ply );
			net.WriteString( arg );
		net.Send( rf );
		
		local name = ply:VisibleRPName();
		GAMEMODE:LogChat( "[Y] " .. name .. ": " .. arg, ply );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatBig", "[YELL] " .. name .. ": " .. arg, { CB_ALL, CB_IC }, nil, ply );
		
	end
	
end
GM:AddChatCommand( "/y", Color( 200, 0, 0, 255 ), CC.Yell );

function CC.Whisper( ply, arg )
	
	if( string.len( arg ) == 0 ) then return end
	
	if( !ply:Alive() ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're dead. You can't talk.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( ply:PassedOut() ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're unconscious. You can't talk.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( ply:HasCharFlag( "S" ) ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're a stalker. You have no mouth.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( ply:HasTrait( TRAIT_FOREIGNER ) ) then
	
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You don't speak the local language.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( SERVER ) then
		
		local rf = ply:GetRF( 150, 0 );
		
		net.Start( "nChatWhisper" );
			net.WriteEntity( ply );
			net.WriteString( arg );
		net.Send( rf );
		
		local name = ply:VisibleRPName();
		GAMEMODE:LogChat( "[W] " .. name .. ": " .. arg, ply );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatSmall", "[WHISPER] " .. name .. ": " .. arg, { CB_ALL, CB_IC }, nil, ply );
		
	end
	
end
GM:AddChatCommand( "/w", Color( 200, 200, 200, 255 ), CC.Whisper );

function CC.Me( ply, arg, others )
	
	if( string.len( arg ) == 0 ) then return end
	
	if( SERVER ) then
		
		local rf = ply:GetRF( 400, 150 );
		
		net.Start( "nChatMe" );
			net.WriteEntity( ply );
			net.WriteString( arg );
		net.Send( rf );
		
		local name = ply:VisibleRPName();
		GAMEMODE:LogChat( "[M] " .. name .. " " .. arg, ply );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		GAMEMODE:AddChat( Color( 114, 160, 193, 255 ), "CombineControl.ChatNormalItalic", name .. " " .. arg, { CB_ALL, CB_IC }, nil, ply );
		
	end
	
end
GM:AddChatCommand( "/me", Color( 114, 160, 193, 255 ), CC.Me );
GM:AddChatCommand( "/e", Color( 114, 160, 193, 255 ), CC.Me );

function CC.LMe( ply, arg, others )
	
	if( string.len( arg ) == 0 ) then return end
	
	if( SERVER ) then
		
		local rf = ply:GetRF( 1000, 300 );
		netstream.Start( rf, "nChatLMe", ply, arg );
		
		local name = ply:VisibleRPName();
		GAMEMODE:LogChat( "[LM] " .. name .. " " .. arg, ply );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		GAMEMODE:AddChat( Color( 114, 160, 193, 255 ), "CombineControl.ChatNormal", "** " .. name .. arg, { CB_ALL, CB_IC }, nil, ply );
		
	end
	
end
GM:AddChatCommand( "/lme", Color( 114, 160, 193, 255 ), CC.LMe );

function CC.It( ply, arg )
	
	if( string.len( arg ) == 0 ) then return end
	
	if( SERVER ) then
		
		local rf = ply:GetRF( 400, 150 );
		
		net.Start( "nChatIt" );
			net.WriteEntity( ply );
			net.WriteString( arg );
		net.Send( rf );
		
		local name = ply:VisibleRPName();
		GAMEMODE:LogChat( "[I] (" .. name .. ") " .. arg, ply );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		GAMEMODE:AddChat( Color( 114, 160, 193, 255 ), "CombineControl.ChatNormalItalic", arg, { CB_ALL, CB_IC }, "(" .. name .. ") " );
		
	end
	
end
GM:AddChatCommand( "/it", Color( 114, 160, 193, 255 ), CC.It );

function CC.LIt( ply, arg )
	
	if( string.len( arg ) == 0 ) then return end
	
	if( SERVER ) then
		
		local rf = ply:GetRF( 1000, 300 );
		netstream.Start( rf, "nChatLIt", ply, arg );
		
		local name = ply:VisibleRPName();
		GAMEMODE:LogChat( "[I] (" .. name .. ") " .. arg, ply );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		GAMEMODE:AddChat( Color( 114, 160, 193, 255 ), "CombineControl.ChatNormal", "** " .. arg, { CB_ALL, CB_IC }, "(" .. name .. ") " );
		
	end
	
end
GM:AddChatCommand( "/lit", Color( 114, 160, 193, 255 ), CC.LIt );

function CC.OOC( ply, arg, other )
	
	if( string.len( arg ) == 0 ) then return end
	
	if( !other and ply.LastOOC and CurTime() < ply.LastOOC + GAMEMODE:OOCDelay() ) then
		
		if( !ply:IsAdmin() ) then
			
			if( CLIENT ) then
				
				GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "Wait " .. tostring( math.Round( ply.LastOOC + GAMEMODE:OOCDelay() - CurTime() ) ) .. " seconds to talk in OOC.", { CB_ALL, CB_OOC } );
				
			end
			
			return true;
			
		end
		
	end
	
	ply.LastOOC = CurTime();
	
	if( SERVER ) then
		
		local rf = { };
		
		for _, v in pairs( player.GetAll() ) do
			
			if( v != ply ) then
				
				table.insert( rf, v );
				
			end
			
		end
		
		net.Start( "nChatOOC" );
			net.WriteEntity( ply );
			net.WriteString( arg );
		net.Send( rf );
		
		local name = ply:VisibleRPName();
		GAMEMODE:LogChat( "[O] " .. name .. ": " .. arg, ply );
		
		MsgC( Color( 50, 150, 255, 255 ), "[OOC] " .. name .. ": " .. arg .. "\n" );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		GAMEMODE:AddChat( Color( 50, 150, 255, 255 ), "CombineControl.ChatNormal", "[OOC] " .. name .. ": " .. arg, { CB_ALL, CB_OOC } );
		
	end
	
end
GM:AddChatCommand( "//", Color( 50, 150, 255, 255 ), CC.OOC );

function CC.LOOC( ply, arg )
	
	if( string.len( arg ) == 0 ) then return end
	
	if( SERVER ) then
		
		local rf = ply:GetRF( 400, 150 );
		
		net.Start( "nChatLOOC" );
			net.WriteEntity( ply );
			net.WriteString( arg );
		net.Send( rf );
		
		local name = ply:VisibleRPName();
		GAMEMODE:LogChat( "[L] " .. name .. ": " .. arg, ply );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		GAMEMODE:AddChat( Color( 50, 200, 255, 255 ), "CombineControl.ChatNormal", "[LOOC] " .. name .. ": " .. arg, { CB_ALL, CB_OOC } );
		
	end
	
end
GM:AddChatCommand( ".//", Color( 50, 200, 255, 255 ), CC.LOOC );
GM:AddChatCommand( "[[", Color( 50, 200, 255, 255 ), CC.LOOC );

function CC.Admin( ply, arg )
	
	if( string.len( arg ) == 0 ) then return end
	
	if( SERVER ) then
		
		local rf = { };
		
		for _, v in pairs( player.GetAll() ) do
			
			if( v != ply and ( v:IsAdmin() or v:IsEventCoordinator() ) ) then
				
				table.insert( rf, v );
				
			end
			
		end
		
		net.Start( "nChatAdmin" );
			net.WriteEntity( ply );
			net.WriteString( arg );
		net.Send( rf );
		
		local name = ply:VisibleRPName();
		GAMEMODE:LogChat( "[A] " .. name .. ": " .. arg, ply );
		
		MsgC( Color( 198, 51, 51, 255 ), "[ADMIN] " .. name .. ": " .. arg .. "\n" );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		GAMEMODE:AddChat( Color( 198, 51, 51, 255 ), "CombineControl.ChatNormal", "[ADMIN] " .. name .. ": " .. arg, { CB_ALL, CB_OOC } );
		
	end
	
end
GM:AddChatCommand( "/a", Color( 198, 51, 51, 255 ), CC.Admin );

function CC.PDAGlobal( ply, arg )

	if( string.len( arg ) == 0 ) then return end
	
	if( SERVER ) then
		
		if( !ply:HasItem( "pda" ) ) then return end
		
		local rf = { };
		
		for _, v in pairs( player.GetAll() ) do
			
			if( v != ply and v:HasItem( "pda" ) ) then
				
				table.insert( rf, v );
				
			end
			
		end
		
		net.Start( "nChatPDAGlobal" );
			net.WriteEntity( ply );
			net.WriteString( arg );
		net.Send( rf );
		
		local name = ply:PDAName().." ("..ply:VisibleRPName()..")";
		GAMEMODE:LogChat( "[PDA-G] " .. name .. ": " .. arg, ply );
		
		MsgC( Color( 255, 0, 255, 255 ), "[PDA-G] " .. name .. ": " .. arg .. "\n" );
		
	else
		
		if( !LocalPlayer():HasItem( "pda" ) ) then return end
		if( !ply.PDAName ) then return end
		
		local name = ply:PDAName();
		GAMEMODE:AddChat( Color( 255, 0, 255, 255 ), "CombineControl.ChatNormal", "[PDA-G] " .. name .. ": " .. arg, { CB_ALL, CB_IC } );
		
	end
	
end
GM:AddChatCommand( "/gpda", Color( 255, 0, 255, 255 ), CC.PDAGlobal );

if( CLIENT ) then

	local function nPlayerNotFound( len )
	
		GAMEMODE:AddChat( Color( 255, 0, 255, 255 ), "CombineControl.ChatNormal", "[PDA - ERR 0x0000008] Cannot find an online user by that username.", { CB_ALL, CB_IC } );
	
	end
	net.Receive( "nPlayerNotFound", nPlayerNotFound );

else

	util.AddNetworkString( "nPlayerNotFound" );

end

function CC.PDAPrivate( ply, arg )
	
	if( string.len( arg ) == 0 ) then return end
	if( !ply:HasItem( "pda" ) ) then return end
	
	if( SERVER ) then
		
		local targ = string.Explode( " ", arg )[1];
		local tply;
		for k,v in next, player.GetAll() do
		
			if( v != ply and v:CharID() > 0 ) then
			
				if( v:PDAName():find( targ ) and v:HasItem( "pda" ) ) then
				
					tply = v;
					
				end
				
			end
			
		end
		
		if( tply ) then
			
			net.Start( "nChatPDAPrivate" );
				net.WriteString( ply:PDAName() );
				net.WriteString( tply:PDAName() );
				net.WriteString( string.sub( arg, string.len( targ ) + 2 ) );
				net.WriteBit( true );
			net.Send( tply );
			
		else
			
			net.Start( "nPlayerNotFound" );
			net.Send( ply );
			return;
			
		end
		
		net.Start( "nChatPDAPrivate" );
			net.WriteString( ply:PDAName() );
			net.WriteString( tply:PDAName() );
			net.WriteString( string.sub( arg, string.len( targ ) + 2 ) );
			net.WriteBit( false );
		net.Send( ply );
		
		local name = ply:PDAName();
		local tname = tply:PDAName();
		GAMEMODE:LogChat( "[PDA] (" .. name .. ") [PDA to " .. tname .. "]: " .. arg, ply );
		
	end
	
end
GM:AddChatCommand( "/pda", Color( 255, 0, 255, 255 ), CC.PDAPrivate );

function CC.PM( ply, arg )
	
	if( string.len( arg ) == 0 ) then return end
	
	if( SERVER ) then
		
		local targ = string.Explode( " ", arg )[1];
		local tply = GAMEMODE:FindPlayer( targ, ply );
		
		if( tply ) then
			
			net.Start( "nChatPM" );
				net.WriteString( ply:VisibleRPName() );
				net.WriteString( tply:VisibleRPName() );
				net.WriteString( string.sub( arg, string.len( targ ) + 2 ) );
				net.WriteBit( true );
			net.Send( tply );
			
		else
			
			return;
			
		end
		
		net.Start( "nChatPM" );
			net.WriteString( ply:VisibleRPName() );
			net.WriteString( tply:VisibleRPName() );
			net.WriteString( string.sub( arg, string.len( targ ) + 2 ) );
			net.WriteBit( false );
		net.Send( ply );
		
		local name = ply:VisibleRPName();
		local tname = tply:VisibleRPName();
		GAMEMODE:LogChat( "[P] (" .. name .. ") [PM to " .. tname .. "]: " .. arg, ply );
		
	end
	
end
GM:AddChatCommand( "/pm", Color( 255, 183, 58, 255 ), CC.PM );

function CC.CanRadio( ply )
	
	local tr = GAMEMODE:GetHandTrace( ply, 128 );
	
	if( tr.Entity and tr.Entity:IsValid() and tr.Entity:GetClass() == "cc_radio" ) then
		
		return true, tr.Entity:GetChannel(), tr.Entity;
		
	end
	
	if( ply:HasItem( "radio" ) ) then
		
		return true, ply:RadioFreq();
		
	end
	
	return false;
	
end

function CC.Radio( ply, arg, norad )
	
	if( string.len( arg ) == 0 ) then return end
	
	local can, channel, ent = CC.CanRadio( ply );
	
	if( CLIENT and ply == LocalPlayer() and !can ) then
		
		GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You need a radio for this.", { CB_ALL, CB_IC } );
		return;
		
	end
	
	if( !ply:Alive() ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're dead. You can't talk.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( ply:PassedOut() ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're unconscious. You can't talk.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( ply:HasCharFlag( "S" ) ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're a stalker. You have no mouth.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( ply:HasTrait( TRAIT_FOREIGNER ) ) then
	
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You don't speak the local language.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( SERVER ) then
		
		if( !can ) then
			
			return;
			
		end
		
		if( !ent ) then
			
			local rf = ply:GetRF( 400, 150 );
			
			net.Start( "nChatRadioSurround" );
				net.WriteEntity( ply );
				net.WriteString( arg );
			net.Send( rf );
			
			local rf = { };
			
			for _, v in pairs( player.GetAll() ) do
				
				if( channel == v:RadioFreq() and ply != v and v:HasItem( "radio" ) ) then
					
					table.insert( rf, v );
					
				end
				
			end
			
			net.Start( "nChatRadio" );
				net.WriteEntity( ply );
				net.WriteString( arg );
			net.Send( rf );
			
			local rf = { };
			
			for _, v in pairs( ents.FindByClass( "cc_radio" ) ) do
				
				if( channel == v:GetChannel() ) then
					
					for _, n in pairs( player.GetAll() ) do
						
						local dist = 400;
						
						if( !n:CanHear( v ) ) then
							
							dist = 150;
							
						end
						
						if( n:GetPos():Distance( v:GetPos() ) < dist ) then
							
							table.insert( rf, n );
							
						end
						
					end
					
				end
				
			end
			
			net.Start( "nChatBigRadio" );
				net.WriteEntity( ply );
				net.WriteString( arg );
			net.Send( rf );
			
		else
			
			local rf = { };
			
			for _, v in pairs( player.GetAll() ) do
				
				if( channel == v:RadioFreq() and ply != v and v:HasItem( "radio" ) ) then
					
					table.insert( rf, v );
					
				end
				
			end
			
			net.Start( "nChatRadio" );
				net.WriteEntity( ply );
				net.WriteString( arg );
			net.Send( rf );
			
			local rf = { };
			
			for _, v in pairs( ents.FindByClass( "cc_radio" ) ) do
				
				if( channel == v:GetChannel() ) then
					
					for _, n in pairs( player.GetAll() ) do
						
						local dist = 400;
						
						if( !n:CanHear( v ) ) then
							
							dist = 150;
							
						end
						
						if( n:GetPos():Distance( v:GetPos() ) < dist ) then
							
							table.insert( rf, n );
							
						end
						
					end
					
				end
				
			end
			
			net.Start( "nChatBigRadio" );
				net.WriteEntity( ply );
				net.WriteString( arg );
			net.Send( rf );
			
		end
		
		local name = ply:VisibleRPName();
		GAMEMODE:LogChat( "[R] (" .. tostring( channel ) .. ") " .. name .. ": " .. arg, ply );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		
		if( norad ) then
		
			if( !ent ) then

				GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", name .. ": " .. arg, { CB_ALL, CB_IC } );
				
			end
			
		else
			
			if( ( ply == LocalPlayer() and !ent ) or ply != LocalPlayer() ) then
				
				GAMEMODE:AddChat( Color( 160, 160, 160, 255 ), "CombineControl.ChatRadio", "[Radio] " .. name .. ": " .. arg, { CB_ALL, CB_IC, CB_RADIO } );
				
			end
			
		end
		
	end
	
end
GM:AddChatCommand( "/r", Color( 160, 160, 160, 255 ), CC.Radio );
GM:AddChatCommand( "/radio", Color( 160, 160, 160, 255 ), CC.Radio );

function CC.Dispatch( ply, arg, norad )
	
	if( string.len( arg ) == 0 ) then return end
	
	local can, channel, ent = CC.CanRadio( ply );
	
	if( CLIENT and ply == LocalPlayer() and !can ) then
		
		GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You need a radio for this.", { CB_ALL, CB_IC } );
		return;
		
	end
	
	if( !ply:Alive() ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're dead. You can't talk.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( ply:PassedOut() ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're unconscious. You can't talk.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( ply:HasCharFlag( "S" ) ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're a stalker. You have no mouth.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( !GAMEMODE:LookupCombineFlag( ply:CombineFlag() ).CanUseDispatch ) then
	
		if( CLIENT ) then
		
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You cannot use dispatch radio.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( SERVER ) then
		
		if( !can ) then
			
			return;
			
		end
		
		if( !ent ) then
			
			local rf = { };
			
			for _, v in pairs( player.GetAll() ) do
				
				if( channel == v:RadioFreq() and ply != v and v:HasItem( "radio" ) ) then
					
					table.insert( rf, v );
					
				end
				
			end
			
			net.Start( "nChatDispatch" );
				net.WriteEntity( ply );
				net.WriteString( arg );
			net.Send( rf );
			
		else
			
			local rf = { };
			
			for _, v in pairs( player.GetAll() ) do
				
				if( channel == v:RadioFreq() and ply != v and v:HasItem( "radio" ) ) then
					
					table.insert( rf, v );
					
				end
				
			end
			
			net.Start( "nChatDispatch" );
				net.WriteEntity( ply );
				net.WriteString( arg );
			net.Send( rf );
			
		end
		
		local name = ply:VisibleRPName();
		GAMEMODE:LogChat( "[R] [DISPATCH] (" .. tostring( channel ) .. ") " .. name .. ": " .. arg, ply );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		
		if( norad ) then
			
		else
			
			if( ( ply == LocalPlayer() and !ent ) or ply != LocalPlayer() ) then
				
				GAMEMODE:AddChat( Color( 160, 160, 160, 255 ), "CombineControl.ChatRadio", "[Radio] DISPATCH: " .. arg, { CB_ALL, CB_IC, CB_RADIO } );
				
			end
			
		end
		
	end
	
end
GM:AddChatCommand( "/dispatch", Color( 160, 160, 160, 255 ), CC.Dispatch );
GM:AddChatCommand( "/dis", Color( 160, 160, 160, 255 ), CC.Dispatch );

function CC.CR( ply, arg, norad )
	
	if( string.len( arg ) == 0 ) then return end
	
	if( SERVER and !ply:HasItem( "crdevice" ) ) then
		
		return;
		
	end
	
	if( !ply:Alive() ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're dead. You can't talk.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( ply:PassedOut() ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're unconscious. You can't talk.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( ply:HasCharFlag( "S" ) ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're a stalker. You have no mouth.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( SERVER ) then
		
		local rf = ply:GetRF( 400, 150 );
		
		net.Start( "nChatCRDeviceSurround" );
			net.WriteEntity( ply );
			net.WriteString( arg );
		net.Send( rf );
		
		local rf = { };
		
		for _, v in pairs( player.GetAll() ) do
			
			if( v:Team() == TEAM_COMBINE or v:Team() == TEAM_OFFCOMBINE ) then
				
				table.insert( rf, v );
				
			end
			
		end
		
		net.Start( "nChatCRDevice" );
			net.WriteEntity( ply );
			net.WriteString( arg );
		net.Send( rf );
		
		local name = ply:VisibleRPName();
		GAMEMODE:LogChat( "[C] " .. name .. ": " .. arg, ply );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		
		if( norad ) then
			
			GAMEMODE:AddChat( Color( 140, 140, 180, 255 ), "CombineControl.ChatRadio", name .. ": " .. arg, { CB_ALL, CB_IC }, nil, ply );
			
		else
			
			GAMEMODE:AddChat( Color( 140, 140, 180, 255 ), "CombineControl.ChatRadio", "[Request] " .. name .. ": " .. arg, { CB_ALL, CB_IC } );
			
		end
		
	end
	
end
GM:AddChatCommand( "/cr", Color( 140, 140, 180, 255 ), CC.CR );

function CC.Broadcast( ply, arg )
	
	if( string.len( arg ) == 0 ) then return end
	
	if( !ply:Alive() ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're dead. You can't talk.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( ply:PassedOut() ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're unconscious. You can't talk.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( ply:HasCharFlag( "S" ) ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're a stalker. You have no mouth.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( ply:Team() != TEAM_COMBINE ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You can only broadcast while on-duty.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( !GAMEMODE:LookupCombineFlag( ply:ActiveFlag() ) or !GAMEMODE:LookupCombineFlag( ply:ActiveFlag() ).CanBroadcast ) then
		
		if( CLIENT and ply == LocalPlayer() ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're not a high enough rank to broadcast.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( SERVER ) then
		
		local rf = ply:GetRF( math.huge, math.huge );
		
		net.Start( "nChatBroadcast" );
			net.WriteEntity( ply );
			net.WriteString( arg );
		net.Send( rf );
		
		local name = ply:VisibleRPName();
		GAMEMODE:LogChat( "[B] (" .. name .. ") " .. arg, ply );
		
		MsgC( Color( 255, 118, 50, 255 ), "(" .. name .. ") " .. "[BROADCAST] " .. arg .. "\n" );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		GAMEMODE:AddChat( Color( 255, 118, 50, 255 ), "CombineControl.ChatNormal", "[BROADCAST] " .. arg, { CB_ALL, CB_IC }, "(" .. name .. ") " );
		
	end
	
end
GM:AddChatCommand( "/bc", Color( 255, 118, 50, 255 ), CC.Broadcast );

function CC.Event( ply, arg )
	
	if( string.len( arg ) == 0 ) then return end
	
	if( !ply:IsAdmin() and !ply:IsEventCoordinator() ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You need to be an admin to do this.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( SERVER ) then
		
		local rf = ply:GetRF( math.huge, math.huge );
		
		net.Start( "nChatEvent" );
			net.WriteEntity( ply );
			net.WriteString( arg );
		net.Send( rf );
		
		local name = ply:VisibleRPName();
		GAMEMODE:LogChat( "[E] (" .. name .. ") " .. arg, ply );
		
		MsgC( Color( 114, 160, 193, 255 ), "(" .. name .. ") " .. arg .. "\n" );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		GAMEMODE:AddChat( Color( 114, 160, 193, 255 ), "CombineControl.ChatBigItalic", arg, { CB_ALL, CB_IC }, "(" .. name .. ") " );
		
	end
	
end
GM:AddChatCommand( "/ev", Color( 114, 160, 193, 255 ), CC.Event );

function CC.LocalEvent( ply, arg )
	
	if( string.len( arg ) == 0 ) then return end
	
	if( !ply:IsAdmin() and !ply:IsEventCoordinator() ) then
		
		if( CLIENT ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You need to be an admin to do this.", { CB_ALL, CB_IC } );
			
		end
		
		return;
		
	end
	
	if( SERVER ) then
		
		local rf = ply:GetRF( 1500, 1500 );
		netstream.Start( rf, "nChatLEvent", ply, arg );
		
		local name = ply:VisibleRPName();
		GAMEMODE:LogChat( "[LEV] (" .. name .. ") " .. arg, ply );
		
		MsgC( Color( 200, 100, 50, 255 ), "(" .. name .. ") " .. arg .. "\n" );
		
	else
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		GAMEMODE:AddChat( Color( 114, 160, 193, 255 ), "CombineControl.ChatHuge", "[L-EVENT] " .. arg, { CB_ALL, CB_IC }, "(" .. name .. ") " );
		
	end
	
end
GM:AddChatCommand( "/lev", Color( 114, 160, 193, 255 ), CC.LocalEvent );

function CC.Advertise( ply, arg, other )
	
	if( string.len( arg ) == 0 ) then return end
	
	if( other ) then
		
		local name = ply:VisibleRPName();
		GAMEMODE:AddChat( Color( 255, 114, 89, 255 ), "CombineControl.ChatNormal", "[AD] " .. arg, { CB_ALL, CB_IC }, "(" .. name .. ") " );
		
	else
		
		if( !ply:Alive() ) then
			
			if( CLIENT ) then
				
				GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're dead. You can't talk.", { CB_ALL, CB_IC } );
				
			end
			
			return;
			
		end
		
		if( ply:PassedOut() ) then
			
			if( CLIENT ) then
				
				GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're unconscious. You can't talk.", { CB_ALL, CB_IC } );
				
			end
			
			return;
			
		end
		
		if( ply:HasCharFlag( "S" ) ) then
			
			if( CLIENT ) then
				
				GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're a stalker. You have no mouth.", { CB_ALL, CB_IC } );
				
			end
			
			return;
			
		end
		
		if( ply:HasTrait( TRAIT_FOREIGNER ) ) then
		
			if( CLIENT ) then
				
				GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You don't speak the local language.", { CB_ALL, CB_IC } );
				
			end
			
			return;
			
		end
		
		if( ply:Money() < 10 ) then
			
			if( CLIENT ) then
				
				GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You need $10 to run an advertisement.", { CB_ALL, CB_IC } );
				
			end
			
			return;
			
		end
		
		if( SERVER ) then
			
			ply:AddMoney( -10 );
			ply:UpdateCharacterField( "Money", tostring( ply:Money() ) );
			
			local rf = ply:GetRF( math.huge, math.huge );
			
			net.Start( "nChatAdvertise" );
				net.WriteEntity( ply );
				net.WriteString( arg );
			net.Send( rf );
			
			local name = ply:VisibleRPName();
			GAMEMODE:LogChat( "[a] (" .. name .. ") " .. arg, ply );
			
		else
			
			if( !ply.VisibleRPName ) then return end
			
			local name = ply:VisibleRPName();
			GAMEMODE:AddChat( Color( 255, 114, 89, 255 ), "CombineControl.ChatNormal", "[AD] " .. arg, { CB_ALL, CB_IC }, "(" .. name .. ") " );
			
		end
		
	end
	
end
GM:AddChatCommand( "/ad", Color( 255, 114, 89, 255 ), CC.Advertise );

function CC.Help( ply, arg )
	
	if( CLIENT ) then
		
		GAMEMODE:CreateHelpMenu();
		
	end
	
end
GM:AddChatCommand( "/help", Color( 200, 200, 200, 255 ), CC.Help );

function CC.Citizen( ply, arg )
	
	if( SERVER ) then
		
		if( #GAMEMODE:LookupCharFlag( ply:CharFlags() ) > 0 ) then return end
		
		ply:SetTeam( TEAM_CITIZEN );
		ply:SetActiveFlag( "" );
		ply:Kill();
		
		local charData = ply:GetCharFromID( ply:CharID() );
		local TitleOne = util.JSONToTable( charData.TitleOne )["offduty"];
		local TitleTwo = util.JSONToTable( charData.TitleTwo )["offduty"];
		local Description = util.JSONToTable( charData.Title )["offduty"];
		
		ply:SetTitleOne( TitleOne );
		ply:SetTitleTwo( TitleTwo );
		ply:SetDescription( Description );
		
		if( ply:CombineFlag() != "" ) then
			
			ply:SetTeam( TEAM_CITIZEN );
			
		end
		
	end
	
end
GM:AddChatCommand( "/civilian", Color( 255, 255, 255, 255 ), CC.Citizen );

function CC.CP( ply, arg )
	
	if( SERVER and ply:HasAnyCombineFlag() ) then
		
		if( #GAMEMODE:LookupCharFlag( ply:CharFlags() ) > 0 ) then return end
		
		ply:Kill();
		ply:SetTeam( TEAM_COMBINE );
		ply:SetActiveFlag( ply:CombineFlag() );
		
		local charData = ply:GetCharFromID( ply:CharID() );
		local TitleOne = util.JSONToTable( charData.TitleOne )["onduty"];
		local TitleTwo = util.JSONToTable( charData.TitleTwo )["onduty"];
		local Description = util.JSONToTable( charData.Title )["onduty"];
		
		ply:SetTitleOne( TitleOne );
		ply:SetTitleTwo( TitleTwo );
		ply:SetDescription( Description );
		
		if( ply:CombineFlag() != "G" and ply:CombineFlag() != "F" ) then
		
			local hasActiveSqL = false;
			
			for k,v in next, player.GetAll() do
			
				if( v:CombineFlag() == "F" and v:CombineSquad() == ply:CombineSquad() ) then
				
					if( v:ActiveFlag() != "" ) then
				
						hasActiveSqL = true;
						break;
						
					end
					
				end
				
			end
			
			if( !hasActiveSqL ) then
			
				ply:SetCombineSquad( "" );
				ply:UpdateCharacterField( "CombineSquad", "" );
			
			end
			
		end
		
		for _, v in pairs( game.GetDoors() ) do
			
			if( table.HasValue( v:DoorOwners(), ply:CharID() ) ) then
				
				if( table.Count( v:DoorOwners() ) == 1 ) then
					
					ply:SellDoor( v );
					
				else
					
					ply:RemoveDoorOwner( v );
					
				end
				
			end
			
			if( table.HasValue( v:DoorAssignedOwners(), ply ) ) then
				
				ply:RemoveDoorAssignedOwner( v );
				
			end
			
		end
		
	end
	
end
GM:AddChatCommand( "/sdpd", Color( 255, 255, 255, 255 ), CC.CP );

function CC.Roll( ply, arg, val )
	
	if( val ) then
		
		if( !ply.VisibleRPName ) then return end
		
		local name = ply:VisibleRPName();
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", name .. " rolled " .. val .. "/100.", { CB_ALL, CB_OOC } );
		
	else
		
		if( SERVER ) then
			
			local roll = math.random( 0, 100 );
			if( ply:HasTrait( TRAIT_LUCKY ) ) then
			
				roll = math.random( 50, 100 );
				
			elseif( ply:HasTrait( TRAIT_UNLUCKY ) ) then
			
				roll = math.random( 0, 50 );
				
			end
			
			local rf = ply:GetRF( 400, 150, true );
			
			net.Start( "nRoll" );
				net.WriteEntity( ply );
				net.WriteUInt( roll, 7 );
			net.Send( rf );
			
			local name = ply:VisibleRPName();
			GAMEMODE:LogChat( "[R] " .. name .. " rolled " .. roll .. "/100.", ply );
			
		end
		
	end
	
end
GM:AddChatCommand( "/roll", Color( 200, 200, 200, 255 ), CC.Roll );

CC.Languages = { };
CC.Languages[TRAIT_RUSSIAN] = { "Russian", "/rus" };
CC.Languages[TRAIT_CHINESE] = { "Chinese", "/chi" };
CC.Languages[TRAIT_JAPANESE] = { "Japanese", "/jap" };
CC.Languages[TRAIT_SPANISH] = { "Spanish", "/spa" };
CC.Languages[TRAIT_FRENCH] = { "French", "/fre" };
CC.Languages[TRAIT_GERMAN] = { "German", "/ger" };
CC.Languages[TRAIT_ITALIAN] = { "Italian", "/ita" };

for k, v in pairs( CC.Languages ) do
	
	CC[v[1]] = function( ply, arg )
		
		if( string.len( arg ) == 0 ) then return end
		
		if( CLIENT and ply == LocalPlayer() and bit.band( ply:Trait(), k ) != k ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You can't speak " .. v[1] .. "!", { CB_ALL, CB_IC } );
			return;
			
		end
		
		if( !ply:Alive() ) then
			
			if( CLIENT ) then
				
				GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're dead. You can't talk.", { CB_ALL, CB_IC } );
				
			end
			
			return;
			
		end
		
		if( ply:PassedOut() ) then
			
			if( CLIENT ) then
				
				GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're unconscious. You can't talk.", { CB_ALL, CB_IC } );
				
			end
			
			return;
			
		end
		
		if( SERVER ) then
			
			if( !ply:HasTrait( k ) ) then
				
				return;
				
			end
			
			local rf = ply:GetRF( 400, 150 );
			
			net.Start( "nChat" .. v[1] );
				net.WriteEntity( ply );
				net.WriteString( arg );
			net.Send( rf );
			
			local name = ply:VisibleRPName();
			GAMEMODE:LogChat( "[F] " .. name .. ": " .. arg, ply );
			
		else
			
			if( !ply.VisibleRPName ) then return end
			
			local name = ply:VisibleRPName();
			
			if( !LocalPlayer():HasTrait( k ) ) then
				
				GAMEMODE:AddChat( Color( 255, 167, 73, 255 ), "CombineControl.ChatNormalItalic", name .. " speaks " .. v[1] .. ".", { CB_ALL, CB_IC }, nil, ply );
				
			else
				
				GAMEMODE:AddChat( Color( 255, 167, 73, 255 ), "CombineControl.ChatNormal", "[" .. v[1] .. "] " .. name .. ": " .. arg, { CB_ALL, CB_IC }, nil, ply );
				
			end
			
		end
		
	end
	GM:AddChatCommand( v[2], Color( 255, 167, 73, 255 ), CC[v[1]] );
	
	if( CLIENT ) then
		
		_G["nChat" .. v[1]] = function( len )
			
			local ply = net.ReadEntity();
			local str = net.ReadString();
			
			CC[v[1]]( ply, str );
			
		end
		net.Receive( "nChat" .. v[1], _G["nChat" .. v[1]] );
		
	else
		
		util.AddNetworkString( "nChat" .. v[1] );
		
	end
	
	CC[v[1] .. "Y"] = function( ply, arg )
		
		if( string.len( arg ) == 0 ) then return end
		
		if( CLIENT and ply == LocalPlayer() and bit.band( ply:Trait(), k ) != k ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You can't speak " .. v[1] .. "!", { CB_ALL, CB_IC } );
			return;
			
		end
		
		if( !ply:Alive() ) then
			
			if( CLIENT ) then
				
				GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're dead. You can't talk.", { CB_ALL, CB_IC } );
				
			end
			
			return;
			
		end
		
		if( ply:PassedOut() ) then
			
			if( CLIENT ) then
				
				GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're unconscious. You can't talk.", { CB_ALL, CB_IC } );
				
			end
			
			return;
			
		end
		
		if( SERVER ) then
			
			if( !ply:HasTrait( k ) ) then
				
				return;
				
			end
			
			local rf = ply:GetRF( 1000, 800 );
			
			net.Start( "nChatY" .. v[1] );
				net.WriteEntity( ply );
				net.WriteString( arg );
			net.Send( rf );
			
			local name = ply:VisibleRPName();
			GAMEMODE:LogChat( "[G] " .. name .. ": " .. arg, ply );
			
		else
			
			if( !ply.VisibleRPName ) then return end
			
			local name = ply:VisibleRPName();
			
			if( !LocalPlayer():HasTrait( k ) ) then
				
				GAMEMODE:AddChat( Color( 255, 167, 73, 255 ), "CombineControl.ChatBigItalic", name .. " yells something in " .. v[1] .. ".", { CB_ALL, CB_IC }, nil, ply );
				
			else
				
				GAMEMODE:AddChat( Color( 255, 167, 73, 255 ), "CombineControl.ChatBig", "[" .. v[1] .. ", Yell] " .. name .. ": " .. arg, { CB_ALL, CB_IC }, nil, ply );
				
			end
			
		end
		
	end
	GM:AddChatCommand( v[2] .. "y", Color( 255, 167, 73, 255 ), CC[v[1] .. "Y"] );
	
	if( CLIENT ) then
		
		_G["nChatY" .. v[1]] = function( len )
			
			local ply = net.ReadEntity();
			local str = net.ReadString();
			
			CC[v[1] .. "Y"]( ply, str );
			
		end
		net.Receive( "nChatY" .. v[1], _G["nChatY" .. v[1]] );
		
	else
		
		util.AddNetworkString( "nChatY" .. v[1] );
		
	end
	
	CC[v[1] .. "W"] = function( ply, arg )
		
		if( string.len( arg ) == 0 ) then return end
		
		if( CLIENT and ply == LocalPlayer() and bit.band( ply:Trait(), k ) != k ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You can't speak " .. v[1] .. "!", { CB_ALL, CB_IC } );
			return;
			
		end
		
		if( !ply:Alive() ) then
			
			if( CLIENT ) then
				
				GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're dead. You can't talk.", { CB_ALL, CB_IC } );
				
			end
			
			return;
			
		end
		
		if( ply:PassedOut() ) then
			
			if( CLIENT ) then
				
				GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're unconscious. You can't talk.", { CB_ALL, CB_IC } );
				
			end
			
			return;
			
		end
		
		if( SERVER ) then
			
			if( !ply:HasTrait( k ) ) then
				
				return;
				
			end
			
			local rf = ply:GetRF( 150, 0 );
			
			net.Start( "nChatW" .. v[1] );
				net.WriteEntity( ply );
				net.WriteString( arg );
			net.Send( rf );
			
			local name = ply:VisibleRPName();
			GAMEMODE:LogChat( "[H] " .. name .. ": " .. arg, ply );
			
		else
			
			if( !ply.VisibleRPName ) then return end
			
			local name = ply:VisibleRPName();
			
			if( !LocalPlayer():HasTrait( k ) ) then
				
				GAMEMODE:AddChat( Color( 255, 167, 73, 255 ), "CombineControl.ChatSmallItalic", name .. " whispers something in " .. v[1] .. ".", { CB_ALL, CB_IC }, nil, ply );
				
			else
				
				GAMEMODE:AddChat( Color( 255, 167, 73, 255 ), "CombineControl.ChatSmall", "[" .. v[1] .. ", Whisper] " .. name .. ": " .. arg, { CB_ALL, CB_IC }, nil, ply );
				
			end
			
		end
		
	end
	GM:AddChatCommand( v[2] .. "w", Color( 255, 167, 73, 255 ), CC[v[1] .. "W"] );
	
	if( CLIENT ) then
		
		_G["nChatW" .. v[1]] = function( len )
			
			local ply = net.ReadEntity();
			local str = net.ReadString();
			
			CC[v[1] .. "W"]( ply, str );
			
		end
		net.Receive( "nChatW" .. v[1], _G["nChatW" .. v[1]] );
		
	else
		
		util.AddNetworkString( "nChatW" .. v[1] );
		
	end
	
	CC[v[1] .. "R"] = function( ply, arg, norad )
		
		if( string.len( arg ) == 0 ) then return end
		
		local can, channel, ent = CC.CanRadio( ply );
		
		if( CLIENT and ply == LocalPlayer() and bit.band( ply:Trait(), k ) != k ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You can't speak " .. v[1] .. "!", { CB_ALL, CB_IC } );
			return;
			
		end
		
		if( CLIENT and ply == LocalPlayer() and !can ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You need a radio for this.", { CB_ALL, CB_IC } );
			return;
			
		end
		
		if( !ply:Alive() ) then
			
			if( CLIENT ) then
				
				GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're dead. You can't talk.", { CB_ALL, CB_IC } );
				
			end
			
			return;
			
		end
		
		if( ply:PassedOut() ) then
			
			if( CLIENT ) then
				
				GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're unconscious. You can't talk.", { CB_ALL, CB_IC } );
				
			end
			
			return;
			
		end
		
		if( SERVER ) then
		
			if( !can ) then
				
				return;
				
			end
			
			if( !ply:HasTrait( k ) ) then
				
				return;
				
			end
			
			if( !ent ) then
				
				local rf = ply:GetRF( 400, 150 );
				net.Start( "nChatRSurround"..v[1] );
					net.WriteEntity( ply );
					net.WriteString( arg );
				net.Send( rf );
				
				local rf = { };
				
				for _, v in pairs( player.GetAll() ) do
					
					if( channel == v:RadioFreq() and ply != v and v:HasItem( "radio" ) ) then
						
						table.insert( rf, v );
						
					end
					
				end
				
				net.Start( "nChatR"..v[1] );
					net.WriteEntity( ply );
					net.WriteString( arg );
				net.Send( rf );
				
				local rf = { };
				
				for _, v in pairs( ents.FindByClass( "cc_radio" ) ) do
					
					if( channel == v:GetChannel() ) then
						
						for _, n in pairs( player.GetAll() ) do
							
							local dist = 400;
							
							if( !n:CanHear( v ) ) then
								
								dist = 150;
								
							end
							
							if( n:GetPos():Distance( v:GetPos() ) < dist ) then
								
								table.insert( rf, n );
								
							end
							
						end
						
					end
					
				end
				
				net.Start( "nChatR"..v[1] );
					net.WriteEntity( ply );
					net.WriteString( arg );
				net.Send( rf );
				
			else
				
				local rf = { };
				
				for _, v in pairs( player.GetAll() ) do
					
					if( channel == v:RadioFreq() and ply != v and v:HasItem( "radio" ) ) then
						
						table.insert( rf, v );
						
					end
					
				end

				net.Start( "nChatR"..v[1] );
					net.WriteEntity( ply );
					net.WriteString( arg );
				net.Send( rf );
				
				local rf = { };
				
				for _, v in pairs( ents.FindByClass( "cc_radio" ) ) do
					
					if( channel == v:GetChannel() ) then
						
						for _, n in pairs( player.GetAll() ) do
							
							local dist = 400;
							
							if( !n:CanHear( v ) ) then
								
								dist = 150;
								
							end
							
							if( n:GetPos():Distance( v:GetPos() ) < dist ) then
								
								table.insert( rf, n );
								
							end
							
						end
						
					end
					
				end

				net.Start( "nChatR"..v[1] );
					net.WriteEntity( ply );
					net.WriteString( arg );
				net.Send( rf );
				
			end
			
			local name = ply:VisibleRPName();
			GAMEMODE:LogChat( "[R] (" .. tostring( channel ) .. ") " .. name .. ": " .. arg, ply );
			
		else
			
			if( !ply.VisibleRPName ) then return end
			
			local name = ply:VisibleRPName();
			
			if( norad ) then
			
				if( !ent ) then

					if( !LocalPlayer():HasTrait( k ) ) then
						
						GAMEMODE:AddChat( Color( 255, 167, 73, 255 ), "CombineControl.ChatNormalItalic", name .. " says something in " .. v[1] .. ".", { CB_ALL, CB_IC }, nil, ply );
						
					else
						
						GAMEMODE:AddChat( Color( 255, 167, 73, 255 ), "CombineControl.ChatNormal", "[" .. v[1] .. "] " .. name .. ":" .. arg, { CB_ALL, CB_IC }, nil, ply );
						
					end
					
				end
				
			else
				
				if( ( ply == LocalPlayer() and !ent ) or ply != LocalPlayer() ) then
			
					if( !LocalPlayer():HasTrait( k ) ) then
						
						GAMEMODE:AddChat( Color( 160, 160, 160, 255 ), "CombineControl.ChatRadio", "[Radio] " .. name .. " says something in "..v[1]..".", { CB_ALL, CB_IC, CB_RADIO } );
						
					else
						
						GAMEMODE:AddChat( Color( 255, 167, 73, 255 ), "CombineControl.ChatRadio", "[Radio - " .. v[1] .. "] " .. name .. ":" .. arg, { CB_ALL, CB_IC, CB_RADIO } );
						
					end
					
				end
				
			end
			
		end
		
	end
	GM:AddChatCommand( v[2] .. "r", Color( 160, 160, 160, 255 ), CC[v[1] .. "R"] );
	
	if( CLIENT ) then
		
		_G["nChatR" .. v[1]] = function( len )
		
			local ply = net.ReadEntity();
			local str = net.ReadString();
			
			CC[v[1] .. "R"]( ply, str );
			
		end
		net.Receive( "nChatR" .. v[1], _G["nChatR" .. v[1]] );
		
		_G["nChatRSurround"..v[1]] = function( len )
		
			local ply = net.ReadEntity();
			local str = net.ReadString();
		
			CC[v[1] .. "R"]( ply, str, true );
		
		end
		net.Receive( "nChatRSurround"..v[1], _G["nChatRSurround"..v[1]] );

	else
	
		util.AddNetworkString( "nChatR" .. v[1] );
		util.AddNetworkString( "nChatRSurround"..v[1] );
	
	end
	
end

function nChatSalaryReceived( len )
		
	GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "Your hourly pay has been deposited into your bank account.", { CB_ALL, CB_IC } );
		
end
net.Receive( "nChatSalaryReceived", nChatSalaryReceived );