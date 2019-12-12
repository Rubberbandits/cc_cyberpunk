ITEM.ID				= "ammo_50bmg";
ITEM.Name			= ".50 BMG Cartridges";
ITEM.Description	= "A ten round box of .50 BMG cartridges. Compensating?";
ITEM.Model			= "models/props_lab/box01a.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 14;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );

ITEM.BulkPrice		= 160;
ITEM.License		= LICENSE_FFL;

ITEM.Usable			= true;
ITEM.UseText		= "Load";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You load the ammunition.", { CB_ALL, CB_IC } );
		
	else
		
		ply:GiveAmmo( 10, "cc_50bmg" );
		
	end
	
end