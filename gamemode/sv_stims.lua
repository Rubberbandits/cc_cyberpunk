hook.Add( "Think", "Cyberpunk.StimsTimer", function()

	for k,v in next, player.GetAll() do
	
		if( v.CharID and v:CharID() > 0 ) then
		
			if( v.ActiveStims ) then

				for m,n in next, v.ActiveStims do

					local metaitem = GAMEMODE:GetItemByID( m );
					if( metaitem ) then
					
						if( n.StartTime + metaitem.Duration <= CurTime() ) then

							metaitem.OnStimTaken( m, v );
							v.ActiveStims[m] = nil;
						
						end
						
					end
					
				end
			
			end
		
		end
		
	end

end );

util.AddNetworkString( "nReceiveStim" );
util.AddNetworkString( "nRemoveStim" );

local meta = FindMetaTable( "Player" );

function meta:AddStimEffect( stim )

	if( !self.ActiveStims ) then
	
		self.ActiveStims = {};
		
	end
	
	local metaitem = GAMEMODE:GetItemByID( stim )
	if( metaitem and metaitem.Stim ) then
	
		if( self.ActiveStims[stim] ) then return end
		self.ActiveStims[stim] = {
			StartTime = CurTime(),
		};
		
		metaitem.OnStimGiven( stim, self );
		
		net.Start( "nReceiveStim" );
			net.WriteString( stim );
			net.WriteInt( CurTime(), 32 );
		net.Send( self );
		
	end

end

function meta:RemoveStimEffect( stim )

	if( !self.ActiveStims ) then return end

	local metaitem = GAMEMODE:GetItemByID( stim )
	if( metaitem and metaitem.Stim ) then
	
		if( !self.ActiveStims[stim] ) then return end
		self.ActiveStims[stim] = nil;
		
		metaitem.OnStimTaken( stim, self );
		
		net.Start( "nRemoveStim" );
			net.WriteString( stim );
		net.Send( self );
		
	end

end