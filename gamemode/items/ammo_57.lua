ITEM.ID				= "ammo_57";
ITEM.Name			= "5.7x28mm Cartridges";
ITEM.Description	= "A 30-round box of 5.7x28mm cartridges.";
ITEM.Model			= "models/props_lab/box01a.mdl";
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
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You load the box of rounds.", { CB_ALL, CB_IC } );
		
	else
		
		ply:GiveAmmo( 30, "cc_57" );
		
	end
	
end