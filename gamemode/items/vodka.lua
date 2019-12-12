ITEM.ID				= "vodka";
ITEM.Name			= "Grey Goose vodka";
ITEM.Description	= "A bottle of strong vodka.";
ITEM.Model			= "models/props_junk/glassjug01.mdl";
ITEM.Weight 		= 2;
ITEM.FOV 			= 11;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 5.56 );

ITEM.BulkPrice		= 80;
ITEM.License		= LICENSE_ALCOHOL;

ITEM.Usable			= true;
ITEM.UseText		= "Drink";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You open and drink the vodka.", { CB_ALL, CB_IC } );
		
	else
		
	end
	
end