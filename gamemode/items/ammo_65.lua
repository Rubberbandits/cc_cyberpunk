ITEM.ID				= "ammo_65";
ITEM.Name			= "6.5x39mm Cartridges";
ITEM.Description	= "30 rounds of 6.5x39mm cartridges, used in several exotic assault rifles.";
ITEM.Model			= "models/tnb/weapons/ammo/stanag.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 14;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );

ITEM.BulkPrice		= 70;
ITEM.License		= LICENSE_FFL;

ITEM.Usable			= true;
ITEM.UseText		= "Load";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You load the ammunition.", { CB_ALL, CB_IC } );
		
	else
		
		ply:GiveAmmo( 30, "cc_65" );
		
	end
	
end