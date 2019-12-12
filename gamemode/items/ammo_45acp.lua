ITEM.ID				= "ammo_45acp";
ITEM.Name			= ".45 ACP Cartridges";
ITEM.Description	= "A 50-round box of .45 ACP cartridges.";
ITEM.Model			= "models/props_lab/box01a.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 14;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );

ITEM.BulkPrice		= 120;
ITEM.License		= LICENSE_FFL;

ITEM.Usable			= true;
ITEM.UseText		= "Load";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You load the ammunition.", { CB_ALL, CB_IC } );
		
	else
		
		ply:GiveAmmo( 50, "cc_45acp" );
		
	end
	
end