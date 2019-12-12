ITEM.ID				= "adhesive";
ITEM.Name			= "Elmer's Glue";
ITEM.Description	= "A huge jug of glue to stick things together.";
ITEM.Model			= "models/props_junk/garbage_plasticbottle001a.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 14;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );

ITEM.BulkPrice		= 25;
ITEM.License		= LICENSE_MISC;

ITEM.Usable			= true;
ITEM.UseText		= "Drink";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You drink the liquid glue. Are you okay?", { CB_ALL, CB_IC } );
		
	else
		
		ply:Kill();
		
	end
	
end