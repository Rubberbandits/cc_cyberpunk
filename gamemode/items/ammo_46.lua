ITEM.ID				= "ammo_46";
ITEM.Name			= "4.6x30mm Cartridges";
ITEM.Description	= "30 4.6x30mm cartridges.";
ITEM.Model			= "models/tnb/weapons/ammo/mp7.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 14;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );

ITEM.BulkPrice		= 110;
ITEM.License		= LICENSE_FFL;

ITEM.Usable			= true;
ITEM.UseText		= "Load";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You load the ammunition.", { CB_ALL, CB_IC } );
		
	else
		
		ply:GiveAmmo( 30, "cc_46" );
		
	end
	
end