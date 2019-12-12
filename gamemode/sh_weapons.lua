local t 	= { };
t.name		= "cc_none";
t.dmgtype	= DMG_GENERIC;
t.tracer	= TRACER_NONE;
t.plydmg	= 0;
t.npcdmg	= 0;
t.force		= 0;
t.minsplash	= 0;
t.maxsplash	= 0;
game.AddAmmoType( t );

local t 	= { };
t.name		= "cc_9x19";
t.dmgtype	= DMG_BULLET;
t.tracer	= TRACER_LINE;
t.plydmg	= 3;
t.npcdmg	= 5;
t.force		= 66;
t.minsplash	= 10;
t.maxsplash	= 5;
game.AddAmmoType( t );

local t 	= { };
t.name		= "cc_smg";
t.dmgtype	= DMG_BULLET;
t.tracer	= TRACER_LINE;
t.plydmg	= 4;
t.npcdmg	= 5;
t.force		= 66;
t.minsplash	= 10;
t.maxsplash	= 5;
game.AddAmmoType( t );

local t 	= { };
t.name		= "cc_556";
t.dmgtype	= DMG_BULLET;
t.tracer	= TRACER_LINE;
t.plydmg	= 4;
t.npcdmg	= 5;
t.force		= 66;
t.minsplash	= 10;
t.maxsplash	= 5;
game.AddAmmoType( t );

local t 	= { };
t.name		= "cc_545";
t.dmgtype	= DMG_BULLET;
t.tracer	= TRACER_LINE;
t.plydmg	= 4;
t.npcdmg	= 5;
t.force		= 66;
t.minsplash	= 10;
t.maxsplash	= 5;
game.AddAmmoType( t );

local t 	= { };
t.name		= "cc_65";
t.dmgtype	= DMG_BULLET;
t.tracer	= TRACER_LINE;
t.plydmg	= 4;
t.npcdmg	= 5;
t.force		= 66;
t.minsplash	= 10;
t.maxsplash	= 5;
game.AddAmmoType( t );

local t 	= { };
t.name		= "cc_308";
t.dmgtype	= DMG_BULLET;
t.tracer	= TRACER_LINE;
t.plydmg	= 4;
t.npcdmg	= 5;
t.force		= 66;
t.minsplash	= 10;
t.maxsplash	= 5;
game.AddAmmoType( t );

local t 	= { };
t.name		= "cc_44";
t.dmgtype	= DMG_BULLET;
t.tracer	= TRACER_LINE;
t.plydmg	= 4;
t.npcdmg	= 5;
t.force		= 66;
t.minsplash	= 10;
t.maxsplash	= 5;
game.AddAmmoType( t );

local t 	= { };
t.name		= "cc_50bmg";
t.dmgtype	= DMG_BULLET;
t.tracer	= TRACER_LINE;
t.plydmg	= 4;
t.npcdmg	= 5;
t.force		= 66;
t.minsplash	= 10;
t.maxsplash	= 5;
game.AddAmmoType( t );

local t 	= { };
t.name		= "cc_57";
t.dmgtype	= DMG_BULLET;
t.tracer	= TRACER_LINE;
t.plydmg	= 4;
t.npcdmg	= 5;
t.force		= 66;
t.minsplash	= 10;
t.maxsplash	= 5;
game.AddAmmoType( t );

local t 	= { };
t.name		= "cc_46";
t.dmgtype	= DMG_BULLET;
t.tracer	= TRACER_LINE;
t.plydmg	= 4;
t.npcdmg	= 5;
t.force		= 66;
t.minsplash	= 10;
t.maxsplash	= 5;
game.AddAmmoType( t );

local t 	= { };
t.name		= "cc_300";
t.dmgtype	= DMG_BULLET;
t.tracer	= TRACER_LINE;
t.plydmg	= 4;
t.npcdmg	= 5;
t.force		= 66;
t.minsplash	= 10;
t.maxsplash	= 5;
game.AddAmmoType( t );

local t 	= { };
t.name		= "cc_357";
t.dmgtype	= DMG_BULLET;
t.tracer	= TRACER_LINE;
t.plydmg	= 30;
t.npcdmg	= 40;
t.force		= 1088.2;
t.minsplash	= 10;
t.maxsplash	= 5;
game.AddAmmoType( t );

local t 	= { };
t.name		= "cc_45acp";
t.dmgtype	= DMG_BULLET;
t.tracer	= TRACER_LINE;
t.plydmg	= 3;
t.npcdmg	= 5;
t.force		= 66;
t.minsplash	= 10;
t.maxsplash	= 5;
game.AddAmmoType( t );

local t 	= { };
t.name		= "cc_ar2";
t.dmgtype	= DMG_BULLET;
t.tracer	= TRACER_LINE;
t.plydmg	= 3;
t.npcdmg	= 8;
t.force		= 66;
t.minsplash	= 10;
t.maxsplash	= 5;
game.AddAmmoType( t );

local t 	= { };
t.name		= "cc_12ga";
t.dmgtype	= DMG_BULLET;
t.tracer	= TRACER_LINE;
t.plydmg	= 3;
t.npcdmg	= 8;
t.force		= 130.6;
t.minsplash	= 10;
t.maxsplash	= 5;
game.AddAmmoType( t );

GM.HandsWeapons = {
	"weapon_cc_hands",
	"weapon_cc_vortigaunt",
	"weapon_cc_vortigaunt_slave",
	"weapon_cc_vortbroom",
	"weapon_cc_vortbroom_diss",
};

function GM:PlayerSwitchWeapon( ply, old, new )
	
	if (new.IsTFAWeapon) then
		ply:SetHolstered(true)
		new:SetFireMode(#new.FireModes)
	else
		if (SERVER and new.Holsterable) then
			ply:SetHolstered(true)
		end
		if (!new.Holsterable) then
			ply:SetHolstered(false)
		end
	end
	
	if( ply:PassedOut() and !table.HasValue( self.HandsWeapons, new:GetClass() ) ) then return true end
	if( ply:TiedUp() and !table.HasValue( self.HandsWeapons, new:GetClass() ) ) then return true end
	if( ply:MountedGun() and ply:MountedGun():IsValid() and !table.HasValue( self.HandsWeapons, new:GetClass() ) ) then return true end
	if( ply:APC() and ply:APC():IsValid() and !table.HasValue( self.HandsWeapons, new:GetClass() ) ) then return true end
	
	for _, v in pairs( ents.GetNPCs() ) do
		
		if( v:NPCHatesWeapons() ) then
			
			local class = new:GetClass();
			
			if( class != "weapon_cc_hands" and class != "weapon_cc_vortigaunt_slave" and class != "weapon_cc_vortbroom" and class != "weapon_cc_vortbroom_diss" and class != "weapon_physgun" and class != "gmod_tool" and class != "weapon_physcannon" ) then
				
				v:AddEntityRelationship( ply, D_HT, 99 );
				
			else
				
				if( !ply:Visible( v ) ) then
					
					self:RefreshNPCRelationship( v );
					
				end
				
			end
			
		end
		
	end
	
	self.BaseClass:PlayerSwitchWeapon( ply, old, new );
	
end

function GM:PlayerSwitchFlashlight( ply, enabled )
	
	if( !ply.NextFlashlight ) then ply.NextFlashlight = CurTime(); end
	
	if( CurTime() >= ply.NextFlashlight ) then
		
		ply.NextFlashlight = CurTime() + 0.3;
		return true;
		
	end
	
	return false;
	
end

if( SERVER ) then
	
	function nToggleHolster( len, ply )
		
		if( ply:PassedOut() ) then return end
		if( ply:TiedUp() ) then return end
		if( ply:MountedGun() and ply:MountedGun():IsValid() ) then return end
		if( ply:APC() and ply:APC():IsValid() ) then return end
		
		if( ply:GetActiveWeapon() != NULL ) then
			
			if( ply:GetActiveWeapon().Holsterable or ply:GetActiveWeapon().IsTFAWeapon ) then
				
				ply:SetHolstered( !ply:Holstered() );
				
				if( ply:Holstered() and ply:GetActiveWeapon().IsTFAWeapon ) then
				
					ply:GetActiveWeapon():SetFireMode( #ply:GetActiveWeapon():GetStat( "FireModes" ) );
					
				elseif( !ply:Holstered() and ply:GetActiveWeapon().IsTFAWeapon ) then
				
					ply:GetActiveWeapon():SetFireMode( 1 );
					
				end
				
			else
				
				ply:SetHolstered( false );
				
			end
			
		end
		
	end
	net.Receive( "nToggleHolster", nToggleHolster );
	
	function nSelectWeapon( len, ply )
		
		local class = net.ReadString();
		
		if( ply:PassedOut() ) then return end
		if( ply:TiedUp() ) then return end
		if( ply:MountedGun() and ply:MountedGun():IsValid() ) then return end
		if( ply:APC() and ply:APC():IsValid() ) then return end
		
		ply:SelectWeapon( class );
		
	end
	net.Receive( "nSelectWeapon", nSelectWeapon );
	
end

function GM:IronsightsMul()
	
	return FrameTime() / 1.5;
	
end

function GM:GetTraceDecal( tr )
	
	if( tr.MatType == MAT_ALIENFLESH ) then return "Impact.AlientFlesh" end
	if( tr.MatType == MAT_ANTLION ) then return "Impact.Antlion" end
	if( tr.MatType == MAT_CONCRETE ) then return "Impact.Concrete" end
	if( tr.MatType == MAT_METAL ) then return "Impact.Metal" end
	if( tr.MatType == MAT_WOOD ) then return "Impact.Wood" end
	if( tr.MatType == MAT_GLASS ) then return "Impact.Glass" end
	if( tr.MatType == MAT_FLESH ) then return "Impact.Flesh" end
	if( tr.MatType == MAT_BLOODYFLESH ) then return "Impact.BloodyFlesh" end
	
	return "Impact.Concrete";
	
end

function GM:GetImpactSound( tr )
	
	if( tr.MatType == MAT_ALIENFLESH ) then return "Flesh.BulletImpact" end
	if( tr.MatType == MAT_ANTLION ) then return "Flesh.BulletImpact" end
	if( tr.MatType == MAT_CONCRETE ) then return "Concrete.BulletImpact" end
	if( tr.MatType == MAT_METAL ) then return "SolidMetal.BulletImpact" end
	if( tr.MatType == MAT_WOOD ) then return "Wood.BulletImpact" end
	if( tr.MatType == MAT_GLASS ) then return "Glass.BulletImpact" end
	if( tr.MatType == MAT_FLESH ) then return "Flesh.BulletImpact" end
	if( tr.MatType == MAT_BLOODYFLESH ) then return "Flesh.BulletImpact" end
	if( tr.MatType == MAT_DIRT ) then return "Dirt.BulletImpact" end
	if( tr.MatType == MAT_GRATE ) then return "MetalGrate.BulletImpact" end
	if( tr.MatType == MAT_TILE ) then return "Tile.BulletImpact" end
	if( tr.MatType == MAT_COMPUTER ) then return "Computer.BulletImpact" end
	if( tr.MatType == MAT_SAND ) then return "Sand.BulletImpact" end
	if( tr.MatType == MAT_PLASTIC ) then return "Plastic_Box.BulletImpact" end
	
	return "Default.BulletImpact";
	
end

GM.WeaponStatistics = {};
GM.WeaponStatistics["Primary.Spread"] = function( weapon, value )

	if( !weapon.Shotgun ) then

		if(	weapon:GetOwner():Perception() < 5 ) then
		
			return value + (weapon:GetOwner():Perception()/10);
			
		elseif( weapon:GetOwner():Perception() > 5 ) then
		
			return math.Clamp(value - (weapon:GetOwner():Perception()/100), 0.001, value);
			
		end
		
	end

end;
GM.WeaponStatistics["Primary.IronAccuracy"] = function( weapon, value )

	if(	weapon:GetOwner():Perception() < 5 ) then
	
		return value + (weapon:GetOwner():Perception()/30);
		
	elseif( weapon:GetOwner():Perception() > 5 ) then
	
		return math.Clamp(value - (weapon:GetOwner():Perception()/1000), 0.001, value);
		
	end

end;
GM.WeaponStatistics["Primary.KickUp"] = function( weapon, value )

	if(	weapon:GetOwner():Perception() < 5 ) then
	
		return value + (weapon:GetOwner():Perception()/10);
		
	elseif( weapon:GetOwner():Perception() > 5 ) then
	
		return math.Clamp(value - (weapon:GetOwner():Perception()/100), 0.001, value);
		
	end
	
end;
GM.WeaponStatistics["Primary.KickHorizontal"] = function( weapon, value )

	if(	weapon:GetOwner():Perception() < 5 ) then
	
		return value + (weapon:GetOwner():Perception()/10);
		
	elseif( weapon:GetOwner():Perception() > 5 ) then
	
		return math.Clamp(value - (weapon:GetOwner():Perception()/100), 0.001, value);
		
	end

end;
GM.WeaponStatistics["PrintName"] = function( weapon, value )

	if( weapon.ItemClass ) then
	
		local itemTable = GAMEMODE:GetItemByID( weapon.ItemClass );
		return itemTable.Name;
		
	end

end;
GM.WeaponStatistics["IronSightsPos"] = function( weapon, value )

	if( weapon.ItemClass ) then
	
		local itemTable = GAMEMODE:GetItemByID( weapon.ItemClass );
		if( itemTable.IronSightsPos ) then
		
			return itemTable.IronSightsPos;
			
		end
		
	end

end;
GM.WeaponStatistics["SafetyPos"] = function( weapon, value )

	if( weapon.ItemClass ) then
	
		local itemTable = GAMEMODE:GetItemByID( weapon.ItemClass );
		if( itemTable.SafetyPos ) then
		
			return itemTable.SafetyPos;
			
		end
		
	end

end;
GM.WeaponStatistics["SafetyAng"] = function( weapon, value )

	if( weapon.ItemClass ) then
	
		local itemTable = GAMEMODE:GetItemByID( weapon.ItemClass );
		if( itemTable.SafetyAng ) then
		
			return itemTable.SafetyAng;
			
		end
		
	end

end;
GM.WeaponStatistics["Secondary.IronFOV"] = function( weapon, value )

	if( weapon.ItemClass ) then
	
		local itemTable = GAMEMODE:GetItemByID( weapon.ItemClass );
		if( itemTable.IronFOV ) then
		
			return itemTable.IronFOV;
			
		end
		
	end

end;
GM.WeaponStatistics["SelectiveFire"] = function( weapon, value )

	if( weapon.ItemClass ) then
	
		local itemTable = GAMEMODE:GetItemByID( weapon.ItemClass );
		if( itemTable.SingleFireOnly ) then
		
			return false;
			
		end
		
	end

end;
GM.WeaponStatistics["FireModes"] = function( weapon, value )

	if( weapon.ItemClass ) then
	
		local itemTable = GAMEMODE:GetItemByID( weapon.ItemClass );
		if( itemTable.SingleFireOnly ) then
		
			return {
				[1] = "single",
				[2] = "safe",
			};
			
		end
		
	end

end;
GM.WeaponStatistics["FireModes.1"] = function( weapon, value )
	
	if( weapon.ItemClass ) then
	
		local itemTable = GAMEMODE:GetItemByID( weapon.ItemClass );
		if( itemTable.SingleFireOnly ) then
		
			return "Single";
			
		end
		
	end
	
end;

hook.Add( "TFA_GetStat", "Cyberpunk.Statistics", function( weapon, stat, value )

	if( GAMEMODE.WeaponStatistics[stat] ) then
	
		local result = GAMEMODE.WeaponStatistics[stat]( weapon, value );
		if( result ~= nil ) then
		
			return result;
		
		end
	
	end
	
end );

hook.Add( "TFA_PreCanPrimaryAttack", "Cyberpunk.PreventFire", function( weapon )

	if( GAMEMODE:LookupCombineFlag( weapon:GetOwner():ActiveFlag() ) ) then
	
		if( weapon.ItemClass ) then
		
			local itemTable = GAMEMODE:GetItemByID( weapon.ItemClass );
			if( itemTable.SmartGun and !weapon:GetOwner():CanFireWeapon() ) then
			
				return false;
				
			end
			
		end
		
	end

end );

if( CLIENT ) then

	net.Receive( "nAssignItemToWeapon", function( len )
	
		local index = net.ReadInt( 32 );
		local item = net.ReadString();
		
		local metaitem = GAMEMODE:GetItemByID( item );
		local weapon = ents.GetByIndex( index );
		if( weapon and weapon:IsValid() ) then
		
			weapon.ItemClass = item;
			if( metaitem.SingleFireOnly and weapon.Primary ) then
			
				weapon.Primary.Automatic = false;
				
			end
		
		end
	
	end );

else
	
	util.AddNetworkString( "nAssignItemToWeapon" );
	
end