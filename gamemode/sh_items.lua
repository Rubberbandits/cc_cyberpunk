GM.Items = { };

local files = file.Find( GM.FolderName .. "/gamemode/items/*.lua", "LUA", "namedesc" );

if( #files > 0 ) then

	for _, v in pairs( files ) do
		
		ITEM = { };
		ITEM.ID				= "";
		ITEM.Name 			= "";
		ITEM.Description	= "";
		ITEM.Model			= "";
		ITEM.Weight			= 1;
		
		ITEM.ProcessEntity	= function() end;
		ITEM.ProcessEntity	= function() end;
		ITEM.IconMaterial	= nil;
		ITEM.IconColor		= nil;
		
		ITEM.Usable			= false;
		ITEM.Droppable		= true;
		ITEM.Throwable		= true;
		ITEM.UseText		= nil;
		ITEM.DeleteOnUse	= false;
		
		ITEM.OnPlayerUse	= function() end;
		ITEM.OnPlayerSpawn	= function() end;
		ITEM.OnPlayerPickup	= function() end;
		ITEM.OnPlayerDeath	= function() end;
		ITEM.OnRemoved		= function() end;
		ITEM.Think			= function() end;
		
		AddCSLuaFile( "items/" .. v );
		include( "items/" .. v );
		
		if( ITEM.Clothes ) then
			
			ITEM.Usable			= true;
			ITEM.UseText		= "Equip";
			ITEM.GetUseText = function( ply, item )
				
				if( ply:IsItemEquipped( item ) ) then
				
					return "Unequip";
					
				end
				
				return "Equip";
			
			end
			if( !ITEM.Bodygroup ) then
			
				ITEM.DeleteOnUse	= true;
				
			end
			
			ITEM.OnPlayerUse	= function( self, ply )
				
				local cur = ply:TranslatePlayerModel();
				local itemTable = GAMEMODE:GetItemByID( self );
				
				if( !cur ) then
					
					if( CLIENT ) then
						
						GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You can't wear these with what you're wearing right now.", { CB_ALL, CB_IC } );
						
					end
					
					return true;
					
				end
				
				if( cur == GAMEMODE:GetItemByID( self ).Clothes ) then
					
					if( CLIENT ) then
						
						GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You're already wearing those.", { CB_ALL, CB_IC } );
						
					end
					
					return true;
					
				end
				
				if( CLIENT ) then
					
					GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You change clothes.", { CB_ALL, CB_IC } );
					
				else
				
					if (itemTable.Submaterial) then
					
						ply:SetSubMaterial(itemTable.Submaterial[1], itemTable.Submaterial[2])
						
					end

					ply:SetModelCC( string.gsub( ply:GetModel(), cur, GAMEMODE:GetItemByID( self ).Clothes ) );
					ply:UpdateCharacterField( "Model", ply:GetModel() );
					ply.CharModel = ply:GetModel();
					
					if( cur == "group01" ) then -- fuck off disseminate
						
						ply:GiveItem( "citizenclothes", nil, true );
						
					end
					
					if( cur == "group03" ) then
						
						ply:GiveItem( "rebelclothes", nil, true );
						
					end
					
					if( cur == "group03m" ) then
						
						ply:GiveItem( "medicclothes", nil, true );
						
					end
					
				end
				
			end
			
			if( ITEM.Bodygroup ) then
			
				ITEM.OnPlayerUse = function( self, ply )
				
					local itemTable = GAMEMODE:GetItemByID( self );
					local tab = util.JSONToTable( ply:GetCharFromID( ply:CharID() ).EquippedItems or "" ) or {};

					for k,v in next, tab do -- prevents two items of the same bodygroup category from being equipped at same time
					
						local item = GAMEMODE:GetItemByID( v );
						
						if( item and !ply:IsItemEquipped( v ) ) then

							if( item.Bodygroup == itemTable.Bodygroup ) then
							
								if( CLIENT ) then
								
									GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You've already got an item of the same category equipped.", { CB_ALL, CB_IC } );
								
								end
								
								return true;
								
							end
							
						end
					
					end
					
					if( CLIENT ) then
						
						if( !ply:IsItemEquipped( self ) ) then
					
							ply:EquipItem( self );
							GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You change clothes.", { CB_ALL, CB_IC } );
							
						else
						
							ply:UnequipItem( self );
							GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You unequip this item.", { CB_ALL, CB_IC } );
							
						end
						
					else
					
						if (itemTable.Submaterial) then
							ply:SetSubMaterial(itemTable.Submaterial[1], itemTable.Submaterial[2])
						end
						
						if( !ply:IsItemEquipped( self ) ) then
					
							ply:SetBodygroup( itemTable.Bodygroup, itemTable.BodygroupValue );
							ply:EquipItem( self );
							
						else
						
							if (itemTable.Submaterial) then
							 
								ply:SetSubMaterial( itemTable.Submaterial[1], "" )
								
							end

							ply:SetBodygroup( itemTable.Bodygroup, 0 );
							ply:UnequipItem( self );
							
						end
						
					end
					
				end
				
				ITEM.OnPlayerSpawn = function( self, ply ) 
				
					local itemTable =  GAMEMODE:GetItemByID( self );
					if( ply:IsItemEquipped( self ) ) then
					
						ply:SetBodygroup( itemTable.Bodygroup, itemTable.BodygroupValue );
						if ( itemTable.Submaterial ) then
						
							ply:SetSubMaterial( itemTable.Submaterial[1], itemTable.Submaterial[2] );
							
						end
						
					end
				
				end
				
				ITEM.OnRemoved = function( self, ply )
				
					local itemTable =  GAMEMODE:GetItemByID( self );
					
					if( ply:IsItemEquipped( self ) ) then
				
						ply:SetBodygroup( itemTable.Bodygroup, 0 );
						ply:UnequipItem( self );
						
					end
				
				end
				
			end
			
		end
		
		if( ITEM.Uniform ) then
			
			ITEM.Usable			= true;
			ITEM.UseText		= "Wear";
			
			ITEM.OnPlayerUse	= function( self, ply )
				
				local new = GAMEMODE:GetItemByID( self ).Uniform( self, ply );
				
				if( !new and !ply.Uniform ) then
					
					return;
					
				end
				
				if( SERVER ) then
					
					if( ply.Uniform ) then
					
						if( !ply:IsItemEquipped( self ) ) then
						
							return
							
						end
						
						ply:SetModelCC( ply.CharModel );
						ply.Uniform = nil;
						ply:UnequipItem( self );
						ply:SetSkin( ply:GetCharFromID( ply:CharID() ).Skingroup );
						
					else
					
						if( ply:IsItemEquipped( self ) ) then

							return
							
						end
						
						for k,v in next, util.JSONToTable( ply:GetCharFromID( ply:CharID() ).EquippedItems or "" ) or {} do
						
							if( GAMEMODE:GetItemByID( v ).Uniform ) then

								if( v != self ) then

									return
									
								end
							
							end
						
						end
						
						ply:SetModelCC( new );
						ply.Uniform = new;
						ply:EquipItem( self );
						
						if ( GAMEMODE:GetItemByID( self ).Submaterial ) then
						
							for k,v in next, GAMEMODE:GetItemByID( self ).Submaterial do
						
								ply:SetSubMaterial( v[1], v[2] );
								
							end
							
						end
						
						if( GAMEMODE:GetItemByID( self ).UniformColor ) then
							
							local c = GAMEMODE:GetItemByID( self ).UniformColor;
							ply:SetPlayerColor( Vector( c.r / 255, c.g / 255, c.b / 255 ) );
							
						end
						
					end
				
				else
				
					if( ply:IsItemEquipped( self ) ) then
						
						ply.Uniform = nil;
						ply:UnequipItem( self );
						
					else
						
						if( ply:IsItemEquipped( self ) ) then
						
							return
							
						end
						
						for k,v in next, util.JSONToTable( ply:GetCharFromID( ply:CharID() ).EquippedItems or "" ) or {} do
							
							if( GAMEMODE:GetItemByID( v ).Uniform ) then
							
								if( v != self ) then
								
									GAMEMODE:AddChat( Color( 255, 0, 0, 255 ), "CombineControl.ChatNormal", "You already have a suit equipped.", { CB_ALL, CB_IC } );
									return
									
								end
							
							end
						
						end
						
						ply.Uniform = new;
						ply:EquipItem( self );
						
					end
				
				end
				
			end
			
		end
		
		table.insert( GM.Items, ITEM );
		
		if( !ITEM.EasterEgg ) then
			
			--MsgC( Color( 200, 200, 200, 255 ), "Item " .. v .. " loaded.\n" );
			
		end
		
	end
	
else
	
	if( SERVER ) then
		
		GM:LogBug( "Warning: No items found.", true );
		
	end
	
end

/*

	Start TFA Compatibility

*/

GM.ChangeWeaponAmmo = {};

hook.Add( "TFA_GetStat", "Cyberpunk.AmmoSystem", function( wep, stat, value )

	if( stat == "Primary.Ammo" and GAMEMODE.ChangeWeaponAmmo[wep:GetClass()] ) then
	
		return GAMEMODE.ChangeWeaponAmmo[wep:GetClass()];
	
	end

end );

local files = file.Find( GM.FolderName .. "/gamemode/items/weapons/*.lua", "LUA", "namedesc" );
if( #files > 0 ) then

	for _, v in pairs( files ) do
		
		ITEM = { };
		ITEM.ID				= "";
		ITEM.Name 			= "";
		ITEM.Description	= "";
		ITEM.Model			= "";
		ITEM.Weight			= 1;
		
		ITEM.ProcessEntity	= function() end;
		ITEM.ProcessEntity	= function() end;
		ITEM.IconMaterial	= nil;
		ITEM.IconColor		= nil;
		
		ITEM.Weapon			= true;
		
		ITEM.OnPlayerUse	= function() end;
		ITEM.OnPlayerSpawn	= function() end;
		ITEM.OnPlayerPickup	= function() end;
		ITEM.OnPlayerDeath	= function() end;
		ITEM.OnRemoved		= function() end;
		ITEM.Think			= function() end;
		
		AddCSLuaFile( "items/weapons/" .. v );
		include( "items/weapons/" .. v );
		
		if( !ITEM.WeaponClass ) then
		
			MsgC( Color( 200, 200, 200, 255 ), "Item is missing WeaponClass!!!! Item " .. v .. " will not load!\n" );
			return;
			
		end
		
		ITEM.Droppable		= true;
		ITEM.Throwable		= true;
		ITEM.Usable			= false;
		ITEM.UseText		= nil;
		
		if( ITEM.AmmoType ) then
		
			GM.ChangeWeaponAmmo[ITEM.WeaponClass] = ITEM.AmmoType;
		
		end
		
		function ITEM.OnPlayerSpawn( item, ply )
			
			local metaitem = GAMEMODE:GetItemByID( item );
			if( SERVER ) then
				
				local weapon = ply:Give( metaitem.WeaponClass );
				if( weapon and weapon:IsValid() ) then
					
					weapon.ItemClass = item;
					if( metaitem.SingleFireOnly ) then
					
						weapon:SetFireMode(1);
						weapon.Primary.Automatic = false;
						
					end
					timer.Simple( 0.1, function()
					
						net.Start( "nAssignItemToWeapon" );
							net.WriteInt( weapon:EntIndex(), 32 );
							net.WriteString( item );
						net.Send( ply );
						
					end );
					
				end
				
			end
			
		end;
		
		function ITEM.OnPlayerPickup( item, ply )
			
			local metaitem = GAMEMODE:GetItemByID( item );
			if( SERVER ) then
				
				local weapon = ply:Give( metaitem.WeaponClass );
				if( weapon and weapon:IsValid() ) then
					
					weapon.ItemClass = item;
					if( metaitem.SingleFireOnly ) then
					
						weapon:SetFireMode(1);
						weapon.Primary.Automatic = false;
						
					end
					timer.Simple( 0.1, function()
					
						net.Start( "nAssignItemToWeapon" );
							net.WriteInt( weapon:EntIndex(), 32 );
							net.WriteString( item );
						net.Send( ply );
						
					end );
					
				end
				
			end
			
		end;
		
		function ITEM.OnRemoved( item, ply )
			
			local metaitem = GAMEMODE:GetItemByID( item );
			if( SERVER and ply:GetNumItems( item ) < 2 ) then
				
				ply:StripWeapon( metaitem.WeaponClass );
				
			end
			
		end;
	
		table.insert( GM.Items, ITEM );
	
	end
	
end

local files = file.Find( GM.FolderName .. "/gamemode/items/stims/*.lua", "LUA", "namedesc" );
if( #files > 0 ) then

	for _, v in pairs( files ) do
		
		ITEM = { };
		ITEM.ID				= "";
		ITEM.Name 			= "";
		ITEM.Description	= "";
		ITEM.Model			= "";
		ITEM.Weight			= 1;
		
		ITEM.ProcessEntity	= function() end;
		ITEM.ProcessEntity	= function() end;
		ITEM.IconMaterial	= nil;
		ITEM.IconColor		= nil;
		
		ITEM.Stim		= true;
		
		ITEM.OnPlayerUse	= function() end;
		ITEM.OnPlayerSpawn	= function() end;
		ITEM.OnPlayerPickup	= function() end;
		ITEM.OnPlayerDeath	= function() end;
		ITEM.OnRemoved		= function() end;
		ITEM.Think			= function() end;
		
		ITEM.DeleteOnUse	= true;
		ITEM.CanPlayerUse = function( self, ply )
		
			if( !ply:HasAugment( "diffusor" ) ) then return false end
			if( ply:HasActiveStim( self ) ) then return false end
		
		end;
		ITEM.OnPlayerUse = function( self, ply )
		
			if( CLIENT ) then
				
				GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You take the vial of serum, injecting it into the small receptacle on your neck.", { CB_ALL, CB_IC } );
				
			else
			
				ply:AddStimEffect( self );
				
			end
		
		end;
		ITEM.OnStimGiven = function( self, ply )

			if( SERVER ) then
		
				local metaitem = GAMEMODE:GetItemByID( self );
				if( metaitem.StatModifiers ) then
				
					for k,v in next, metaitem.StatModifiers do
					
						ply["Set"..k]( ply, math.Clamp( ply[k](ply) + v, 1, 10 ) );
						
					end
					
				end
				if( metaitem.HealthModifier ) then
				
					ply:SetMaxHealth( ply:GetMaxHealth() + metaitem.HealthModifier );
					ply:SetHealth( ply:GetMaxHealth() );
					
				end
				
			end
	
		end;
		ITEM.OnStimTaken = function( self, ply )

			if( SERVER ) then
		
				local metaitem = GAMEMODE:GetItemByID( self );
				if( metaitem.StatModifiers ) then
				
					for k,v in next, metaitem.StatModifiers do
					
						ply["Set"..k]( ply, math.Clamp( ply[k](ply) - v, 1, 10 ) );
						
					end
					
				end
				if( metaitem.HealthModifier ) then
				
					ply:SetMaxHealth( ply:GetMaxHealth() - metaitem.HealthModifier );
					if( ply:Health() > ply:GetMaxHealth() ) then
					
						ply:SetHealth( ply:GetMaxHealth() );
						
					end
					
				end
				
			end
		
		end;
		
		AddCSLuaFile( "items/stims/" .. v );
		include( "items/stims/" .. v );
		
		ITEM.Droppable		= true;
		ITEM.Throwable		= false;
		ITEM.Usable			= true;
		ITEM.UseText		= "Inject";
	
		table.insert( GM.Items, ITEM );
	
	end
	
end

local files = file.Find( GM.FolderName .. "/gamemode/items/augments/*.lua", "LUA", "namedesc" );
if( #files > 0 ) then

	for _, v in pairs( files ) do
		
		ITEM = { };
		ITEM.ID				= "";
		ITEM.Name 			= "";
		ITEM.Description	= "";
		ITEM.Model			= "";
		ITEM.Weight			= 1;
		
		ITEM.ProcessEntity	= function() end;
		ITEM.ProcessEntity	= function() end;
		ITEM.IconMaterial	= nil;
		ITEM.IconColor		= nil;
		
		ITEM.Augment		= true;
		
		ITEM.OnPlayerUse	= function() end;
		ITEM.OnPlayerSpawn	= function() end;
		ITEM.OnPlayerPickup	= function() end;
		ITEM.OnPlayerDeath	= function() end;
		ITEM.OnRemoved		= function() end;
		ITEM.Think			= function() end;
		ITEM.GetTooltip		= function( self, ply )
		
			local metaitem = GAMEMODE:GetItemByID( self );
			if( metaitem ) then
			
				return metaitem.Description;
				
			end
			
			return "";
		
		end;
		ITEM.OnAugmentGiven = function( self, ply )
		
			local metaitem = GAMEMODE:GetItemByID( self );
			if( metaitem.StatModifiers ) then
			
				for k,v in next, metaitem.StatModifiers do
				
					ply["Set"..k]( ply, math.Clamp( ply[k](ply) + v, 1, 10 ) );
					
				end
				
			end
			if( metaitem.HealthModifier ) then
			
				ply:SetMaxHealth( ply:GetMaxHealth() + metaitem.HealthModifier );
				ply:SetHealth( ply:GetMaxHealth() );
				
			end
			if( metaitem.ArmorModifier ) then
			
				ply:SetArmor( ply:Armor() + metaitem.ArmorModifier );
				
			end
			if( metaitem.EnableZoom ) then
			
				ply:SetCanZoom( true );
				
			end
			if( metaitem.DescriptionModifier ) then
			
				ply:SetDescriptionModifier( metaitem.DescriptionModifier );
				
			end
	
		end;
		ITEM.OnAugmentSpawn = function( self, ply )
		
			local metaitem = GAMEMODE:GetItemByID( self );
			if( metaitem.StatModifiers ) then
			
				for k,v in next, metaitem.StatModifiers do
				
					ply["Set"..k]( ply, math.Clamp( ply[k](ply) + v, 1, 10 ) );
					
				end
				
			end
			if( metaitem.HealthModifier ) then
			
				ply:SetMaxHealth( ply:GetMaxHealth() + metaitem.HealthModifier );
				ply:SetHealth( ply:GetMaxHealth() );
				
			end
			if( metaitem.ArmorModifier ) then
			
				ply:SetArmor( ply:Armor() + metaitem.ArmorModifier );
				
			end
			if( metaitem.EnableZoom ) then
			
				ply:SetCanZoom( true );
				
			end
			if( metaitem.DescriptionModifier ) then
			
				ply:SetDescriptionModifier( metaitem.DescriptionModifier );
				
			end
			
		end;
		ITEM.OnAugmentTaken = function( self, ply )
		
			local metaitem = GAMEMODE:GetItemByID( self );
			if( metaitem.StatModifiers ) then
			
				for k,v in next, metaitem.StatModifiers do
				
					ply["Set"..k]( ply, ply:GetCharFromID( ply:CharID() )["Stat"..k] );
					
				end
				
			end
			if( metaitem.HealthModifier ) then
			
				ply:SetMaxHealth( 100 );
				ply:SetHealth( ply:GetMaxHealth() );
				
			end
			if( metaitem.ArmorModifier ) then
			
				ply:SetArmor( 0 );
				
			end
			if( metaitem.EnableZoom ) then
			
				ply:SetCanZoom( false );
				
			end
			if( metaitem.DescriptionModifier ) then
			
				ply:SetDescriptionModifier( "" );
				
			end
		
		end;
		
		AddCSLuaFile( "items/augments/" .. v );
		include( "items/augments/" .. v );
		
		ITEM.Droppable		= true;
		ITEM.Throwable		= false;
		ITEM.Usable			= false;
		ITEM.UseText		= nil;
	
		table.insert( GM.Items, ITEM );
	
	end
	
end

function GM:LoadWeaponItems()

	for _, v in pairs( weapons.GetList() ) do
	
				for m,n in next, self.Items do
		
			if( n.WeaponClass == v.ClassName ) then
		
				local weaponTable = weapons.GetStored( v.ClassName );
				if( n.SlotPos ) then
				
					weaponTable.SlotPos = n.SlotPos;
				
				end
				
				if( n.Slot ) then
				
					weaponTable.Slot = n.Slot;
					
				end
				
				if( n.WorldModelScale ) then
				
					weaponTable.Offset["Scale"] = n.WorldModelScale;
					
				end
	
				weaponTable.PrintName = n.Name;
			
			end
		
		end
		
		if( v.Itemize ) then
			
			ITEM = { };
			ITEM.ID				= v.ClassName;
			ITEM.Name 			= v.PrintName;
			ITEM.Description	= v.ItemDescription or "";
			ITEM.Model			= v.WorldModel;
			ITEM.Weight			= v.ItemWeight or 1;
			
			ITEM.EasterEgg		= v.ItemEasterEgg;
			
			ITEM.FOV			= v.ItemFOV;
			ITEM.CamPos			= v.ItemCamPos;
			ITEM.LookAt			= v.ItemLookAt;
			
			ITEM.Weapon			= true;
			
			ITEM.ProcessEntity	= v.ItemProcessEntity;
			ITEM.PProcessEntity	= v.ItemPProcessEntity;
			ITEM.IconMaterial	= v.ItemIconMaterial;
			ITEM.IconColor		= v.ItemIconColor;
			
			ITEM.BulkPrice		= v.ItemBulkPrice;
			ITEM.SinglePrice	= v.ItemSinglePrice;
			ITEM.License		= v.ItemLicense;
			
			ITEM.Droppable		= true;
			ITEM.Throwable		= true;
			ITEM.Usable			= false;
			ITEM.UseText		= nil;
			
			function ITEM.OnPlayerSpawn( item, ply )
				
				if( SERVER ) then
					
					ply:Give( item );
					
				end
				
			end;
			
			function ITEM.OnPlayerPickup( item, ply )
				
				if( SERVER ) then
					
					ply:Give( item );
					
				end
				
			end;
			
			function ITEM.OnRemoved( item, ply )
				
				if( SERVER and ply:GetNumItems( item ) < 2 ) then
					
					ply:StripWeapon( item );
					
				end
				
			end;
			
			table.insert( self.Items, ITEM );
			
			if( !ITEM.EasterEgg ) then
				
				MsgC( Color( 200, 200, 200, 255 ), "Weapon item " .. v.ClassName .. " loaded.\n" );
				
			end
			
		end
		
	end
	
end

local meta = FindMetaTable( "Player" );

function meta:GetEquippedItems( szItem )

	local tbl = util.JSONToTable( self:GetCharFromID( self:CharID() ).EquippedItems or "" ) or {};
	
	return tbl;

end

function meta:IsItemEquipped( szItem )

	local tbl = util.JSONToTable( self:GetCharFromID( self:CharID() ).EquippedItems or "" ) or {};
	
	for k,v in next, tbl do
	
		if( v == szItem ) then
		
			return true;
		
		end
	
	end
	
	return false;

end

function meta:EquipItem( szItem )

	local tbl = util.JSONToTable( self:GetCharFromID( self:CharID() ).EquippedItems or "" ) or {};
	
	if( self.Inventory[self:GetDutyInventory()] and table.HasValue( self.Inventory[self:GetDutyInventory()], szItem ) ) then
	
		tbl[#tbl + 1] = szItem;
		if( SERVER ) then
	
			self:UpdateCharacterField( "EquippedItems", util.TableToJSON( tbl ) );
			
		else
		
			self:GetCharFromID( self:CharID() ).EquippedItems = util.TableToJSON( tbl );
		
		end
		return true;
		
	end
	
	return false;

end

function meta:UnequipItem( szItem )

	local tbl = util.JSONToTable( self:GetCharFromID( self:CharID() ).EquippedItems or "" ) or {};
	
	for k,v in next, tbl do
	
		if( v == szItem ) then
		
			table.remove( tbl, k );
			if( SERVER ) then
		
				self:UpdateCharacterField( "EquippedItems", util.TableToJSON( tbl ) );
				
			else
			
				self:GetCharFromID( self:CharID() ).EquippedItems = util.TableToJSON( tbl );
			
			end
			return true;
			
		end
	
	end
	
	return false;

end

function GM:GetItemByID( id )
	
	for _, v in pairs( self.Items ) do
		
		if( v.ID == id ) then
			
			return v;
			
		end
		
	end
	
end

function GM:CreateItem( ply, item )
	
	local trace = { };
	trace.start = ply:GetShootPos();
	trace.endpos = trace.start + ply:GetAimVector() * 50;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	
	local ent = self:CreatePhysicalItem( item, tr.HitPos + tr.HitNormal * 10, Angle() );
	
	ent:SetPropSteamID( ply:SteamID() );
	
	return ent;
	
end

function GM:CreatePhysicalItem( item, pos, ang )
	
	local e = ents.Create( "cc_item" );
	
	e:SetItem( item );
	
	e:SetModel( GAMEMODE:GetItemByID( item ).Model );
	
	local i = GAMEMODE:GetItemByID( item );
	
	if( i.ItemSubmaterials ) then for m,n in next, i.ItemSubmaterials do e:SetSubMaterial( n[1], n[2] ) end end
	
	e:SetPos( pos );
	e:SetAngles( ang );
	
	if( GAMEMODE:GetItemByID( item ).ProcessEntity ) then
		
		GAMEMODE:GetItemByID( item ).ProcessEntity( item, e );
		
	end
	
	e:Spawn();
	e:Activate();
	
	if( GAMEMODE:GetItemByID( item ).PProcessEntity ) then
		
		GAMEMODE:GetItemByID( item ).PProcessEntity( item, e );
		
	end
	
	if( e:GetPhysicsObject() and e:GetPhysicsObject():IsValid() ) then
		
		e:GetPhysicsObject():Wake();
		
	end
	
	return e;
	
end

local function LoadBook( contents, size, headers, code )
	
	local lines = string.Explode( "\n", string.gsub( contents, "\t", "     " ) );
	
	local title = lines[1];
	table.remove( lines, 1 );
	
	local desc = lines[1];
	table.remove( lines, 1 );
	
	local model = lines[1];
	table.remove( lines, 1 );
	
	local code = lines[1];
	table.remove( lines, 1 );
	
	GAMEMODE.Books[title] = { };
	
	local nextNewChapter = false;
	local curTitle = "";
	local curText = "";
	
	for k, v in pairs( lines ) do
		
		if( k == #lines ) then
			
			curText = curText .. string.gsub( v, "|", "" );
			
			table.insert( GAMEMODE.Books[title], { curTitle, curText } );
			
			break;
			
		end
		
		local p = string.find( v, "|", nil, true );
		
		if( p == 1 ) then
			
			if( string.len( curTitle ) > 0 ) then
				
				table.insert( GAMEMODE.Books[title], { curTitle, curText } );
				
			end
			
			curTitle = string.gsub( v, "|", "" );
			curText = "";
			
		else
			
			curText = curText .. string.gsub( v, "|", "" ) .. "\n";
			
		end
		
	end
	
	ITEM = { };
	ITEM.ID				= code;
	ITEM.Name 			= title;
	ITEM.Description	= desc;
	ITEM.Model			= model;
	ITEM.Weight			= 1;
	
	ITEM.FOV			= 13;
	ITEM.CamPos 		= Vector( 50, 50, 50 );
	ITEM.LookAt 		= Vector( 0, 0, 5.73 );
	ITEM.BookID			= title;
	
	ITEM.ProcessEntity	= function() end;
	ITEM.ProcessEntity	= function() end;
	ITEM.IconMaterial	= nil;
	ITEM.IconColor		= nil;
	
	ITEM.Usable			= true;
	ITEM.Droppable		= true;
	ITEM.Throwable		= true;
	ITEM.UseText		= "Read";
	ITEM.DeleteOnUse	= false;
	
	ITEM.OnPlayerUse = function( self, ply )
		
		if( SERVER ) then return end
		
		if( CCP.Book ) then CCP.Book:Remove() end
		
		CCP.Book = vgui.Create( "DFrame" );
		CCP.Book:SetSize( 800, 600 );
		CCP.Book:Center();
		CCP.Book:SetTitle( GAMEMODE:GetItemByID( self ).BookID );
		CCP.Book.lblTitle:SetFont( "CombineControl.Window" );
		CCP.Book:MakePopup();
		CCP.Book.PerformLayout = CCFramePerformLayout;
		CCP.Book:PerformLayout();
		CCP.Book.ChapterNum = 1;
		CCP.Book.BookID = GAMEMODE:GetItemByID( self ).BookID;
		
		local scroll = vgui.Create( "DScrollPanel", CCP.Book );
		scroll:SetPos( 10, 64 );
		scroll:SetSize( 780, 526 );
		function scroll:Paint( w, h )
			
			surface.SetDrawColor( 30, 30, 30, 150 );
			surface.DrawRect( 0, 0, w, h );
			
			surface.SetDrawColor( 20, 20, 20, 100 );
			surface.DrawOutlinedRect( 0, 0, w, h );
			
		end
		
		CCP.Book.Text = vgui.Create( "CCLabel", scroll );
		CCP.Book.Text:SetPos( 0, 0 );
		CCP.Book.Text:SetSize( 780, 526 );
		CCP.Book.Text:SetFont( "CombineControl.LabelSmall" );
		CCP.Book.Text:SetText( GAMEMODE.Books[GAMEMODE:GetItemByID( self ).BookID][1][2] );
		CCP.Book.Text:PerformLayout();
		
		local function UpdateChapter()
			
			CCP.Book.Chapter:SetText( GAMEMODE.Books[GAMEMODE:GetItemByID( self ).BookID][CCP.Book.ChapterNum][1] );
			CCP.Book.Chapter:SizeToContents();
			CCP.Book.Chapter:PerformLayout();
			CCP.Book.Text:SetText( GAMEMODE.Books[GAMEMODE:GetItemByID( self ).BookID][CCP.Book.ChapterNum][2] );
			CCP.Book.Text:PerformLayout();
			
		end
		
		local left = vgui.Create( "DButton", CCP.Book );
		left:SetFont( "CombineControl.LabelSmall" );
		left:SetText( "<<" );
		left:SetPos( 720, 34 );
		left:SetSize( 30, 20 );
		left.DoClick = function( self )
			
			CCP.Book.ChapterNum = math.Clamp( CCP.Book.ChapterNum - 1, 1, #GAMEMODE.Books[CCP.Book.BookID] );
			UpdateChapter();
			
		end
		left:PerformLayout();
		
		local right = vgui.Create( "DButton", CCP.Book );
		right:SetFont( "CombineControl.LabelSmall" );
		right:SetText( ">>" );
		right:SetPos( 760, 34 );
		right:SetSize( 30, 20 );
		right.DoClick = function( self )
			
			CCP.Book.ChapterNum = math.Clamp( CCP.Book.ChapterNum + 1, 1, #GAMEMODE.Books[CCP.Book.BookID] );
			UpdateChapter();
			
		end
		right:PerformLayout();
		
		CCP.Book.Chapter = vgui.Create( "DLabel", CCP.Book );
		CCP.Book.Chapter:SetText( GAMEMODE.Books[CCP.Book.BookID][1][1] );
		CCP.Book.Chapter:SetPos( 10, 34 );
		CCP.Book.Chapter:SetFont( "CombineControl.LabelBig" );
		CCP.Book.Chapter:SizeToContents();
		CCP.Book.Chapter:PerformLayout();
		
	end
	ITEM.OnPlayerSpawn	= function() end;
	ITEM.OnPlayerPickup	= function() end;
	ITEM.OnPlayerDeath	= function() end;
	ITEM.OnRemoved		= function() end;
	ITEM.Think			= function() end;
	
	table.insert( GAMEMODE.Items, ITEM );
	MsgC( Color( 200, 200, 200, 255 ), "Item " .. code .. " loaded.\n" );
	
end

local function FailedBook( err )
	
	
	
end

function GM:LoadBooks()
	
	self.Books = { };
	
	if( self.BooksURL != "" ) then
		
		http.Fetch( self.BooksURL .. "_index.txt", function( c )
			
			local list = string.Explode( "\n", c );
			
			MsgC( Color( 200, 200, 200, 255 ), "Loading " .. #list .. " books...\n" );
			
			for _, v in pairs( list ) do
				
				http.Fetch( self.BooksURL .. v, LoadBook, FailedBook );
				
			end
			
		end, function( err )
			
			MsgC( Color( 200, 0, 0, 255 ), "Error loading books.\n" );
			
		end );
		
	else
		
		MsgC( Color( 200, 200, 200, 255 ), "No book data specified - skipping...\n" );
		
	end
	
end