ITEM.ID				= "beans";
ITEM.Name			= "Refried Beans";
ITEM.Description	= "A can of beans. Southwestern favorite. Not microwave safe.";
ITEM.Model			= "models/props_junk/garbage_metalcan001a.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 7;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );

ITEM.BulkPrice		= 10;
ITEM.License		= LICENSE_FOOD;

ITEM.Usable			= true;
ITEM.UseText		= "Eat";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You open and eat the can of uncooked beans.", { CB_ALL, CB_IC } );
		
	else
		
	end
	
end