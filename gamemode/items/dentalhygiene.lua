ITEM.ID				= "dentalhygiene";
ITEM.Name			= "Toothbrush & Toothpaste";
ITEM.Description	= "A disposable toothbrush and a travel-sized tube of toothpaste.";
ITEM.Model			= "models/props/CS_militia/toothbrushset01.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 7;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0.18 );

ITEM.BulkPrice		= 15;
ITEM.License		= LICENSE_MISC;

ITEM.Usable			= true;
ITEM.UseText		= "Brush";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You brush your teeth very thoroughly. Good job.", { CB_ALL, CB_IC } );
		
	end
end