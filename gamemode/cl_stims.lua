local function nReceiveStim( len )

	local stim = net.ReadString();
	local start = net.ReadInt( 32 );

	if( !LocalPlayer().ActiveStims ) then
	
		LocalPlayer().ActiveStims = {};
		
	end
	
	LocalPlayer().ActiveStims[stim] = {
		StartTime = start,
	};

end
net.Receive( "nReceiveStim", nReceiveStim );

local function nRemoveStim( len )

	local stim = net.ReadString();

	if( !LocalPlayer().ActiveStims ) then return end
	if( !LocalPlayer().ActiveStims[stim] ) then return end
	
	LocalPlayer().ActiveStims[stim] = nil;
	
end
net.Receive( "nRemoveStim", nRemoveStim );

hook.Add( "Think", "Cyberpunk.StimsTimer", function()

	if( !LocalPlayer().ActiveStims ) then return end
	for m,n in next, LocalPlayer().ActiveStims do
	
		local metaitem = GAMEMODE:GetItemByID( m );
		if( metaitem ) then
		
			if( n.StartTime + metaitem.Duration <= CurTime() ) then
			
				metaitem.OnStimTaken( m, LocalPlayer() );
				LocalPlayer().ActiveStims[m] = nil;
			
			end
			
		end
		
	end

end );