function GM:OpenAugmentInstall( target )

	CCP.AugmentsPanel = vgui.Create( "DFrame" );
	CCP.AugmentsPanel:SetSize( 300, 600 );
	CCP.AugmentsPanel:SetTitle( target:RPName() );
	CCP.AugmentsPanel:Center();
	CCP.AugmentsPanel:MakePopup();

	CCP.AugmentsPanel.AugmentsContainer = vgui.Create( "DPanel", CCP.AugmentsPanel );
	CCP.AugmentsPanel.AugmentsContainer:SetSize( 280, 530 );
	CCP.AugmentsPanel.AugmentsContainer:SetPos( 10, 32 );
	
	CCP.AugmentsPanel.AugmentsScroll = vgui.Create( "DScrollPanel", CCP.AugmentsPanel.AugmentsContainer );
	CCP.AugmentsPanel.AugmentsScroll:SetSize( 280, 530 );
	function CCP.AugmentsPanel.AugmentsScroll:Clear()
	
		for k,v in next, self:GetCanvas():GetChildren() do
		
			v:Remove();
		
		end
	
	end
	
	for k,v in next, LocalPlayer().Inventory[LocalPlayer():GetDutyInventory()] do
	
		local metaitem = GAMEMODE:GetItemByID( v );
		if( metaitem and metaitem.Augment ) then
		
			local but = vgui.Create( "DButton", CCP.AugmentsPanel.AugmentsScroll );
			but:SetSize( CCP.AugmentsPanel.AugmentsContainer:GetWide() - CCP.AugmentsPanel.AugmentsScroll:GetVBar():GetWide(), 20 );
			but:Dock( TOP );
			but:SetText( metaitem.Name );
			but:SetTooltip( metaitem.GetTooltip( v, target ) );
			but.Augment = v;
			but:SetFont( "CombineControl.LabelSmall" );
			function but:DoClick()
			
				CCP.AugmentsPanel.SelectedAugment = self;
			
			end
			function but:Paint( w, h )
			
				if( !CCP.AugmentsPanel ) then return end
				if( CCP.AugmentsPanel.SelectedAugment != self ) then
			
					surface.SetDrawColor( 40, 40, 40, 255 );
					surface.DrawRect( 0, 0, w, h );
			
					if( self:GetDisabled() ) then
						surface.SetDrawColor( 30, 30, 30, 255 );
						surface.DrawRect( 1, 1, w - 2, h - 2 );
						return;
					end	
			
					surface.SetDrawColor( 60, 60, 60, 255 );
					surface.DrawRect( 1, 1, w - 2, h - 2 );
					
				else
				
					surface.SetDrawColor( 40, 40, 40, 255 );
					surface.DrawRect( 0, 0, w, h );
			
					surface.SetDrawColor( 150, 20, 20, 255 );
					surface.DrawRect( 1, 1, w - 2, h - 2 );
				
				end
			
			end
		
		end
		
	end
	
	CCP.AugmentsPanel.Install = vgui.Create( "DButton", CCP.AugmentsPanel );
	CCP.AugmentsPanel.Install:SetSize( CCP.AugmentsPanel.AugmentsContainer:GetWide(), 24 );
	CCP.AugmentsPanel.Install:SetPos( 10, 568 );
	CCP.AugmentsPanel.Install:SetText( "Install" );
	function CCP.AugmentsPanel.Install:DoClick()
	
		if( !CCP.AugmentsPanel.SelectedAugment ) then return end
	
		local augment = CCP.AugmentsPanel.SelectedAugment.Augment;
		local metaitem = GAMEMODE:GetItemByID( augment );
		
		net.Start( "nStartAugmentInstall" );
			net.WriteEntity( target );
			net.WriteString( augment );
		net.SendToServer();
	
		GAMEMODE:CreateTimedProgressBar( GAMEMODE:CalculateInstallTime( LocalPlayer(), augment ) + 1,
		"Installing "..metaitem.Name, target, function()

			net.Start( "nEndAugmentInstall" );
			net.SendToServer();

		end	);
		
		CCP.AugmentsPanel:Close();
	
	end
	
end

function GM:OpenAugmentRemove( target )

	CCP.AugmentsPanel = vgui.Create( "DFrame" );
	CCP.AugmentsPanel:SetSize( 300, 600 );
	CCP.AugmentsPanel:SetTitle( target:RPName() );
	CCP.AugmentsPanel:Center();
	CCP.AugmentsPanel:MakePopup();

	CCP.AugmentsPanel.AugmentsContainer = vgui.Create( "DPanel", CCP.AugmentsPanel );
	CCP.AugmentsPanel.AugmentsContainer:SetSize( 280, 530 );
	CCP.AugmentsPanel.AugmentsContainer:SetPos( 10, 32 );
	
	CCP.AugmentsPanel.AugmentsScroll = vgui.Create( "DScrollPanel", CCP.AugmentsPanel.AugmentsContainer );
	CCP.AugmentsPanel.AugmentsScroll:SetSize( 280, 530 );
	function CCP.AugmentsPanel.AugmentsScroll:Clear()
	
		for k,v in next, self:GetCanvas():GetChildren() do
		
			v:Remove();
		
		end
	
	end
	
	CCP.AugmentsPanel.RemoveAugment = vgui.Create( "DButton", CCP.AugmentsPanel );
	CCP.AugmentsPanel.RemoveAugment:SetSize( CCP.AugmentsPanel.AugmentsContainer:GetWide(), 24 );
	CCP.AugmentsPanel.RemoveAugment:SetPos( 10, 568 );
	CCP.AugmentsPanel.RemoveAugment:SetText( "Remove" );
	function CCP.AugmentsPanel.RemoveAugment:DoClick()
	
		if( !CCP.AugmentsPanel.SelectedAugment ) then return end
	
		local augment = CCP.AugmentsPanel.SelectedAugment.Augment;
		local metaitem = GAMEMODE:GetItemByID( augment );
		
		net.Start( "nStartAugmentRemove" );
			net.WriteEntity( target );
			net.WriteString( augment );
		net.SendToServer();
	
		GAMEMODE:CreateTimedProgressBar( GAMEMODE:CalculateInstallTime( LocalPlayer(), augment ) + 1,
		"Removing "..metaitem.Name, target, function()

			net.Start( "nEndAugmentRemove" );
			net.SendToServer();

		end	);
		
		CCP.AugmentsPanel:Close();
	
	end
	
	net.Start( "nPopulateAugmentRemove" );
		net.WriteEntity( target );
	net.SendToServer();
	
end

local function nPopulateAugmentRemove( len )

	if( !CCP.AugmentsPanel ) then return end
	
	local tbl = util.JSONToTable( net.ReadString() );
	for k,v in next, tbl do
	
		local metaitem = GAMEMODE:GetItemByID( k );
		if( metaitem and metaitem.Augment and !metaitem.CannotRemove ) then
		
			local but = vgui.Create( "DButton", CCP.AugmentsPanel.AugmentsScroll );
			but:SetSize( CCP.AugmentsPanel.AugmentsContainer:GetWide() - CCP.AugmentsPanel.AugmentsScroll:GetVBar():GetWide(), 20 );
			but:Dock( TOP );
			but:SetText( metaitem.Name );
			but:SetTooltip( metaitem.GetTooltip( k, target ) );
			but.Augment = k;
			but:SetFont( "CombineControl.LabelSmall" );
			function but:DoClick()
			
				CCP.AugmentsPanel.SelectedAugment = self;
			
			end
			function but:Paint( w, h )
			
				if( !CCP.AugmentsPanel ) then return end
				if( CCP.AugmentsPanel.SelectedAugment != self ) then
			
					surface.SetDrawColor( 40, 40, 40, 255 );
					surface.DrawRect( 0, 0, w, h );
			
					if( self:GetDisabled() ) then
						surface.SetDrawColor( 30, 30, 30, 255 );
						surface.DrawRect( 1, 1, w - 2, h - 2 );
						return;
					end	
			
					surface.SetDrawColor( 60, 60, 60, 255 );
					surface.DrawRect( 1, 1, w - 2, h - 2 );
					
				else
				
					surface.SetDrawColor( 40, 40, 40, 255 );
					surface.DrawRect( 0, 0, w, h );
			
					surface.SetDrawColor( 150, 20, 20, 255 );
					surface.DrawRect( 1, 1, w - 2, h - 2 );
				
				end
			
			end
		
		end
		
	end
	
end
net.Receive( "nPopulateAugmentRemove", nPopulateAugmentRemove );

local function nReceiveAugmentStart( len )

	local augment = net.ReadString();
	local time = net.ReadInt( 32 );
	
	local metaitem = GAMEMODE:GetItemByID( augment );
	
	GAMEMODE:CreateTimedProgressBar( time + 1, metaitem.Name, LocalPlayer(), function() end );

end
net.Receive( "nReceiveAugmentStart", nReceiveAugmentStart );

/* Heat Seeing Eyes... */
local mat = Material("models/props_combine/masterinterface01c")

hook.Add("PostDrawOpaqueRenderables", "Cyberpunk.DrawHeatSignatures", function()
	if !LocalPlayer():HasAugment("heatsig_eyes") then return end
	
	local pos = LocalPlayer():EyePos()+LocalPlayer():EyeAngles():Forward()*10
	local ang = LocalPlayer():EyeAngles()
	ang = Angle(ang.p+90,ang.y,0)
	
	render.ClearStencil() --Clear stencil
	render.SetStencilEnable( true ) --Enable stencil
	
	render.SetStencilWriteMask(255)
	render.SetStencilTestMask(255)
	render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_ALWAYS )
	render.SetStencilFailOperation( STENCILOPERATION_KEEP )
	render.SetStencilPassOperation( STENCILOPERATION_KEEP)
	render.SetStencilZFailOperation( STENCILOPERATION_REPLACE )
	render.SetStencilReferenceValue(15)

	render.SetBlend(0)
	for _, pl in pairs(player.GetAll()) do
		if !pl:IsValid() then continue end
		if !pl:Alive() then continue end
		if pl:GetNoDraw() then continue end
		if pl:HasAugment("anti_heatsig") then continue end
	
		local dist = pl:GetPos():Distance(LocalPlayer():GetPos())
		if dist > 512 then continue end
		
		pl:DrawModel()
		if pl:GetActiveWeapon():IsValid() then
			pl:GetActiveWeapon():DrawModel()
		end
		
		if (pac) then
			pac.RenderOverride(pl, "opaque")
			pac.RenderOverride(pl, "translucent", true)
		end
	end
	render.SetBlend(1)

	render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_EQUAL )
	
	cam.Start3D2D(pos,ang,1)
		render.SetMaterial( mat )
		render.DrawScreenQuad()
	cam.End3D2D()
	
	for _, pl in pairs(player.GetAll()) do
		if !pl:IsValid() then continue end
		if !pl:Alive() then continue end
		if pl:GetNoDraw() then continue end
		if pl:HasAugment("anti_heatsig") then continue end
		
		local dist = pl:GetPos():Distance(LocalPlayer():GetPos())
		if dist > 512 then continue end
		
		pl:DrawModel()
		if pl:GetActiveWeapon():IsValid() then
			pl:GetActiveWeapon():DrawModel()
		end
		
		if (pac) then
			pac.RenderOverride(pl, "opaque")
			pac.RenderOverride(pl, "translucent", true)
		end
	end

	render.SetStencilEnable( false )
end)

local function nReceiveAugments(len)
	local str = net.ReadString()
	local tbl = util.JSONToTable(str)
	
	for k,v in next, tbl do
		local ply = Player(k)
		ply.Augments = util.JSONToTable(v)
	end
end
net.Receive("nReceiveAugments", nReceiveAugments)