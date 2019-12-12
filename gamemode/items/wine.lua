ITEM.ID				= "wine";
ITEM.Name			= "Cabernet Sauvignon Wine";
ITEM.Description	= "Cheap French wine guaranteed to get you soccer-mom drunk.";
ITEM.Model			= "models/props_junk/garbage_glassbottle003a.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 11;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );

ITEM.BulkPrice		= 50;
ITEM.License		= LICENSE_ALCOHOL;

ITEM.Usable			= true;
ITEM.UseText		= "Drink";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You uncork and drink the wine.", { CB_ALL, CB_IC } );
		
	else
		
	end
	
end