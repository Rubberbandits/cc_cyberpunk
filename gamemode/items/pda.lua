ITEM.ID				= "pda";
ITEM.Name			= "Personal Data Assistant";
ITEM.Description	= "A device used to organize information and communicate across networks.";
ITEM.Model			= "models/lt_c/sci_fi/holo_tablet.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 13;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );

ITEM.BulkPrice		= 1200;
ITEM.License		= LICENSE_ELECTRONICS;

ITEM.Usable			= true;
ITEM.UseText		= "Change Name";
ITEM.OnPlayerUse	= function( self, ply ) 
	
	if( CLIENT ) then
	
		Derma_StringRequest( "Change PDA Name", "Enter your new PDA name.", ply:PDAName(), function( text )
			
			net.Start( "nChangePDAName" );
				net.WriteString( text );
			net.SendToServer();
			
		end );
	
	end
	
end

if( SERVER ) then

	util.AddNetworkString( "nChangePDAName" );
	util.AddNetworkString( "nRefusedPDAName" );
	
	local function nChangePDAName( len, ply )
	
		local szName = net.ReadString();
		if( !ply:HasItem( "pda" ) ) then return end
		if( szName == ply:PDAName() ) then return end
		
		if( #szName > 0 and #szName <= 64 ) then
		
			local function onSuccess( res )
			
				if( #res > 0 ) then
				
					net.Start( "nRefusedPDAName" );
					net.Send( ply );
					return;
				
				end
				
				ply:SetPDAName( szName );
				ply:UpdateCharacterField( "PDAName", szName );
			
			end
			mysqloo.Query( Format( "SELECT PDAName FROM cc_chars WHERE PDAName LIKE '%s'", mysqloo.Escape( szName ) ), onSuccess ); 
			
		end
	
	end
	net.Receive( "nChangePDAName", nChangePDAName );

else

	local function nRefusedPDAName( len )
	
		GAMEMODE:AddChat( Color( 255, 51, 51, 255 ), "CombineControl.ChatNormal", "This PDA name is already taken.", { CB_ALL, CB_OOC } );
	
	end
	net.Receive( "nRefusedPDAName", nRefusedPDAName );

end