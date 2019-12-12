function nBuyBusinessLicense( len, ply )
	
	local t = net.ReadString();
	
	if( GAMEMODE.BusinessLicenses[t] and GAMEMODE.BusinessLicenses[t][2] and string.find( ply:BusinessLicenses(), t ) ) then
		
		if( ply:Money() >= GAMEMODE.BusinessLicenses[t][2] ) then
			
			ply:AddMoney( -1 * GAMEMODE.BusinessLicenses[t][2] );
			ply:UpdateCharacterField( "Money", tostring( ply:Money() ) );
			
			ply:SetBusinessLicenses( ply:BusinessLicenses() .. t );
			ply:UpdateCharacterField( "BusinessLicenses", ply:BusinessLicenses() );
			
			net.Start( "nPopulateBusiness" );
			net.Send( ply );
			
		end
		
	end
	
end
net.Receive( "nBuyBusinessLicense", nBuyBusinessLicense );

function nBuyItem( len, ply )
	
	local id = net.ReadString();
	local single = net.ReadBit();
	local item = GAMEMODE:GetItemByID( id );
	
	if( !item.BulkPrice ) then return end
	if !item.License or #item.License == 0 then return end
	if( item and ply:HasCharFlag( item.License ) ) then
		
		if( single ) then
			
			if( ply:Money() >= item.BulkPrice / 5 + ( ( item.BulkPrice / 5 ) / GAMEMODE.SellPercentage ) ) then
				
				if( ply:InventoryWeight() < ply:InventoryMaxWeight() ) then
					
					ply:AddMoney( -1 * ( item.BulkPrice / 5 + ( ( item.BulkPrice / 5 ) / GAMEMODE.SellPercentage ) ) );
					ply:UpdateCharacterField( "Money", tostring( ply:Money() ) );
					
					ply:GiveItem( id, 1 );
					
				end
				
			end
			
		else
			
			if( ply:Money() >= item.BulkPrice ) then
				
				if( ply:InventoryWeight() < ply:InventoryMaxWeight() ) then
					
					ply:AddMoney( -1 * item.BulkPrice );
					ply:UpdateCharacterField( "Money", tostring( ply:Money() ) );
					
					ply:GiveItem( id, 5 );
					
				end
				
			end
			
		end
		
	end
	
end
net.Receive( "nBuyItem", nBuyItem );