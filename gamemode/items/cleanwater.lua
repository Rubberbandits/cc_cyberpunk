ITEM.ID				= "cleanwater";
ITEM.Name			= "Nestle PUR-KLEEN Quadruple-Filtered Water";
ITEM.Description	= "A can of water. The label claims it has been filtered and purified to the highest standards. It tastes a little funny.";
ITEM.Model			= "models/props_junk/PopCan01a.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 7;
ITEM.CamPos 		= Vector( 50, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0.18 );

ITEM.BulkPrice		= 10;
ITEM.License		= LICENSE_FOOD;

ITEM.Usable			= true;
ITEM.UseText		= "Drink";
ITEM.DeleteOnUse	= true;
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You open and drink the entire can.", { CB_ALL, CB_IC } );
		
	else
		
	end
	
end