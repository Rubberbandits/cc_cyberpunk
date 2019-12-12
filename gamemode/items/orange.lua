ITEM.ID				= "orange";
ITEM.Name			= "Orange";
ITEM.Description	= "A GMO orange loaded with preservatives.";
ITEM.Model			= "models/props/cs_italy/orange.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 14;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );

ITEM.BulkPrice		= 11;
ITEM.License		= LICENSE_FOOD;

ITEM.Usable			= true;
ITEM.UseText		= "Eat";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You peel the orange, tossing the waste aside. You dig in.", { CB_ALL, CB_IC } );
		
	else
		
	end
	
end