function nCharacterList( len )
	
	GAMEMODE.Characters = net.ReadTable();
	
end
net.Receive( "nCharacterList", nCharacterList );

function GM:CharCreateThink()
	
	if( self.QueueCharCreate ) then
		
		if( !self.IntroCamStart or !self:InIntroCam() ) then
			
			if( !CCP.Synopsis or !CCP.Synopsis:IsValid() ) then
				
				self.QueueCharCreate = false;
				cookie.Set( "cyberp_doneintro", 2 );
				
				self:CreateCharEditor();
				
			end
			
		end
		
	end
	
end

function GM:CreateSynopsis()
	if CCP.Synopsis and CCP.Synopsis:IsValid() then
		CCP.Synopsis:Remove()
		CCP.Synopsis = nil
	end
	
	CCP.Synopsis = vgui.Create("DFrame")
	CCP.Synopsis.lblTitle:SetFont( "CombineControl.Window" );
	CCP.Synopsis:SetTitle("Synopsis")
	CCP.Synopsis:SetSize(ScrW() / 2, ScrH() / 1.9)
	CCP.Synopsis:Center()
	CCP.Synopsis:MakePopup()
	CCP.Synopsis.PerformLayout = CCFramePerformLayout;
	CCP.Synopsis:PerformLayout();
	function CCP.Synopsis:OnClose()
		GAMEMODE:EndIntroCam()
	end
	
	CCP.Synopsis.ContentPane = vgui.Create( "DScrollPanel", CCP.Synopsis );
	CCP.Synopsis.ContentPane:SetSize( ScrW() / 2 - 4, ScrH() / 1.9 - 56 );
	CCP.Synopsis.ContentPane:SetPos( 2, 26 );
	function CCP.Synopsis.ContentPane:Paint( w, h )
	end
	
	CCP.Synopsis.Text = vgui.Create("CCLabel", CCP.Synopsis.ContentPane)
	CCP.Synopsis.Text:SetSize(ScrW() / 2 - 20, ScrH() / 1.9)
	CCP.Synopsis.Text:SetPos(2,0)
	CCP.Synopsis.Text:SetFont("CombineControl.LabelMedium")
	CCP.Synopsis.Text:SetText(string.gsub(self.HelpContent[1][2], "\t", ""))
	CCP.Synopsis.Text:PerformLayout();
	
	CCP.Synopsis.Okay = vgui.Create("DButton", CCP.Synopsis)
	CCP.Synopsis.Okay:SetSize(256, 24)
	CCP.Synopsis.Okay:SetPos((ScrW() / 2) / 2 - 128, ScrH() / 1.9 - 26)
	CCP.Synopsis.Okay:SetFont("CombineControl.LabelMedium")
	CCP.Synopsis.Okay:SetText("Okay")
	function CCP.Synopsis.Okay:DoClick()
		CCP.Synopsis:Close()
	end
end

function nOpenCharCreate( len )
	
	GAMEMODE.CCMode = net.ReadUInt( 3 );
	GAMEMODE.QueueCharCreate = true;
	
end
net.Receive( "nOpenCharCreate", nOpenCharCreate );

GM.CCModel = GM.CCModel or "";

function GM:CreateCharEditor()
	
	self.CharCreate = true;
	self.CharCreateOpened = true;
	
	if( self.CCMode == CC_CREATE ) then
		
		self:CreateCharCreate();
		
	elseif( self.CCMode == CC_CREATESELECT ) then
		
		self:CreateCharCreate();
		self:CreateCharSelect();
		
	elseif( self.CCMode == CC_CREATESELECT_C ) then
		
		self:CreateCharCreate();
		self:CreateCharSelect();
		self:CreateCharDeleteCancel();
		
	elseif( self.CCMode == CC_SELECT ) then
		
		self:CreateCharSelect( true );
		
	elseif( self.CCMode == CC_SELECT_C ) then
		
		self:CreateCharSelect( true );
		self:CreateCharDeleteCancel();
		
	end
	
end

GM.CharCreateSelectedModel = GM.CharCreateSelectedModel or "";

local matHover = Material( "vgui/spawnmenu/hover" );

local allowedChars = [[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 -|+=.,\/;:]];

function GM:CreateCharCreate()
	
	CCP.CharCreatePanel = vgui.Create( "DFrame" );
	CCP.CharCreatePanel:SetSize( 800, 720 );
	if( self.CCMode == CC_CREATE ) then
		CCP.CharCreatePanel:SetPos( ScrW() / 2 - 800 / 2 + 100, ScrH() / 2 - 720 / 2 );
	else
		CCP.CharCreatePanel:SetPos( ScrW() / 2 - 800 / 2, ScrH() / 2 - 720 / 2 );
	end
	CCP.CharCreatePanel:SetTitle( "Character Creation" );
	CCP.CharCreatePanel:ShowCloseButton( false );
	CCP.CharCreatePanel:SetDraggable( false );
	CCP.CharCreatePanel.lblTitle:SetFont( "CombineControl.Window" );
	CCP.CharCreatePanel:MakePopup();
	function CCP.CharCreatePanel:Think()
	
		if( input.IsKeyDown( KEY_F2 ) and !self.LastKeyState and self.HasOpened and LocalPlayer():CharID() > 0 ) then
		
			GAMEMODE:CloseCharCreate();
		
		end
		
		self.LastKeyState = input.IsKeyDown( KEY_F2 );
		if( !self.HasOpened ) then
		
			self.HasOpened = true;
			
		end
		
	end
	
	CCP.CharCreateModel = vgui.Create( "DFrame" );
	CCP.CharCreateModel:SetSize( 200, 720 );
	CCP.CharCreateModel:SetPos( CCP.CharCreatePanel:GetPos() - 200, ScrH() / 2 - 720 / 2 );
	CCP.CharCreateModel:SetTitle( "Model Display" );
	CCP.CharCreateModel:ShowCloseButton( false );
	CCP.CharCreateModel:SetDraggable( false );
	CCP.CharCreateModel.lblTitle:SetFont( "CombineControl.Window" );
	CCP.CharCreateModel:MakePopup();
	
	CCP.CharCreateModel.Display = vgui.Create( "DModelPanel", CCP.CharCreateModel );
	CCP.CharCreateModel.Display:SetSize( 200, 720 );
	CCP.CharCreateModel.Display:SetModel( self.CitizenModels[1] );
	CCP.CharCreateModel.Display:SetFOV( 30 );
	CCP.CharCreateModel.Display:SetCamPos( Vector( 50, 0, 40 ) );
	CCP.CharCreateModel.Display:SetLookAt( Vector( 0, 0, 40 ) );
	function CCP.CharCreateModel.Display:LayoutEntity( ent ) return end
	
	CCP.CharCreatePanel.NameLabel = vgui.Create( "DLabel", CCP.CharCreatePanel );
	CCP.CharCreatePanel.NameLabel:SetText( "Name" );
	CCP.CharCreatePanel.NameLabel:SetPos( 10, 30 );
	CCP.CharCreatePanel.NameLabel:SetFont( "CombineControl.LabelGiant" );
	CCP.CharCreatePanel.NameLabel:SizeToContents();
	CCP.CharCreatePanel.NameLabel:PerformLayout();
	
	CCP.CharCreatePanel.NameEntry = vgui.Create( "DTextEntry", CCP.CharCreatePanel );
	CCP.CharCreatePanel.NameEntry:SetFont( "CombineControl.LabelBig" );
	CCP.CharCreatePanel.NameEntry:SetPos( 110, 30 );
	CCP.CharCreatePanel.NameEntry:SetSize( 300, 20 );
	CCP.CharCreatePanel.NameEntry:PerformLayout();
	function CCP.CharCreatePanel.NameEntry:AllowInput( val )
		
		if( !string.find( allowedChars, val, 1, true ) ) then
			
			return true
			
		end
		
		return false;
		
	end
	
	CCP.CharCreatePanel.TitleOneLabel = vgui.Create( "DLabel", CCP.CharCreatePanel );
	CCP.CharCreatePanel.TitleOneLabel:SetText( "Title One" );
	CCP.CharCreatePanel.TitleOneLabel:SetPos( 415, 30 );
	CCP.CharCreatePanel.TitleOneLabel:SetFont( "CombineControl.LabelGiant" );
	CCP.CharCreatePanel.TitleOneLabel:SizeToContents();
	CCP.CharCreatePanel.TitleOneLabel:PerformLayout();
	
	CCP.CharCreatePanel.TitleOneEntry = vgui.Create( "DTextEntry", CCP.CharCreatePanel );
	CCP.CharCreatePanel.TitleOneEntry:SetFont( "CombineControl.LabelBig" );
	CCP.CharCreatePanel.TitleOneEntry:SetPos( 490, 30 );
	CCP.CharCreatePanel.TitleOneEntry:SetSize( 300, 20 );
	CCP.CharCreatePanel.TitleOneEntry:PerformLayout();
	function CCP.CharCreatePanel.TitleOneEntry:AllowInput( val )
		
		if( !string.find( allowedChars, val, 1, true ) ) then
			
			return true
			
		end
		
		return false;
		
	end
	
	CCP.CharCreatePanel.TitleTwoLabel = vgui.Create( "DLabel", CCP.CharCreatePanel );
	CCP.CharCreatePanel.TitleTwoLabel:SetText( "Title Two" );
	CCP.CharCreatePanel.TitleTwoLabel:SetPos( 415, 60 );
	CCP.CharCreatePanel.TitleTwoLabel:SetFont( "CombineControl.LabelGiant" );
	CCP.CharCreatePanel.TitleTwoLabel:SizeToContents();
	CCP.CharCreatePanel.TitleTwoLabel:PerformLayout();
	
	CCP.CharCreatePanel.TitleTwoEntry = vgui.Create( "DTextEntry", CCP.CharCreatePanel );
	CCP.CharCreatePanel.TitleTwoEntry:SetFont( "CombineControl.LabelBig" );
	CCP.CharCreatePanel.TitleTwoEntry:SetPos( 490, 60 );
	CCP.CharCreatePanel.TitleTwoEntry:SetSize( 300, 20 );
	CCP.CharCreatePanel.TitleTwoEntry:PerformLayout();
	function CCP.CharCreatePanel.TitleTwoEntry:AllowInput( val )
		
		if( !string.find( allowedChars, val, 1, true ) ) then
			
			return true
			
		end
		
		return false;
		
	end
	
	CCP.CharCreatePanel.RandomMale = vgui.Create( "DButton", CCP.CharCreatePanel );
	CCP.CharCreatePanel.RandomMale:SetFont( "CombineControl.LabelSmall" );
	CCP.CharCreatePanel.RandomMale:SetText( "Random Male" );
	CCP.CharCreatePanel.RandomMale:SetPos( 110, 60 );
	CCP.CharCreatePanel.RandomMale:SetSize( 100, 20 );
	function CCP.CharCreatePanel.RandomMale:DoClick()
		
		CCP.CharCreatePanel.NameEntry:SetValue( table.Random( GAMEMODE.MaleFirstNames ) .. " " .. table.Random( GAMEMODE.LastNames ) );
		
	end
	CCP.CharCreatePanel.RandomMale:PerformLayout();
	
	CCP.CharCreatePanel.RandomFemale = vgui.Create( "DButton", CCP.CharCreatePanel );
	CCP.CharCreatePanel.RandomFemale:SetFont( "CombineControl.LabelSmall" );
	CCP.CharCreatePanel.RandomFemale:SetText( "Random Female" );
	CCP.CharCreatePanel.RandomFemale:SetPos( 220, 60 );
	CCP.CharCreatePanel.RandomFemale:SetSize( 100, 20 );
	function CCP.CharCreatePanel.RandomFemale:DoClick()
		
		CCP.CharCreatePanel.NameEntry:SetValue( table.Random( GAMEMODE.FemaleFirstNames ) .. " " .. table.Random( GAMEMODE.LastNames ) );
		
	end
	CCP.CharCreatePanel.RandomFemale:PerformLayout();
	
	CCP.CharCreatePanel.DescLabel = vgui.Create( "DLabel", CCP.CharCreatePanel );
	CCP.CharCreatePanel.DescLabel:SetText( "Description" );
	CCP.CharCreatePanel.DescLabel:SetPos( 400, 90 );
	CCP.CharCreatePanel.DescLabel:SetFont( "CombineControl.LabelGiant" );
	CCP.CharCreatePanel.DescLabel:SizeToContents();
	CCP.CharCreatePanel.DescLabel:PerformLayout();
	
	CCP.CharCreatePanel.DescEntry = vgui.Create( "DTextEntry", CCP.CharCreatePanel );
	CCP.CharCreatePanel.DescEntry:SetFont( "CombineControl.LabelSmall" );
	CCP.CharCreatePanel.DescEntry:SetPos( 490, 92 );
	CCP.CharCreatePanel.DescEntry:SetSize( 300, 236 );
	CCP.CharCreatePanel.DescEntry:SetMultiline( true );
	CCP.CharCreatePanel.DescEntry:PerformLayout();
	
	CCP.CharCreatePanel.ModelLabel = vgui.Create( "DLabel", CCP.CharCreatePanel );
	CCP.CharCreatePanel.ModelLabel:SetText( "Model" );
	CCP.CharCreatePanel.ModelLabel:SetPos( 10, 150 );
	CCP.CharCreatePanel.ModelLabel:SetFont( "CombineControl.LabelGiant" );
	CCP.CharCreatePanel.ModelLabel:SizeToContents();
	CCP.CharCreatePanel.ModelLabel:PerformLayout();
	
	CCP.CharCreatePanel.ModelContainer = vgui.Create( "DScrollPanel", CCP.CharCreatePanel );
	CCP.CharCreatePanel.ModelContainer:SetSize( 316, 180 );
	CCP.CharCreatePanel.ModelContainer:SetPos( 110, 150 );
	
	local x = 0;
	local y = 0;
	local finalY = 0;
	
	local si = { };
	
	for _, v in pairs( self.CitizenModels ) do
		
		local model = vgui.Create( "SpawnIcon", CCP.CharCreatePanel.ModelContainer );
		model:SetPos( x, y );
		model:SetSize( 58, 58 );
		model:SetModel( v );
		model.ModelPath = v;
		function model:DoClick()
			
			for _, v in pairs( si ) do
				
				v.Selected = false;
				
			end
			
			self.Selected = true;
			
			GAMEMODE.CharCreateSelectedModel = self.ModelPath;
			CCP.CharCreateModel.Display:SetModel( self.ModelPath );
			
		end
		function model:PaintOver( w, h )
			
			self:DrawSelections();
			
			if( self.Hovered or self.Selected ) then
				
				surface.SetDrawColor( 255, 255, 255, 255 );
				surface.SetMaterial( matHover );
				self:DrawTexturedRect();
				
			end
			
		end
		function model:Paint( w, h )
			
			surface.SetDrawColor( 40, 40, 40, 255 );
			surface.DrawRect( 0, 0, w, h );
			
			surface.SetDrawColor( 30, 30, 30, 100 );
			surface.DrawOutlinedRect( 0, 0, w, h );
			
		end
		model:SetTooltip( "" );
		
		table.insert( si, model );
		
		x = x + 60;
		
		if( x > 300 - 60 ) then
			
			x = 0;
			y = y + 60;
			
		end
		
	end
	
	local label = vgui.Create( "DLabel", CCP.CharCreatePanel );
	label:SetText( "Stats" );
	label:SetPos( 10, 350 );
	label:SetFont( "CombineControl.LabelGiant" );
	label:SizeToContents();
	label:PerformLayout();
	
	local y = 0;
	
	for _, v in pairs( GAMEMODE.Stats ) do
		
		local label = vgui.Create( "DLabel", CCP.CharCreatePanel );
		label:SetText( v );
		label:SetPos( 10, 390 + y );
		label:SetFont( "CombineControl.LabelMedium" );
		label:SizeToContents();
		label:PerformLayout();
		
		CCP.CharCreatePanel["StatBar" .. v] = vgui.Create( "CCProgressBar", CCP.CharCreatePanel );
		CCP.CharCreatePanel["StatBar" .. v]:SetPos( 126, 390 + y );
		CCP.CharCreatePanel["StatBar" .. v]:SetSize( 178, 16 );
		CCP.CharCreatePanel["StatBar" .. v]:SetProgress( 0.5 );
		CCP.CharCreatePanel["StatBar" .. v]:SetProgressText( tostring( CCP.CharCreatePanel["StatBar" .. v]:GetProgress() * 10 ) .. "/10" );
		
		local a = vgui.Create( "DButton", CCP.CharCreatePanel );
		a:SetFont( "CombineControl.LabelSmall" );
		a:SetText( "<" );
		a:SetPos( 100, 390 + y );
		a:SetSize( 16, 16 );
		function a:DoClick()

			if( CCP.CharCreatePanel["StatBar" .. v]:GetProgress() - 0.1 > 0.1 ) then
				
				CCP.CharCreatePanel.StatBarRemain:SetProgress( math.Clamp( CCP.CharCreatePanel.StatBarRemain:GetProgress() + 0.1, 0, 3.8 ) );
				CCP.CharCreatePanel.StatBarRemain:SetProgressText( tostring( math.Round( CCP.CharCreatePanel.StatBarRemain:GetProgress() * 10 ) ) );
				
				CCP.CharCreatePanel["StatBar" .. v]:SetProgress( math.Clamp( CCP.CharCreatePanel["StatBar" .. v]:GetProgress() - 0.1, 0.1, 1 ) );
				CCP.CharCreatePanel["StatBar" .. v]:SetProgressText( tostring( CCP.CharCreatePanel["StatBar" .. v]:GetProgress() * 10 ) .. "/10" );
				
			end
			
		end
		a:PerformLayout();
		
		local b = vgui.Create( "DButton", CCP.CharCreatePanel );
		b:SetFont( "CombineControl.LabelSmall" );
		b:SetText( ">" );
		b:SetPos( 314, 390 + y );
		b:SetSize( 16, 16 );
		function b:DoClick()
		
			if( CCP.CharCreatePanel.StatBarRemain:GetProgress() > 0.1 and CCP.CharCreatePanel["StatBar" .. v]:GetProgress() + 0.1 < 1 ) then
				
				CCP.CharCreatePanel.StatBarRemain:SetProgress( math.Clamp( CCP.CharCreatePanel.StatBarRemain:GetProgress() - 0.1, 0, 3.8 ) );
				CCP.CharCreatePanel.StatBarRemain:SetProgressText( tostring( math.Round( CCP.CharCreatePanel.StatBarRemain:GetProgress() * 10 ) ) );
				
				CCP.CharCreatePanel["StatBar" .. v]:SetProgress( math.Clamp( CCP.CharCreatePanel["StatBar" .. v]:GetProgress() + 0.1, 0.1, 1 ) );
				CCP.CharCreatePanel["StatBar" .. v]:SetProgressText( tostring( CCP.CharCreatePanel["StatBar" .. v]:GetProgress() * 10 ) .. "/10" );
				
			end
			
		end
		b:PerformLayout();
		
		y = y + 30;
		
	end
	
	local label = vgui.Create( "DLabel", CCP.CharCreatePanel );
	label:SetText( "Remaining" );
	label:SetPos( 10, 390 + y );
	label:SetFont( "CombineControl.LabelMedium" );
	label:SizeToContents();
	label:PerformLayout();
	
	CCP.CharCreatePanel.StatBarRemain = vgui.Create( "CCProgressBar", CCP.CharCreatePanel );
	CCP.CharCreatePanel.StatBarRemain:SetPos( 126, 390 + y );
	CCP.CharCreatePanel.StatBarRemain:SetSize( 178, 16 );
	CCP.CharCreatePanel.StatBarRemain:SetProgress( GAMEMODE.StatsAvailable / 10 );
	CCP.CharCreatePanel.StatBarRemain:SetProgressText( tostring( CCP.CharCreatePanel.StatBarRemain:GetProgress() * 10 ) );
	
	local label = vgui.Create( "DLabel", CCP.CharCreatePanel );
	label:SetText( "Skin" );
	label:SetPos( 10, 420 + y );
	label:SetFont( "CombineControl.LabelGiant" );
	label:SizeToContents();
	label:PerformLayout();
	
	CCP.CharCreatePanel.SkinSelect = vgui.Create( "DComboBox", CCP.CharCreatePanel );
	CCP.CharCreatePanel.SkinSelect:SetSize( 86, 20 );
	CCP.CharCreatePanel.SkinSelect:SetPos( 64, 422 + y );
	CCP.CharCreatePanel.SkinSelect:SetValue( "Skin" );
	for i = 0, CCP.CharCreateModel.Display.Entity:SkinCount() - 1 do
	
		CCP.CharCreatePanel.SkinSelect:AddChoice( "Skin "..tostring( i ) );
		
	end
	function CCP.CharCreatePanel.SkinSelect:OnSelect( index, value )
	
		CCP.CharCreateModel.Display.Entity:SetSkin( index - 1 );
	
	end
	
	local label = vgui.Create( "DLabel", CCP.CharCreatePanel );
	label:SetText( "Head" );
	label:SetPos( 164, 420 + y );
	label:SetFont( "CombineControl.LabelGiant" );
	label:SizeToContents();
	label:PerformLayout();
	
	CCP.CharCreatePanel.HeadBGSelect = vgui.Create( "DComboBox", CCP.CharCreatePanel );
	CCP.CharCreatePanel.HeadBGSelect:SetSize( 86, 20 );
	CCP.CharCreatePanel.HeadBGSelect:SetPos( 220, 422 + y );
	CCP.CharCreatePanel.HeadBGSelect:SetValue( "Bodygroup" );
	for i = 0, CCP.CharCreateModel.Display.Entity:GetBodygroupCount( 4 ) - 1 do
	
		CCP.CharCreatePanel.HeadBGSelect:AddChoice( "Bodygroup "..tostring( i ) );
		
	end
	function CCP.CharCreatePanel.HeadBGSelect:OnSelect( index, value )
	
		CCP.CharCreateModel.Display.Entity:SetBodygroup( 4, index - 1 );
	
	end
	
	local label = vgui.Create( "DLabel", CCP.CharCreatePanel );
	label:SetText( "Torso" );
	label:SetPos( 10, 450 + y );
	label:SetFont( "CombineControl.LabelGiant" );
	label:SizeToContents();
	label:PerformLayout();
	
	CCP.CharCreatePanel.TorsoBGSelect = vgui.Create( "DComboBox", CCP.CharCreatePanel );
	CCP.CharCreatePanel.TorsoBGSelect:SetSize( 86, 20 );
	CCP.CharCreatePanel.TorsoBGSelect:SetPos( 64, 452 + y );
	CCP.CharCreatePanel.TorsoBGSelect:SetValue( "Bodygroup" );
	for i = 0, CCP.CharCreateModel.Display.Entity:GetBodygroupCount( 1 ) - 1 do
	
		CCP.CharCreatePanel.TorsoBGSelect:AddChoice( "Bodygroup "..tostring( i ) );
		
	end
	function CCP.CharCreatePanel.TorsoBGSelect:OnSelect( index, value )
	
		CCP.CharCreateModel.Display.Entity:SetBodygroup( 1, index - 1 );
	
	end
	
	local label = vgui.Create( "DLabel", CCP.CharCreatePanel );
	label:SetText( "Legs" );
	label:SetPos( 164, 450 + y );
	label:SetFont( "CombineControl.LabelGiant" );
	label:SizeToContents();
	label:PerformLayout();
	
	CCP.CharCreatePanel.LegBGSelect = vgui.Create( "DComboBox", CCP.CharCreatePanel );
	CCP.CharCreatePanel.LegBGSelect:SetSize( 86, 20 );
	CCP.CharCreatePanel.LegBGSelect:SetPos( 220, 452 + y );
	CCP.CharCreatePanel.LegBGSelect:SetValue( "Bodygroup" );
	for i = 0, CCP.CharCreateModel.Display.Entity:GetBodygroupCount( 2 ) - 1 do
	
		CCP.CharCreatePanel.LegBGSelect:AddChoice( "Bodygroup "..tostring( i ) );
		
	end
	function CCP.CharCreatePanel.LegBGSelect:OnSelect( index, value )
	
		CCP.CharCreateModel.Display.Entity:SetBodygroup( 2, index - 1 );
	
	end
	
	local label = vgui.Create( "DLabel", CCP.CharCreatePanel );
	label:SetText( "Traits" );
	label:SetPos( 360, 350 );
	label:SetFont( "CombineControl.LabelGiant" );
	label:SizeToContents();
	label:PerformLayout();
	
	CCP.CharCreatePanel.PointsLeft = GAMEMODE.TraitPoints;
	
	local label = vgui.Create( "DLabel", CCP.CharCreatePanel );
	label:SetText( "PointsLeft" );
	label:SetPos( 610, 350 );
	label:SetFont( "CombineControl.LabelGiant" );
	label:SizeToContents();
	label:PerformLayout();
	function label:Think()
	
		if( !CCP.CharCreatePanel ) then return end
		if( !self.LastPointsLeft ) then
		
			self.LastPointsLeft = 0;
			
		end
		
		if( self.LastPointsLeft != CCP.CharCreatePanel.PointsLeft ) then
		
			self:SetText( CCP.CharCreatePanel.PointsLeft.." Points Left" );
			self:SizeToContents();
			self:PerformLayout();
		
		end
		
		self.LastPointsLeft = CCP.CharCreatePanel.PointsLeft;
	
	end
	
	CCP.CharCreatePanel.TraitsContainer = vgui.Create( "DPanel", CCP.CharCreatePanel );
	CCP.CharCreatePanel.TraitsContainer:SetSize( 180, 260 );
	CCP.CharCreatePanel.TraitsContainer:SetPos( 420, 380 );
	
	CCP.CharCreatePanel.TraitsScroll = vgui.Create( "DScrollPanel", CCP.CharCreatePanel.TraitsContainer );
	CCP.CharCreatePanel.TraitsScroll:SetSize( 180, 260 );
	function CCP.CharCreatePanel.TraitsScroll:Clear()
	
		for k,v in next, self:GetCanvas():GetChildren() do
		
			v:Remove();
		
		end
	
	end
	
	CCP.CharCreatePanel.SelectedTraits = vgui.Create( "DPanel", CCP.CharCreatePanel );
	CCP.CharCreatePanel.SelectedTraits:SetSize( 180, 260 );
	CCP.CharCreatePanel.SelectedTraits:SetPos( 610, 380 );
	CCP.CharCreatePanel.SelectedTraits.List = {};
	function CCP.CharCreatePanel.SelectedTraits:AddTrait( panel )
	
		if( IsValid( panel ) and panel.Trait ) then
		
			local trait = GAMEMODE.Traits[panel.Trait];
			if( CCP.CharCreatePanel.PointsLeft - trait[3] < 0 ) then 
				CCP.CharCreatePanel.SelectedTrait = nil;
				return;
			end
		
			CCP.CharCreatePanel.SelectedTraits.List[panel.Trait] = true;
			CCP.CharCreatePanel.SelectedTrait = nil;
			CCP.CharCreatePanel.PointsLeft = CCP.CharCreatePanel.PointsLeft - trait[3];
			CCP.CharCreatePanel.GenerateTraitsList()
		
		end
	
	end
	function CCP.CharCreatePanel.SelectedTraits:RemoveTrait( panel )
	
		if( IsValid( panel ) and panel.Trait ) then
		
			local trait = GAMEMODE.Traits[panel.Trait];
			
				if( CCP.CharCreatePanel.PointsLeft + trait[3] < 0 ) then 
				CCP.CharCreatePanel.SelectedTrait = nil;
				return;
			end
		
			CCP.CharCreatePanel.SelectedTraits.List[panel.Trait] = nil;
			CCP.CharCreatePanel.SelectedTrait = nil;
			CCP.CharCreatePanel.PointsLeft = CCP.CharCreatePanel.PointsLeft + trait[3];
			CCP.CharCreatePanel.GenerateTraitsList()
		
		end
	
	end
	function CCP.CharCreatePanel.SelectedTraits:Clear()
	
		for k,v in next, self:GetChildren() do
		
			v:Remove();
		
		end
	
	end
	
	function CCP.CharCreatePanel.GenerateTraitsList()
	
		CCP.CharCreatePanel.TraitsScroll:Clear()
		CCP.CharCreatePanel.SelectedTraits:Clear()
	
		for k,v in next, GAMEMODE.Traits do
		
			if( k == TRAIT_NONE ) then continue end
			if( CCP.CharCreatePanel.SelectedTraits.List[k] ) then continue end
			
			local shouldContinue = false;
			for m,n in next, CCP.CharCreatePanel.SelectedTraits.List do
			
				if( GAMEMODE.Traits[m][4] and GAMEMODE.Traits[m][4][k] ) then
				
					shouldContinue = true;
					break;
				
				end
				
			end
			
			if( shouldContinue ) then continue end
		
			local but = vgui.Create( "DButton", CCP.CharCreatePanel.TraitsScroll );
			but:SetSize( CCP.CharCreatePanel.TraitsContainer:GetWide() - CCP.CharCreatePanel.TraitsScroll:GetVBar():GetWide(), 20 );
			but:Dock( TOP );
			but:SetText( "  "..v[1] );
			if( v[3] < 0 ) then
				but:SetTextColor( Color( 255, 20, 20 ) );
			else
				but:SetTextColor( Color( 20, 255, 20 ) );
			end
			but:SetContentAlignment( 4 );
			but:SetTooltip( v[2] );
			but.Trait = k;
			but:SetFont( "CombineControl.LabelSmall" );
			function but:DoClick()
			
				if( CCP.CharCreatePanel.SelectedTrait != self ) then
			
					CCP.CharCreatePanel.SelectedTrait = self;
					CCP.CharCreatePanel.AddTrait:SetDisabled( false );
					CCP.CharCreatePanel.RemoveTrait:SetDisabled( true );
					
				else
				
					CCP.CharCreatePanel.SelectedTrait = nil;
					CCP.CharCreatePanel.AddTrait:SetDisabled( true );
					CCP.CharCreatePanel.RemoveTrait:SetDisabled( true );
				
				end
			
			end
			function but:Paint( w, h )
			
				if( !CCP.CharCreatePanel ) then return end
				if( CCP.CharCreatePanel.SelectedTrait != self ) then
			
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
			
			but.CostLabel = vgui.Create( "DLabel", but );
			but.CostLabel:SetContentAlignment( 6 );
			but.CostLabel:SetSize( but:GetWide(), but:GetTall() );
			but.CostLabel:SetText( v[3].." " );
			if( v[3] < 0 ) then
				but.CostLabel:SetTextColor( Color( 255, 20, 20 ) );
				but.CostLabel:SetText( "+"..(v[3]*-1).."  " );
			else
				but.CostLabel:SetTextColor( Color( 20, 255, 20 ) );
				but.CostLabel:SetText( "-"..v[3].."  " );
			end
			
		end
		
		for k,v in next, CCP.CharCreatePanel.SelectedTraits.List do
		
			local trait = GAMEMODE.Traits[k];
		
			local but = vgui.Create( "DButton", CCP.CharCreatePanel.SelectedTraits );
			but:SetSize( CCP.CharCreatePanel.SelectedTraits:GetWide(), 20 );
			but:Dock( TOP );
			but:SetText( "  "..trait[1] );
			if( trait[3] < 0 ) then
				but:SetTextColor( Color( 255, 20, 20 ) );
			else
				but:SetTextColor( Color( 20, 255, 20 ) );
			end
			but:SetContentAlignment( 4 );
			but:SetTooltip( trait[2] );
			but.Trait = k;
			but:SetFont( "CombineControl.LabelSmall" );
			function but:DoClick()
			
				if( CCP.CharCreatePanel.SelectedTrait != self ) then
			
					CCP.CharCreatePanel.SelectedTrait = self;
					CCP.CharCreatePanel.AddTrait:SetDisabled( true );
					CCP.CharCreatePanel.RemoveTrait:SetDisabled( false );
					
				else
				
					CCP.CharCreatePanel.SelectedTrait = nil;
					CCP.CharCreatePanel.AddTrait:SetDisabled( true );
					CCP.CharCreatePanel.RemoveTrait:SetDisabled( true );
				
				end
			
			end
			function but:Paint( w, h )
			
				if( !CCP.CharCreatePanel ) then return end
				if( CCP.CharCreatePanel.SelectedTrait != self ) then
			
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
			
			but.CostLabel = vgui.Create( "DLabel", but );
			but.CostLabel:SetContentAlignment( 6 );
			but.CostLabel:SetSize( but:GetWide(), but:GetTall() );
			but.CostLabel:SetText( trait[3].." " );
			if( trait[3] < 0 ) then
				but.CostLabel:SetTextColor( Color( 255, 20, 20 ) );
				but.CostLabel:SetText( "+"..(trait[3]*-1).."  " );
			else
				but.CostLabel:SetTextColor( Color( 20, 255, 20 ) );
				but.CostLabel:SetText( "-"..trait[3].."  " );
			end
			
		end
		
	end
	CCP.CharCreatePanel.GenerateTraitsList();
	
	CCP.CharCreatePanel.AddTrait = vgui.Create( "DButton", CCP.CharCreatePanel );
	CCP.CharCreatePanel.AddTrait:SetSize( 80, 24 );
	CCP.CharCreatePanel.AddTrait:SetPos( 520, 650 );
	CCP.CharCreatePanel.AddTrait:SetText( "Add Trait" );
	function CCP.CharCreatePanel.AddTrait:DoClick()
	
		if( IsValid( CCP.CharCreatePanel.SelectedTrait ) ) then
		
			CCP.CharCreatePanel.SelectedTraits:AddTrait( CCP.CharCreatePanel.SelectedTrait );
			self:SetDisabled( true );
		
		end
	
	end
	CCP.CharCreatePanel.AddTrait:SetDisabled( true );
	
	CCP.CharCreatePanel.RemoveTrait = vgui.Create( "DButton", CCP.CharCreatePanel );
	CCP.CharCreatePanel.RemoveTrait:SetSize( 80, 24 );
	CCP.CharCreatePanel.RemoveTrait:SetPos( 610, 650 );
	CCP.CharCreatePanel.RemoveTrait:SetText( "Remove Trait" );
	function CCP.CharCreatePanel.RemoveTrait:DoClick()
	
		if( IsValid( CCP.CharCreatePanel.SelectedTrait ) ) then
		
			CCP.CharCreatePanel.SelectedTraits:RemoveTrait( CCP.CharCreatePanel.SelectedTrait );
			self:SetDisabled( true );
		
		end
	
	end
	CCP.CharCreatePanel.RemoveTrait:SetDisabled( true );
	
	if( self.CCMode == CC_CREATE ) then
		
		CCP.CharCreatePanel.NewbLabel = vgui.Create( "DLabel", CCP.CharCreatePanel );
		CCP.CharCreatePanel.NewbLabel:SetText( "Are you an inexperienced roleplayer?" );
		CCP.CharCreatePanel.NewbLabel:SetPos( 470, 688 );
		CCP.CharCreatePanel.NewbLabel:SetFont( "CombineControl.LabelSmall" );
		CCP.CharCreatePanel.NewbLabel:SetSize( 294, 16 );
		CCP.CharCreatePanel.NewbLabel:SetAutoStretchVertical( true );
		CCP.CharCreatePanel.NewbLabel:SetWrap( true );
		CCP.CharCreatePanel.NewbLabel:PerformLayout();
		
		net.Start( "nSetNewbieStatus" );
			net.WriteBit( true );
		net.SendToServer();
		
		CCP.CharCreatePanel.Newbie = vgui.Create( "DCheckBoxLabel", CCP.CharCreatePanel );
		CCP.CharCreatePanel.Newbie:SetText( "" );
		CCP.CharCreatePanel.Newbie:SetPos( 690, 687 );
		CCP.CharCreatePanel.Newbie:SetValue( true );
		CCP.CharCreatePanel.Newbie:PerformLayout();
		function CCP.CharCreatePanel.Newbie:OnChange( val )
			
			net.Start( "nSetNewbieStatus" );
				net.WriteBit( val );
			net.SendToServer();
			
		end
		
	end
	
	CCP.CharCreatePanel.BadChar = vgui.Create( "DLabel", CCP.CharCreatePanel );
	CCP.CharCreatePanel.BadChar:SetText( "" );
	CCP.CharCreatePanel.BadChar:SetPos( 420, 690 );
	CCP.CharCreatePanel.BadChar:SetFont( "CombineControl.LabelSmall" );
	CCP.CharCreatePanel.BadChar:SetSize( 720, 14 );
	CCP.CharCreatePanel.BadChar:PerformLayout();
	
	CCP.CharCreatePanel.OK = vgui.Create( "DButton", CCP.CharCreatePanel );
	CCP.CharCreatePanel.OK:SetFont( "CombineControl.LabelSmall" );
	CCP.CharCreatePanel.OK:SetText( "OK" );
	CCP.CharCreatePanel.OK:SetPos( 740, 680 );
	CCP.CharCreatePanel.OK:SetSize( 50, 30 );
	function CCP.CharCreatePanel.OK:DoClick()
		
		local name = CCP.CharCreatePanel.NameEntry:GetValue();
		local desc = CCP.CharCreatePanel.DescEntry:GetValue();
		local titleone = CCP.CharCreatePanel.TitleOneEntry:GetValue();
		local titletwo = CCP.CharCreatePanel.TitleTwoEntry:GetValue();
		local model = GAMEMODE.CharCreateSelectedModel;
		local skin = CCP.CharCreateModel.Display.Entity:GetSkin();
		local bodygroups = {};
		
		bodygroups[1] = CCP.CharCreateModel.Display.Entity:GetBodygroup( 1 );
		bodygroups[2] = CCP.CharCreateModel.Display.Entity:GetBodygroup( 2 );
		bodygroups[4] = CCP.CharCreateModel.Display.Entity:GetBodygroup( 4 );
		
		local stats = {};
		local sum = 0;
		local traits = table.Copy( CCP.CharCreatePanel.SelectedTraits.List );
		
		for _, v in pairs( GAMEMODE.Stats ) do
			
			stats[v] = CCP.CharCreatePanel["StatBar" .. v]:GetProgress() * 10;
			sum = sum + stats[v];
			
		end
		
		local r, err = GAMEMODE:CheckCharacterValidity( name, desc, titleone, titletwo, model, math.Round( sum ), traits );
		
		if( r ) then
			
			GAMEMODE:CloseCharCreate();
			
			net.Start( "nCreateCharacter" );
				net.WriteString( name );
				net.WriteString( desc );
				net.WriteString( titleone );
				net.WriteString( titletwo );
				net.WriteString( model );
				net.WriteString( util.TableToJSON( stats ) );
				net.WriteString( util.TableToJSON( traits ) );
				net.WriteInt( skin, 8 );
				net.WriteString( util.TableToJSON( bodygroups ) );
			net.SendToServer();
			
		else
			
			CCP.CharCreatePanel.BadChar:SetText( err );
			
		end
		
	end
	CCP.CharCreatePanel.OK:PerformLayout();
	
end

function GM:CharSelectPopulateCharacters()
	
	if( !self.CharSelectCharacterButtons ) then self.CharSelectCharacterButtons = { }; end
	
	for _, v in pairs( self.CharSelectCharacterButtons ) do
		
		v:Remove();
		
	end
	
	self.CharSelectCharacterButtons = { };
	
	local y = 0;
	
	for k, v in pairs( self.Characters ) do
		
		local b = vgui.Create( "DButton", CCP.CharSelectPanel );
		b:SetFont( "CombineControl.LabelSmall" );
		b:SetText( v.RPName );
		b:SetPos( 10, 30 + y );
		b:SetSize( 180, 20 );
		b.CharID = v.id;
		b.Location = v.Location;
		function b:DoClick()
			
			if( CCP.CharSelectPanel.DeleteMode ) then
				
				if( tonumber( v.Loan ) and tonumber( v.Loan ) > 0 ) then
					
					CCP.CharCreatePanel.BadChar:SetText( "You can't delete a character with a loan." );
					return;
					
				end
				
				net.Start( "nDeleteCharacter" );
					net.WriteUInt( self.CharID, 32 );
				net.SendToServer();
				
				for m, n in pairs( GAMEMODE.Characters ) do
					
					if( n.id == self.CharID ) then
						
						table.remove( GAMEMODE.Characters, m );
						
					end
					
				end
				
				GAMEMODE:CharSelectPopulateCharacters();
				
			else
				
				GAMEMODE:CloseCharCreate();
				
				net.Start( "nSelectCharacter" );
					net.WriteUInt( self.CharID, 32 );
				net.SendToServer();
				
				if( !GAMEMODE.AutoMOTD ) then
					
					GAMEMODE.AutoMOTD = true;
					GAMEMODE:CreateMOTD();
					
				end
				
			end
			
		end
		b:PerformLayout();
		
		if( LocalPlayer().CharID and b.CharID == LocalPlayer():CharID() ) then
			
			b:SetDisabled( true );
			
		end
		
		if( GAMEMODE.CurrentLocation and b.Location != GAMEMODE.CurrentLocation and !LocalPlayer():IsAdmin() ) then
			
			b:SetDisabled( true );
			
		end
		
		table.insert( self.CharSelectCharacterButtons, b );
		
		y = y + 30;
		
	end
	
end

function GM:CreateCharSelect( o )
	
	CCP.CharSelectPanel = vgui.Create( "DFrame" );
	CCP.CharSelectPanel:SetSize( 200, 720 );
	if( o ) then
		CCP.CharSelectPanel:Center();
	else
		CCP.CharSelectPanel:SetPos( ScrW() / 2 + 800 / 2, ScrH() / 2 - 720 / 2 );
	end
	CCP.CharSelectPanel:SetTitle( "Character Selection" );
	CCP.CharSelectPanel:ShowCloseButton( false );
	CCP.CharSelectPanel:SetDraggable( false );
	CCP.CharSelectPanel.lblTitle:SetFont( "CombineControl.Window" );
	CCP.CharSelectPanel:MakePopup();
	
	self:CharSelectPopulateCharacters();
	
end

function GM:CreateCharDeleteCancel()
	
	if( CCP.CharSelectPanel ) then
		
		local b = vgui.Create( "DButton", CCP.CharSelectPanel );
		b:SetFont( "CombineControl.LabelSmall" );
		b:SetText( "Delete" );
		b:SetPos( 10, 720 - 60 );
		b:SetSize( 180, 20 );
		function b:DoClick()
			
			if( !CCP.CharSelectPanel.DeleteMode ) then
				
				CCP.CharSelectPanel.DeleteMode = true;
				self:SetTextColor( Color( 200, 0, 0, 255 ) );
				
			else
				
				CCP.CharSelectPanel.DeleteMode = false;
				self:SetTextColor( Color( 200, 200, 200, 255 ) );
				
			end
			
		end
		b:PerformLayout();
		
		local b = vgui.Create( "DButton", CCP.CharSelectPanel );
		b:SetFont( "CombineControl.LabelSmall" );
		b:SetText( "Cancel" );
		b:SetPos( 10, 720 - 30 );
		b:SetSize( 180, 20 );
		function b:DoClick()
			
			GAMEMODE:CloseCharCreate();
			
		end
		b:PerformLayout();
		
	end
	
end

function GM:CloseCharCreate()
	
	self.CharCreate = false;
	
	if( CCP.CharCreatePanel ) then
		
		CCP.CharCreatePanel:Remove();
		
	end
	
	if( CCP.CharCreateModel ) then
	
		CCP.CharCreateModel:Remove();
		
	end
	
	if( CCP.CharSelectPanel ) then
		
		CCP.CharSelectPanel:Remove();
		
	end
	
	CCP.CharCreatePanel = nil;
	CCP.CharSelectPanel = nil;
	
end

function GM:LoadMOTD()
	
	if( self.MOTDURL != "" ) then
		
		local function LoadMOTD( contents, size, headers, code )
			
			self.MOTDText = contents;
			
		end
		
		http.Fetch( self.MOTDURL, LoadMOTD, function() end );
		
	end
	
end

function GM:CreateMOTD()
	
	if( !self.MOTDText ) then return end
	
	if( cookie.GetNumber( "cc_motd", 1 ) == 1 ) then
		
		CCP.MOTD = vgui.Create( "DFrame" );
		CCP.MOTD:SetSize( 400, 600 );
		CCP.MOTD:Center();
		CCP.MOTD:SetTitle( "MOTD" );
		CCP.MOTD.lblTitle:SetFont( "CombineControl.Window" );
		CCP.MOTD:MakePopup();
		CCP.MOTD.PerformLayout = CCFramePerformLayout;
		CCP.MOTD:PerformLayout();
		
		CCP.MOTD.Content = vgui.Create( "CCLabel", CCP.MOTD );
		CCP.MOTD.Content:SetPos( 10, 34 );
		CCP.MOTD.Content:SetSize( 400 - 20, 14 );
		CCP.MOTD.Content:SetFont( "CombineControl.LabelSmall" );
		CCP.MOTD.Content:SetText( self.MOTDText );
		CCP.MOTD.Content:PerformLayout();
		
	end
	
end
