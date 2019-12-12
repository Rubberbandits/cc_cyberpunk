ITEM.ID				= "cigars";
ITEM.Name			= "Union Cigars";
ITEM.Description	= "A box of premium cigars. Imported from Guatemala.";
ITEM.Model			= "models/props_lab/box01a.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 7;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0.18 );

ITEM.Usable			= true;
ITEM.UseText		= "Smoke";
ITEM.DeleteOnUse	= false;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You open the box and smoke a cigar.", { CB_ALL, CB_IC } );
		
	else
		
	end
	
end