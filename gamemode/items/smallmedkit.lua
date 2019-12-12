ITEM.ID				= "smallmedkit";
ITEM.Name			= "Gauze Bandages";
ITEM.Description	= "A roll of gauze bandages. Used for emergency first aid.";
ITEM.Model			= "models/props/cs_office/Paper_towels.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 9;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 5.02 );

ITEM.BulkPrice		= 6;
ITEM.License		= LICENSE_MED;

ITEM.Usable			= true;
ITEM.UseText		= "Apply";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You wrap the wound in bandages.", { CB_ALL, CB_IC } );
		
	else
		
		ply:SetHealth( math.min( ply:Health() + 20, 100 ) );
		
	end
	
end