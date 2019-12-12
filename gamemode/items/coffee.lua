ITEM.ID				= "coffee";
ITEM.Name			= "Coffee";
ITEM.Description	= "A mug of coffee. Black.";
ITEM.Model			= "models/props_junk/garbage_coffeemug001a.mdl";
ITEM.Weight 		= 0.5;
ITEM.FOV 			= 6;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );

ITEM.BulkPrice		= 6;
ITEM.License		= LICENSE_FOOD;

ITEM.Usable			= true;
ITEM.UseText		= "Drink";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You drink the coffee.", { CB_ALL, CB_IC } );
		
	else
		
	end
	
end