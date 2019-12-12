ITEM.ID				= "ration";
ITEM.Name			= "Ration";
ITEM.Description	= "A combine ration. It doesn't contain nearly as much food as one would hope.";
ITEM.Model			= "models/weapons/w_package.mdl";
ITEM.Weight 		= 5;

ITEM.Usable			= true;
ITEM.UseText		= "Open";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	if( CLIENT ) then
			
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You open the ration and take the contents.", { CB_ALL, CB_IC } );
		
	else
		
		ply:GiveItem( "water" );
		ply:GiveItem( "beans" );
		ply:GiveItem( "headcrabgib" );
		
		ply:AddMoney( 50 );
		ply:UpdateCharacterField( "Money", tostring( ply:Money() ) );
		
	end
	
end