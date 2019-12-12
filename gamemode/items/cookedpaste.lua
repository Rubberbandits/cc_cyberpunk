ITEM.ID				= "cookedpaste";
ITEM.Name			= "Cooked Nutrient Paste";
ITEM.Description	= "A heated tub of healthy nutrient paste. It smells bleak.";
ITEM.Model			= "models/props_lab/jar01b.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 7;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );

ITEM.Usable			= true;
ITEM.UseText		= "Eat";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You dig into the paste; it's more edible warm.", { CB_ALL, CB_IC } );
		
	else
		
	end
	
end