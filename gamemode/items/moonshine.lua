ITEM.ID				= "moonshine";
ITEM.Name			= "Everclear";
ITEM.Description	= "A bottle of extremely potent alcohol, barely qualifying as a beverage. Flammable and disinfecting.";
ITEM.Model			= "models/props_junk/garbage_glassbottle002a.mdl";
ITEM.Weight 		= 2;
ITEM.FOV 			= 11;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 5.56 );

ITEM.BulkPrice		= 60;
ITEM.License		= LICENSE_ALCOHOL;

ITEM.Usable			= true;
ITEM.UseText		= "Drink";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You open and drink the moonshine.", { CB_ALL, CB_IC } );
		
	else
		
	end
	
end