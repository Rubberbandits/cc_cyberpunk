ITEM.ID				= "milkcarton";
ITEM.Name			= "Milk Carton";
ITEM.Description	= "A carton of milk. This should probably be in the fridge.";
ITEM.Model			= "models/props_junk/garbage_milkcarton002a.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 12;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );

ITEM.BulkPrice		= 10;
ITEM.License		= LICENSE_FOOD;

ITEM.Usable			= true;
ITEM.UseText		= "Drink";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You drink the carton of milk.", { CB_ALL, CB_IC } );
		
	else
		
	end
	
end