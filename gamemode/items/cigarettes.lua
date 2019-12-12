ITEM.ID				= "cigarettes";
ITEM.Name			= "Marlboro Lites";
ITEM.Description	= "A pack of inexpensive cigarettes.";
ITEM.Model			= "models/nt/props_debris/cigarette_pack01.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 7;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0.18 );

ITEM.BulkPrice		= 15;
ITEM.License		= LICENSE_MISC;

ITEM.Usable			= true;
ITEM.UseText		= "Smoke";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You open the pack and smoke the cigarettes.", { CB_ALL, CB_IC } );
		
	else
		
	end
	
end