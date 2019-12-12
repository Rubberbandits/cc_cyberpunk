ITEM.ID				= "banana";
ITEM.Name			= "Banana";
ITEM.Description	= "A banana loaded with artificial preservatives.";
ITEM.Model			= "models/props/cs_italy/bananna.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 14;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );

ITEM.BulkPrice		= 12;
ITEM.License		= LICENSE_FOOD;

ITEM.Usable			= true;
ITEM.UseText		= "Eat";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You bite straight into the banana with an audible crunch. Sicko.", { CB_ALL, CB_IC } );
		
	else
		
	end
	
end