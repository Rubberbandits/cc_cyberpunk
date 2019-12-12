ITEM.ID				= "soda";
ITEM.Name			= "Cola-Cola";
ITEM.Description	= "A two liter bottle of store brand cola. It's kind of flat.";
ITEM.Model			= "models/props_junk/garbage_plasticbottle003a.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 7;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0.18 );

ITEM.BulkPrice		= 10;
ITEM.License		= LICENSE_FOOD;

ITEM.Usable			= true;
ITEM.UseText		= "Drink";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You down the entire bottle with a feeling of self-loathing.", { CB_ALL, CB_IC } );
		
	else
		
	end
	
end