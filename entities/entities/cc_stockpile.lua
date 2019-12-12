AddCSLuaFile();

ENT.Base = "base_anim";
ENT.Type = "anim";

ENT.PrintName		= "Stockpile";
ENT.Author			= "rusty";
ENT.Contact			= "";
ENT.Purpose			= "";
ENT.Instructions	= "";

ENT.Spawnable			= true;
ENT.AdminSpawnable		= true;

function ENT:PostEntityPaste( ply, ent, tab )
	
	GAMEMODE:LogSecurity( ply:SteamID(), "n/a", ply:VisibleRPName(), "Tried to duplicate " .. ent:GetClass() .. "!" );
	ent:Remove();
	
end

function ENT:SetupDataTables()
	
	self:NetworkVar( "Int", 0, "Deployer" ); 
	
end

function ENT:Initialize()
	
	if( CLIENT ) then return; end
	
	self:SetUseType( SIMPLE_USE );
	
	self:SetModel( "models/lt_c/sci_fi/ground_locker_small.mdl" );
	
	local vecMaxs = self:OBBMaxs();
	self:SetPos( self:GetPos() + Vector( 0, 0, vecMaxs.z ) );
	
	self:PhysicsInit( SOLID_VPHYSICS );
	self:GetPhysicsObject():EnableMotion( false );
	
end

function ENT:CanPhysgun()
	
	return true;
	
end

function ENT:Use( activator, caller, usetype, val )

	net.Start( "nOpenStockpilesMenu" );
	net.Send( activator );

end