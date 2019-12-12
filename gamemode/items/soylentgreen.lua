ITEM.ID				= "soylentgreen";
ITEM.Name			= "Nutrient Paste";
ITEM.Description	= "A nutrient-enriched paste of the type issued to soldiers and star pilots. Flavorless and of an unpleasant consistency, but it contains the day's calories, nutrients and vitamins.";
ITEM.Model			= "models/props_lab/jar01b.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 7;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );

ITEM.BulkPrice		= 25;
ITEM.License		= LICENSE_FOOD;

ITEM.Usable			= true;
ITEM.UseText		= "Eat";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You spoon paste from the jar. You feel queasy.", { CB_ALL, CB_IC } );
		
	else
		
	end
	
end