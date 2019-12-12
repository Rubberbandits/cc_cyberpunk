ITEM.ID				= "chinese";
ITEM.Name			= "Chinese Takeout";
ITEM.Description	= "A carton of Chinese food from a local shop that somehow escaped being cooked.";
ITEM.Model			= "models/props_junk/garbage_takeoutcarton001a.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 10;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );

ITEM.BulkPrice		= 7.50;
ITEM.License		= LICENSE_FOOD;

ITEM.Usable			= true;
ITEM.UseText		= "Eat";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You eat the dry noodles.", { CB_ALL, CB_IC } );
		
	else
		
	end
	
end