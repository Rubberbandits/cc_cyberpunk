ITEM.ID				= "ammo_12ga";
ITEM.Name			= "12 Gauge Buckshot Cartridges";
ITEM.Description	= "A 20-round box of 12 gauge cartridges.";
ITEM.Model			= "models/items/boxbuckshot_old.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 14;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );

ITEM.BulkPrice		= 50;
ITEM.License		= LICENSE_FFL;

ITEM.Usable			= true;
ITEM.UseText		= "Load";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You load the ammunition.", { CB_ALL, CB_IC } );
		
	else
		
		ply:GiveAmmo( 20, "cc_12ga" );
		
	end
	
end