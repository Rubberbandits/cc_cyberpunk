ITEM.ID				= "melon";
ITEM.Name			= "Watermelon";
ITEM.Description	= "A large fruit, watery and juicy.";
ITEM.Model			= "models/props_junk/watermelon01.mdl";
ITEM.Weight 		= 10;
ITEM.FOV 			= 14;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );

ITEM.BulkPrice		= 50;
ITEM.License		= LICENSE_FOOD;

ITEM.Usable			= true;
ITEM.UseText		= "Eat";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You eat the entire melon. You must have been hungry.", { CB_ALL, CB_IC } );
		
	else
		
	end
	
end