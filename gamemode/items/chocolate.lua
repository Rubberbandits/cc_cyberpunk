ITEM.ID				= "chocolate";
ITEM.Name			= "Hershey's Chocolate Bar";
ITEM.Description	= "A creamy milk chocolate bar.";
ITEM.Model			= "models/props_lab/box01a.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 7;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0.18 );

ITEM.BulkPrice		= 2;
ITEM.License		= LICENSE_FOOD;

ITEM.Usable			= true;
ITEM.UseText		= "Eat";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You eat the chocolate bar.", { CB_ALL, CB_IC } );
		
	else
		
	end
	
end