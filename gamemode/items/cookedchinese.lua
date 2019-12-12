ITEM.ID				= "cookedchinese";
ITEM.Name			= "Chinese Takeout";
ITEM.Description	= "A carton of Chinese takeout food. The 'chicken' is particularly flavorful.";
ITEM.Model			= "models/props_interiors/pot02a.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 12;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );

ITEM.Usable			= true;
ITEM.UseText		= "Eat";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You eat the noodles.", { CB_ALL, CB_IC } );
		
	else
		
	end
	
end