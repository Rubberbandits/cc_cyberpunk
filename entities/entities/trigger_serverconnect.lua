AddCSLuaFile();
ENT.Base = "base_anim";
ENT.Type = "anim";

function ENT:Initialize()

	self:SetModel( "models/props_junk/wood_crate001a.mdl" );
	self:SetMoveType( MOVETYPE_NONE );
	//self:SetCollisionGroup( COLLISION_GROUP_WEAPON );
	
end

function ENT:SetupDataTables()

	self:NetworkVar( "Vector", 0, "Mins" );
	self:NetworkVar( "Vector", 1, "Maxs" );
	self:NetworkVar( "Int", 0, "ServerID" );

end

/*function ENT:Draw()

	render.SetShadowsDisabled( true );

end*/

if( SERVER ) then

	util.AddNetworkString( "RequestServerTransfer" );

	function ENT:Think()

		if( !self.LastInBox ) then
		
			self.LastInBox = {};
			
		end

		if( self:GetMins() and self:GetMaxs() ) then

			for k,v in next, ents.FindInBox( self:GetMins(), self:GetMaxs() ) do
			
				if( v:IsPlayer() ) then
				
					if( GAMEMODE.ServerConnectIDs[self:GetServerID()] and !self.LastInBox[v] ) then
						
						local tab = GAMEMODE.ServerConnectIDs[self:GetServerID()];
						net.Start( "RequestServerTransfer" );
							net.WriteString( tab.TransitionName );
							net.WriteString( tab.ServerIP );
							net.WriteString( tab.Password );
						net.Send( v );
						
						self.LastInBox[v] = true;
						
					end
				
				end
			
			end
			
			for k,v in next, player.GetAll() do
			
				local mins,maxs = self:GetMins(), self:GetMaxs();
				
				OrderVectors( mins, maxs );
			
				if( self.LastInBox[v] and !v:GetPos():WithinAABox( mins, maxs ) ) then
				
					self.LastInBox[v] = nil;
					
				end
			
			end
		
		end

	end
	
end