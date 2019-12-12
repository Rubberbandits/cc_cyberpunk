function GM:CreatePlayerMenu()
	
	CCP.PlayerMenu = vgui.Create( "DFrame" );
	CCP.PlayerMenu:SetSize( 800, 500 );
	CCP.PlayerMenu:Center();
	CCP.PlayerMenu:SetTitle( "Player Menu" );
	CCP.PlayerMenu.lblTitle:SetFont( "CombineControl.Window" );
	CCP.PlayerMenu:MakePopup();
	CCP.PlayerMenu.PerformLayout = CCFramePerformLayout;
	CCP.PlayerMenu:PerformLayout();
	function CCP.PlayerMenu:Think()
	
		if( input.IsKeyDown( KEY_F3 ) and !self.LastKeyState and self.HasOpened ) then
		
			self:Close();
		
		end
		
		self.LastKeyState = input.IsKeyDown( KEY_F3 );
		if( !self.HasOpened ) then
		
			self.HasOpened = true;
			
		end
		
	end
	
	CCP.PlayerMenu.TopBar = vgui.Create( "DPanel", CCP.PlayerMenu );
	CCP.PlayerMenu.TopBar:SetPos( 0, 24 );
	CCP.PlayerMenu.TopBar:SetSize( 800, 50 );
	function CCP.PlayerMenu.TopBar:Paint( w, h )
		
		surface.SetDrawColor( 0, 0, 0, 70 );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( 0, 0, 0, 100 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
	end
	
	CCP.PlayerMenu.TopBar.Buttons = { };
	
	CCP.PlayerMenu.TopBar.Buttons[1] = vgui.Create( "DButton", CCP.PlayerMenu.TopBar );
	CCP.PlayerMenu.TopBar.Buttons[1]:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.TopBar.Buttons[1]:SetText( "Biography" );
	CCP.PlayerMenu.TopBar.Buttons[1]:SetPos( 11, 10 );
	CCP.PlayerMenu.TopBar.Buttons[1]:SetSize( 100, 26 );
	CCP.PlayerMenu.TopBar.Buttons[1].DoClick = function( self )
		
		CCP.PlayerMenu.ContentPane:Clear();
		GAMEMODE:PMCreateBio();
		
	end
	CCP.PlayerMenu.TopBar.Buttons[1]:PerformLayout();
	
	CCP.PlayerMenu.TopBar.Buttons[2] = vgui.Create( "DButton", CCP.PlayerMenu.TopBar );
	CCP.PlayerMenu.TopBar.Buttons[2]:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.TopBar.Buttons[2]:SetText( "Inventory" );
	CCP.PlayerMenu.TopBar.Buttons[2]:SetPos( 124, 10 );
	CCP.PlayerMenu.TopBar.Buttons[2]:SetSize( 100, 26 );
	CCP.PlayerMenu.TopBar.Buttons[2].DoClick = function( self )
		
		CCP.PlayerMenu.ContentPane:Clear();
		GAMEMODE:PMCreateInventory();
		
	end
	CCP.PlayerMenu.TopBar.Buttons[2]:PerformLayout();
	
	CCP.PlayerMenu.TopBar.Buttons[3] = vgui.Create( "DButton", CCP.PlayerMenu.TopBar );
	CCP.PlayerMenu.TopBar.Buttons[3]:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.TopBar.Buttons[3]:SetText( "Business" );
	CCP.PlayerMenu.TopBar.Buttons[3]:SetPos( 237, 10 );
	CCP.PlayerMenu.TopBar.Buttons[3]:SetSize( 100, 26 );
	CCP.PlayerMenu.TopBar.Buttons[3].DoClick = function( self )
		
		CCP.PlayerMenu.ContentPane:Clear();
		GAMEMODE:PMCreateBusiness();
		
	end
	CCP.PlayerMenu.TopBar.Buttons[3]:PerformLayout();
	
	if( GAMEMODE.CurrentLocation and GAMEMODE.CurrentLocation != LOCATION_CITY and GAMEMODE.CurrentLocation != LOCATION_OUTLANDS ) then
		
		CCP.PlayerMenu.TopBar.Buttons[3]:SetDisabled( true );
		
	end
	
	CCP.PlayerMenu.TopBar.Buttons[4] = vgui.Create( "DButton", CCP.PlayerMenu.TopBar );
	CCP.PlayerMenu.TopBar.Buttons[4]:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.TopBar.Buttons[4]:SetText( "SDPD-ARCS" );
	CCP.PlayerMenu.TopBar.Buttons[4]:SetPos( 350, 10 );
	CCP.PlayerMenu.TopBar.Buttons[4]:SetSize( 100, 26 );
	CCP.PlayerMenu.TopBar.Buttons[4].DoClick = function( self )
		
		CCP.PlayerMenu.ContentPane:Clear();
		GAMEMODE:PMCreateCombine();
		
	end
	CCP.PlayerMenu.TopBar.Buttons[4]:PerformLayout();
	
	if( !LocalPlayer():HasAnyCombineFlag() ) then
		
		CCP.PlayerMenu.TopBar.Buttons[4]:SetDisabled( true );
		
	end
	
	CCP.PlayerMenu.TopBar.Buttons[5] = vgui.Create( "DButton", CCP.PlayerMenu.TopBar );
	CCP.PlayerMenu.TopBar.Buttons[5]:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.TopBar.Buttons[5]:SetText( "Settings" );
	CCP.PlayerMenu.TopBar.Buttons[5]:SetPos( 463, 10 );
	CCP.PlayerMenu.TopBar.Buttons[5]:SetSize( 100, 26 );
	CCP.PlayerMenu.TopBar.Buttons[5].DoClick = function( self )
		
		CCP.PlayerMenu.ContentPane:Clear();
		GAMEMODE:PMCreateSettings();
		
	end
	CCP.PlayerMenu.TopBar.Buttons[5]:PerformLayout();
	
	CCP.PlayerMenu.ContentPane = vgui.Create( "DPanel", CCP.PlayerMenu );
	CCP.PlayerMenu.ContentPane:SetPos( 0, 74 );
	CCP.PlayerMenu.ContentPane:SetSize( 800, 426 );
	function CCP.PlayerMenu.ContentPane:Paint() end
	
	self:PMCreateBio();
	
end

local allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 -'";

function GM:PMCreateNameEdit()
	
	CCP.PlayerMenu.NameEdit = vgui.Create( "DFrame" );
	CCP.PlayerMenu.NameEdit:SetSize( 300, 114 );
	CCP.PlayerMenu.NameEdit:Center();
	CCP.PlayerMenu.NameEdit:SetTitle( "Change Name" );
	CCP.PlayerMenu.NameEdit.lblTitle:SetFont( "CombineControl.Window" );
	CCP.PlayerMenu.NameEdit:MakePopup();
	CCP.PlayerMenu.NameEdit.PerformLayout = CCFramePerformLayout;
	CCP.PlayerMenu.NameEdit:PerformLayout();
	
	CCP.PlayerMenu.NameEdit.Label = vgui.Create( "DLabel", CCP.PlayerMenu.NameEdit );
	CCP.PlayerMenu.NameEdit.Label:SetText( string.len( LocalPlayer():RPName() ) .. "/" .. self.MaxNameLength );
	CCP.PlayerMenu.NameEdit.Label:SetPos( 10, 74 );
	CCP.PlayerMenu.NameEdit.Label:SetSize( 280, 30 );
	CCP.PlayerMenu.NameEdit.Label:SetFont( "CombineControl.LabelGiant" );
	CCP.PlayerMenu.NameEdit.Label:PerformLayout();
	
	CCP.PlayerMenu.NameEdit.Entry = vgui.Create( "DTextEntry", CCP.PlayerMenu.NameEdit );
	CCP.PlayerMenu.NameEdit.Entry:SetFont( "CombineControl.LabelBig" );
	CCP.PlayerMenu.NameEdit.Entry:SetPos( 10, 34 );
	CCP.PlayerMenu.NameEdit.Entry:SetSize( 280, 30 );
	CCP.PlayerMenu.NameEdit.Entry:PerformLayout();
	CCP.PlayerMenu.NameEdit.Entry:SetValue( LocalPlayer():RPName() );
	CCP.PlayerMenu.NameEdit.Entry:RequestFocus();
	CCP.PlayerMenu.NameEdit.Entry:SetCaretPos( string.len( CCP.PlayerMenu.NameEdit.Entry:GetValue() ) );
	function CCP.PlayerMenu.NameEdit.Entry:OnChange()
		
		if( CCP.PlayerMenu.NameEdit.Label ) then
			
			local val = self:GetValue();
			
			local col = Color( 200, 200, 200, 255 );
			
			if( string.len( string.Trim( val ) ) > GAMEMODE.MaxNameLength or string.len( string.Trim( val ) ) < GAMEMODE.MinNameLength ) then
				
				col = Color( 200, 0, 0, 255 );
				
			end
			
			CCP.PlayerMenu.NameEdit.Label:SetText( string.len( string.Trim( val ) ) .. "/" .. GAMEMODE.MaxNameLength );
			CCP.PlayerMenu.NameEdit.Label:SetTextColor( col );
			
		end
		
	end
	function CCP.PlayerMenu.NameEdit.Entry:AllowInput( val )
		
		if( !string.find( allowedChars, val, 1, true ) ) then
			
			return true
			
		end
		
		return false;
		
	end
	
	CCP.PlayerMenu.NameEdit.OK = vgui.Create( "DButton", CCP.PlayerMenu.NameEdit );
	CCP.PlayerMenu.NameEdit.OK:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.NameEdit.OK:SetText( "OK" );
	CCP.PlayerMenu.NameEdit.OK:SetPos( 240, 74 );
	CCP.PlayerMenu.NameEdit.OK:SetSize( 50, 30 );
	function CCP.PlayerMenu.NameEdit.OK:DoClick()
		
		local val = string.Trim( CCP.PlayerMenu.NameEdit.Entry:GetValue() );
		
		if( string.len( val ) <= GAMEMODE.MaxNameLength and string.len( val ) >= GAMEMODE.MinNameLength ) then
			
			if( !string.find( allowedChars, val, 1, true ) ) then
				
				CCP.PlayerMenu.NameEdit:Remove();
				
				if( CCP.PlayerMenu.CharacterName ) then
					
					CCP.PlayerMenu.CharacterName:SetText( val );
					
				end
				
				net.Start( "nChangeRPName" );
					net.WriteString( val );
				net.SendToServer();
				
			else
				
				GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: Name cannot include '#', '~' or '%'.", { CB_ALL, CB_OOC } );
				
			end
			
		else
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: Name must be between " .. GAMEMODE.MinNameLength .. " and " .. GAMEMODE.MaxNameLength .. " characters.", { CB_ALL, CB_OOC } );
			
		end
		
	end
	CCP.PlayerMenu.NameEdit.OK:PerformLayout();
	
	CCP.PlayerMenu.NameEdit.Entry.OnEnter = CCP.PlayerMenu.NameEdit.OK.DoClick;
	
end

function GM:PMCreateDescEdit()
	
	CCP.PlayerMenu.DescEdit = vgui.Create( "DFrame" );
	CCP.PlayerMenu.DescEdit:SetSize( 400, 304 );
	CCP.PlayerMenu.DescEdit:Center();
	CCP.PlayerMenu.DescEdit:SetTitle( "Change Description" );
	CCP.PlayerMenu.DescEdit.lblTitle:SetFont( "CombineControl.Window" );
	CCP.PlayerMenu.DescEdit:MakePopup();
	CCP.PlayerMenu.DescEdit.PerformLayout = CCFramePerformLayout;
	CCP.PlayerMenu.DescEdit:PerformLayout();
	
	CCP.PlayerMenu.DescEdit.Label = vgui.Create( "DLabel", CCP.PlayerMenu.DescEdit );
	CCP.PlayerMenu.DescEdit.Label:SetText( string.len( LocalPlayer():Description() ) .. "/" .. self.MaxDescLength );
	CCP.PlayerMenu.DescEdit.Label:SetPos( 10, 264 );
	CCP.PlayerMenu.DescEdit.Label:SetSize( 380, 30 );
	CCP.PlayerMenu.DescEdit.Label:SetFont( "CombineControl.LabelGiant" );
	CCP.PlayerMenu.DescEdit.Label:PerformLayout();
	
	CCP.PlayerMenu.DescEdit.Entry = vgui.Create( "DTextEntry", CCP.PlayerMenu.DescEdit );
	CCP.PlayerMenu.DescEdit.Entry:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.DescEdit.Entry:SetPos( 10, 34 );
	CCP.PlayerMenu.DescEdit.Entry:SetSize( 380, 220 );
	CCP.PlayerMenu.DescEdit.Entry:PerformLayout();
	CCP.PlayerMenu.DescEdit.Entry:SetValue( LocalPlayer():Description() );
	CCP.PlayerMenu.DescEdit.Entry:SetMultiline( true );
	CCP.PlayerMenu.DescEdit.Entry:RequestFocus();
	CCP.PlayerMenu.DescEdit.Entry:SetCaretPos( string.len( CCP.PlayerMenu.DescEdit.Entry:GetValue() ) );
	function CCP.PlayerMenu.DescEdit.Entry:OnChange()
		
		if( CCP.PlayerMenu.DescEdit.Label ) then
			
			local val = self:GetValue();
			
			local col = Color( 200, 200, 200, 255 );
			
			if( string.len( string.Trim( val ) ) > GAMEMODE.MaxDescLength ) then
				
				col = Color( 200, 0, 0, 255 );
				
			end
			
			CCP.PlayerMenu.DescEdit.Label:SetText( string.len( string.Trim( val ) ) .. "/" .. GAMEMODE.MaxDescLength );
			CCP.PlayerMenu.DescEdit.Label:SetTextColor( col );
			
		end
		
	end
	
	CCP.PlayerMenu.DescEdit.OK = vgui.Create( "DButton", CCP.PlayerMenu.DescEdit );
	CCP.PlayerMenu.DescEdit.OK:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.DescEdit.OK:SetText( "OK" );
	CCP.PlayerMenu.DescEdit.OK:SetPos( 340, 264 );
	CCP.PlayerMenu.DescEdit.OK:SetSize( 50, 30 );
	function CCP.PlayerMenu.DescEdit.OK:DoClick()
		
		local val = string.Trim( CCP.PlayerMenu.DescEdit.Entry:GetValue() );
		
		if( string.len( val ) <= GAMEMODE.MaxDescLength ) then
			
			CCP.PlayerMenu.DescEdit:Remove();
			
			if( CCP.PlayerMenu.CharacterDesc and CCP.PlayerMenu.CharacterDesc:IsValid() ) then
				
				CCP.PlayerMenu.CharacterDesc:SetText( val );
				
			end
			
			net.Start( "nChangeTitle" );
				net.WriteString( val );
			net.SendToServer();
			
		else
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: Description must be less than " .. GAMEMODE.MaxDescLength .. " characters.", { CB_ALL, CB_OOC } );
			
		end
		
	end
	CCP.PlayerMenu.DescEdit.OK:PerformLayout();
	
	CCP.PlayerMenu.DescEdit.Entry.OnEnter = CCP.PlayerMenu.DescEdit.OK.DoClick;
	
end

function GM:PMCreateNotes()
	
	CCP.PlayerMenu.Notes = vgui.Create( "DFrame" );
	CCP.PlayerMenu.Notes:SetSize( 400, 304 );
	CCP.PlayerMenu.Notes:Center();
	CCP.PlayerMenu.Notes:SetTitle( "Notes" );
	CCP.PlayerMenu.Notes.lblTitle:SetFont( "CombineControl.Window" );
	CCP.PlayerMenu.Notes:MakePopup();
	CCP.PlayerMenu.Notes.PerformLayout = CCFramePerformLayout;
	CCP.PlayerMenu.Notes:PerformLayout();
	
	CCP.PlayerMenu.Notes.Entry = vgui.Create( "DTextEntry", CCP.PlayerMenu.Notes );
	CCP.PlayerMenu.Notes.Entry:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.Notes.Entry:SetPos( 10, 34 );
	CCP.PlayerMenu.Notes.Entry:SetSize( 380, 220 );
	CCP.PlayerMenu.Notes.Entry:PerformLayout();
	CCP.PlayerMenu.Notes.Entry:SetValue( cookie.GetString( "cc_notes_" .. LocalPlayer():CharID(), "" ) );
	CCP.PlayerMenu.Notes.Entry:SetMultiline( true );
	CCP.PlayerMenu.Notes.Entry:RequestFocus();
	CCP.PlayerMenu.Notes.Entry:SetCaretPos( string.len( CCP.PlayerMenu.Notes.Entry:GetValue() ) );
	
	CCP.PlayerMenu.Notes.OK = vgui.Create( "DButton", CCP.PlayerMenu.Notes );
	CCP.PlayerMenu.Notes.OK:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.Notes.OK:SetText( "OK" );
	CCP.PlayerMenu.Notes.OK:SetPos( 340, 264 );
	CCP.PlayerMenu.Notes.OK:SetSize( 50, 30 );
	function CCP.PlayerMenu.Notes.OK:DoClick()
		
		local val = string.Trim( CCP.PlayerMenu.Notes.Entry:GetValue() );
		
		CCP.PlayerMenu.Notes:Remove();
		
		cookie.Set( "cc_notes_" .. LocalPlayer():CharID(), val );
		
	end
	CCP.PlayerMenu.Notes.OK:PerformLayout();
	
	CCP.PlayerMenu.Notes.Entry.OnEnter = CCP.PlayerMenu.Notes.OK.DoClick;
	
end

function GM:PMCreateStats()
	
	CCP.PlayerMenu.Stats = vgui.Create( "DFrame" );
	CCP.PlayerMenu.Stats:SetSize( 400, 304 );
	CCP.PlayerMenu.Stats:Center();
	CCP.PlayerMenu.Stats:SetTitle( "Stats" );
	CCP.PlayerMenu.Stats.lblTitle:SetFont( "CombineControl.Window" );
	CCP.PlayerMenu.Stats:MakePopup();
	CCP.PlayerMenu.Stats.PerformLayout = CCFramePerformLayout;
	CCP.PlayerMenu.Stats:PerformLayout();
	
	local y = 24;
	
	for k,v in next, self.Stats do
	
		local label = vgui.Create( "DLabel", CCP.PlayerMenu.Stats );
		label:SetText( v );
		label:SetPos( 6, y );
		label:SetFont( "CombineControl.LabelMedium" );
		label:SizeToContents();
		label:PerformLayout();
		
		local bar = vgui.Create( "CCProgressBar", CCP.PlayerMenu.Stats );
		bar:SetPos( CCP.PlayerMenu.Stats:GetWide() - 184, y );
		bar:SetSize( 178, 16 );
		bar:SetProgress( LocalPlayer()[v](LocalPlayer()) / 10 );
		bar:SetProgressText( tostring( LocalPlayer()[v](LocalPlayer()) ) .. "/10" );
		
		y = y + 30;
	
	end
	
end

function GM:PMCreateAugments()
	
	CCP.PlayerMenu.Augments = vgui.Create( "DFrame" );
	CCP.PlayerMenu.Augments:SetSize( 256, 304 );
	CCP.PlayerMenu.Augments:Center();
	CCP.PlayerMenu.Augments:SetTitle( "Augments" );
	CCP.PlayerMenu.Augments.lblTitle:SetFont( "CombineControl.Window" );
	CCP.PlayerMenu.Augments:MakePopup();
	CCP.PlayerMenu.Augments.PerformLayout = CCFramePerformLayout;
	CCP.PlayerMenu.Augments:PerformLayout();

	for k,v in next, LocalPlayer().Augments do
	
		local metaitem = GAMEMODE:GetItemByID( k );
	
		local label = vgui.Create( "DLabel", CCP.PlayerMenu.Augments );
		label:SetText( metaitem.Name );
		label:Dock( TOP );
		label:SetContentAlignment( 8 );
		label:SetFont( "CombineControl.LabelMedium" );
		label:SizeToContents();
		label:PerformLayout();
	
	end
	
end

function GM:PMCreateTitleEdit()
	
	CCP.PlayerMenu.Title = vgui.Create( "DFrame" );
	CCP.PlayerMenu.Title:SetSize( 400, 256 );
	CCP.PlayerMenu.Title:Center();
	CCP.PlayerMenu.Title:SetTitle( "Change Titles" );
	CCP.PlayerMenu.Title.lblTitle:SetFont( "CombineControl.Window" );
	CCP.PlayerMenu.Title:MakePopup();
	CCP.PlayerMenu.Title.PerformLayout = CCFramePerformLayout;
	CCP.PlayerMenu.Title:PerformLayout();
	
	CCP.PlayerMenu.Title.TitleOne = vgui.Create( "DLabel", CCP.PlayerMenu.Title );
	CCP.PlayerMenu.Title.TitleOne:SetText( "Title One" );
	CCP.PlayerMenu.Title.TitleOne:SetPos( 10, 24 );
	CCP.PlayerMenu.Title.TitleOne:SetSize( 380, 30 );
	CCP.PlayerMenu.Title.TitleOne:SetFont( "CombineControl.LabelGiant" );
	CCP.PlayerMenu.Title.TitleOne:PerformLayout();
	
	CCP.PlayerMenu.Title.TitleOneLabel = vgui.Create( "DLabel", CCP.PlayerMenu.Title );
	CCP.PlayerMenu.Title.TitleOneLabel:SetText( string.len( LocalPlayer():TitleOne() ) .. "/" .. 128 );
	CCP.PlayerMenu.Title.TitleOneLabel:SetPos( 320, 24 );
	CCP.PlayerMenu.Title.TitleOneLabel:SetSize( 380, 30 );
	CCP.PlayerMenu.Title.TitleOneLabel:SetFont( "CombineControl.LabelGiant" );
	CCP.PlayerMenu.Title.TitleOneLabel:PerformLayout();
	
	CCP.PlayerMenu.Title.TitleOneEntry = vgui.Create( "DTextEntry", CCP.PlayerMenu.Title );
	CCP.PlayerMenu.Title.TitleOneEntry:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.Title.TitleOneEntry:SetPos( 10, 50 );
	CCP.PlayerMenu.Title.TitleOneEntry:SetSize( 380, 64 );
	CCP.PlayerMenu.Title.TitleOneEntry:PerformLayout();
	CCP.PlayerMenu.Title.TitleOneEntry:SetValue( LocalPlayer():TitleOne() );
	CCP.PlayerMenu.Title.TitleOneEntry:SetMultiline( true );
	CCP.PlayerMenu.Title.TitleOneEntry:RequestFocus();
	CCP.PlayerMenu.Title.TitleOneEntry:SetCaretPos( string.len( CCP.PlayerMenu.Title.TitleOneEntry:GetValue() ) );
	function CCP.PlayerMenu.Title.TitleOneEntry:OnChange()
		
		if( CCP.PlayerMenu.Title.TitleOneLabel ) then
			
			local val = self:GetValue();
			
			local col = Color( 200, 200, 200, 255 );
			
			if( string.len( string.Trim( val ) ) > 128 ) then
				
				col = Color( 200, 0, 0, 255 );
				
			end
			
			CCP.PlayerMenu.Title.TitleOneLabel:SetText( string.len( string.Trim( val ) ) .. "/" .. 128 );
			CCP.PlayerMenu.Title.TitleOneLabel:SetTextColor( col );
			
		end
		
	end
	
	CCP.PlayerMenu.Title.TitleTwo = vgui.Create( "DLabel", CCP.PlayerMenu.Title );
	CCP.PlayerMenu.Title.TitleTwo:SetText( "Title Two" );
	CCP.PlayerMenu.Title.TitleTwo:SetPos( 10, 116 );
	CCP.PlayerMenu.Title.TitleTwo:SetSize( 380, 30 );
	CCP.PlayerMenu.Title.TitleTwo:SetFont( "CombineControl.LabelGiant" );
	CCP.PlayerMenu.Title.TitleTwo:PerformLayout();
	
	CCP.PlayerMenu.Title.TitleTwoLabel = vgui.Create( "DLabel", CCP.PlayerMenu.Title );
	CCP.PlayerMenu.Title.TitleTwoLabel:SetText( string.len( LocalPlayer():TitleTwo() ) .. "/" .. 128 );
	CCP.PlayerMenu.Title.TitleTwoLabel:SetPos( 320, 116 );
	CCP.PlayerMenu.Title.TitleTwoLabel:SetSize( 380, 30 );
	CCP.PlayerMenu.Title.TitleTwoLabel:SetFont( "CombineControl.LabelGiant" );
	CCP.PlayerMenu.Title.TitleTwoLabel:PerformLayout();
	
	CCP.PlayerMenu.Title.TitleTwoEntry = vgui.Create( "DTextEntry", CCP.PlayerMenu.Title );
	CCP.PlayerMenu.Title.TitleTwoEntry:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.Title.TitleTwoEntry:SetPos( 10, 142 );
	CCP.PlayerMenu.Title.TitleTwoEntry:SetSize( 380, 64 );
	CCP.PlayerMenu.Title.TitleTwoEntry:PerformLayout();
	CCP.PlayerMenu.Title.TitleTwoEntry:SetValue( LocalPlayer():TitleTwo() );
	CCP.PlayerMenu.Title.TitleTwoEntry:SetMultiline( true );
	CCP.PlayerMenu.Title.TitleTwoEntry:RequestFocus();
	CCP.PlayerMenu.Title.TitleTwoEntry:SetCaretPos( string.len( CCP.PlayerMenu.Title.TitleTwoEntry:GetValue() ) );
	function CCP.PlayerMenu.Title.TitleTwoEntry:OnChange()
		
		if( CCP.PlayerMenu.Title.TitleTwoLabel ) then
			
			local val = self:GetValue();
			
			local col = Color( 200, 200, 200, 255 );
			
			if( string.len( string.Trim( val ) ) > 128 ) then
				
				col = Color( 200, 0, 0, 255 );
				
			end
			
			CCP.PlayerMenu.Title.TitleTwoLabel:SetText( string.len( string.Trim( val ) ) .. "/" .. 128 );
			CCP.PlayerMenu.Title.TitleTwoLabel:SetTextColor( col );
			
		end
		
	end
	
	CCP.PlayerMenu.Title.OK = vgui.Create( "DButton", CCP.PlayerMenu.Title );
	CCP.PlayerMenu.Title.OK:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.Title.OK:SetText( "OK" );
	CCP.PlayerMenu.Title.OK:SetPos( 340, 216 );
	CCP.PlayerMenu.Title.OK:SetSize( 50, 30 );
	function CCP.PlayerMenu.Title.OK:DoClick()
		
		local val1 = string.Trim( CCP.PlayerMenu.Title.TitleOneEntry:GetValue() );
		local val2 = string.Trim( CCP.PlayerMenu.Title.TitleTwoEntry:GetValue() );
		
		if( string.len( val1 ) <= 128 and string.len( val2 ) <= 128 ) then
			
			CCP.PlayerMenu.Title:Remove();
			
			if( CCP.PlayerMenu.TitleOne and CCP.PlayerMenu.TitleOne:IsValid() ) then
				
				CCP.PlayerMenu.TitleOne:SetText( val1 );
				CCP.PlayerMenu.TitleOne:PerformLayout();
				
			end
			
			if( CCP.PlayerMenu.TitleTwo and CCP.PlayerMenu.TitleTwo:IsValid() ) then
			
				CCP.PlayerMenu.TitleTwo:SetText( val2 );
				CCP.PlayerMenu.TitleTwo:PerformLayout();
				
			end
			
			net.Start( "nChangeTitleOne" );
				net.WriteString( val1 );
			net.SendToServer();
			
			net.Start( "nChangeTitleTwo" );
				net.WriteString( val2 );
			net.SendToServer();
			
			CCP.PlayerMenu.TitleOne:PerformLayout();
			CCP.PlayerMenu.TitleTwo:PerformLayout();
			
		else
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Error: Titles must be less than " .. 128 .. " characters.", { CB_ALL, CB_OOC } );
			
		end
		
	end
	CCP.PlayerMenu.Title.OK:PerformLayout();
	
	CCP.PlayerMenu.Title.TitleOneEntry.OnEnter = CCP.PlayerMenu.Title.OK.DoClick;
	CCP.PlayerMenu.Title.TitleTwoEntry.OnEnter = CCP.PlayerMenu.Title.OK.DoClick;

end
	
function GM:PMCreateBio()
	
	CCP.PlayerMenu.CharacterModel = vgui.Create( "DModelPanel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.CharacterModel:SetPos( 10, 10 );
	CCP.PlayerMenu.CharacterModel:SetModel( LocalPlayer():GetModel() );
	CCP.PlayerMenu.CharacterModel.Entity:SetSkin( LocalPlayer():GetSkin() );
	for i = 0,  20 do
		CCP.PlayerMenu.CharacterModel.Entity:SetBodygroup( i, LocalPlayer():GetBodygroup( i ) );
		CCP.PlayerMenu.CharacterModel.Entity:SetSubMaterial( i, LocalPlayer():GetSubMaterial( i ) );
	end
	CCP.PlayerMenu.CharacterModel:SetSize( 200, 406 );
	CCP.PlayerMenu.CharacterModel:SetFOV( 20 );
	CCP.PlayerMenu.CharacterModel:SetCamPos( Vector( 50, 0, 56 ) );
	CCP.PlayerMenu.CharacterModel:SetLookAt( Vector( 0, 0, 56 ) );
	function CCP.PlayerMenu.CharacterModel:DoClick()
		
		self:StartScene( "scenes/expressions/citizen_angry_idle_01.vcd" );
		
	end
	function CCP.PlayerMenu.CharacterModel.Entity:GetPlayerColor()
		
		if( !LocalPlayer() or !LocalPlayer():IsValid() ) then return Vector( 1, 1, 1 ) end
		
		return LocalPlayer():GetPlayerColor();
		
	end
	
	CCP.PlayerMenu.CharacterName = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.CharacterName:SetText( LocalPlayer():RPName() );
	CCP.PlayerMenu.CharacterName:DockMargin( 220, 10, 0, 0 );
	CCP.PlayerMenu.CharacterName:Dock( TOP );
	CCP.PlayerMenu.CharacterName:SetSize( 540, 22 );
	CCP.PlayerMenu.CharacterName:SetFont( "CombineControl.LabelGiant" );
	CCP.PlayerMenu.CharacterName:PerformLayout();
	
	CCP.PlayerMenu.CharacterNameEdit = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.CharacterNameEdit:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.CharacterNameEdit:SetText( "..." );
	CCP.PlayerMenu.CharacterNameEdit:SetPos( 770, 10 );
	CCP.PlayerMenu.CharacterNameEdit:SetSize( 20, 20 );
	function CCP.PlayerMenu.CharacterNameEdit:DoClick()
		
		GAMEMODE:PMCreateNameEdit();
		
	end
	CCP.PlayerMenu.CharacterNameEdit:PerformLayout();
	
	CCP.PlayerMenu.TitleOne = vgui.Create( "CCLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.TitleOne:DockMargin( 220, 8, 0, 0 );
	CCP.PlayerMenu.TitleOne:Dock( TOP );
	CCP.PlayerMenu.TitleOne:SetSize( 510, 10 );
	CCP.PlayerMenu.TitleOne:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.TitleOne:SetText( LocalPlayer():TitleOne() );
	CCP.PlayerMenu.TitleOne:PerformLayout();
	
	CCP.PlayerMenu.TitleTwo = vgui.Create( "CCLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.TitleTwo:DockMargin( 220, 2, 0, 0 );
	CCP.PlayerMenu.TitleTwo:Dock( TOP );
	CCP.PlayerMenu.TitleTwo:SetSize( 510, 10 );
	CCP.PlayerMenu.TitleTwo:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.TitleTwo:SetText( LocalPlayer():TitleTwo() );
	CCP.PlayerMenu.TitleTwo:PerformLayout();
	
	CCP.PlayerMenu.TitleEdit = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.TitleEdit:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.TitleEdit:SetText( "..." );
	CCP.PlayerMenu.TitleEdit:SetPos( 770, 40 );
	CCP.PlayerMenu.TitleEdit:SetSize( 20, 20 );
	function CCP.PlayerMenu.TitleEdit:DoClick()
		
		GAMEMODE:PMCreateTitleEdit();
		
	end
	CCP.PlayerMenu.TitleEdit:PerformLayout();
	
	CCP.PlayerMenu.CharacterDescScroll = vgui.Create( "DScrollPanel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.CharacterDescScroll:DockMargin( 220, 14, 0, 0 );
	CCP.PlayerMenu.CharacterDescScroll:Dock( TOP );
	CCP.PlayerMenu.CharacterDescScroll:SetSize( 540, 376 );
	function CCP.PlayerMenu.CharacterDescScroll:Paint( w, h ) end
	
	CCP.PlayerMenu.CharacterDesc = vgui.Create( "CCLabel" );
	CCP.PlayerMenu.CharacterDesc:SetPos( 0, 0 );
	CCP.PlayerMenu.CharacterDesc:SetSize( 530, 10 );
	CCP.PlayerMenu.CharacterDesc:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.CharacterDesc:SetText( LocalPlayer():Description() );
	CCP.PlayerMenu.CharacterDesc:PerformLayout();
	
	CCP.PlayerMenu.CharacterDescScroll:AddItem( CCP.PlayerMenu.CharacterDesc );
	
	CCP.PlayerMenu.CharacterDescEdit = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.CharacterDescEdit:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.CharacterDescEdit:SetText( "..." );
	CCP.PlayerMenu.CharacterDescEdit:SetPos( 770, 80 );
	CCP.PlayerMenu.CharacterDescEdit:SetSize( 20, 20 );
	function CCP.PlayerMenu.CharacterDescEdit:DoClick()
		
		GAMEMODE:PMCreateDescEdit();
		
	end
	CCP.PlayerMenu.CharacterDescEdit:PerformLayout();
	
	local traits = { };
	
	for k, v in pairs( self.Traits ) do
		
		if( LocalPlayer():HasTrait( k ) ) then
			
			table.insert( traits, self.Traits[k][1] );
			
		end
		
	end
	
	CCP.PlayerMenu.CharacterTrait = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.CharacterTrait:SetText( "Traits: " .. table.concat( traits, ", " ) );
	CCP.PlayerMenu.CharacterTrait:SetPos( 220, 396 );
	CCP.PlayerMenu.CharacterTrait:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.CharacterTrait:SizeToContents();
	CCP.PlayerMenu.CharacterTrait:PerformLayout();
	
	CCP.PlayerMenu.CharacterMoney = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.CharacterMoney:SetText("$" .. LocalPlayer():Money());
	CCP.PlayerMenu.CharacterMoney:SetPos( 220, 380 );
	CCP.PlayerMenu.CharacterMoney:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.CharacterMoney:SizeToContents();
	CCP.PlayerMenu.CharacterMoney:PerformLayout();
	
	CCP.PlayerMenu.CharacterNotes = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.CharacterNotes:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.CharacterNotes:SetText( "Notes" );
	CCP.PlayerMenu.CharacterNotes:SetPos( 710, 396 );
	CCP.PlayerMenu.CharacterNotes:SetSize( 80, 20 );
	function CCP.PlayerMenu.CharacterNotes:DoClick()
		
		GAMEMODE:PMCreateNotes();
		
	end
	CCP.PlayerMenu.CharacterNotes:PerformLayout();
	
	CCP.PlayerMenu.CharacterStats = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.CharacterStats:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.CharacterStats:SetText( "Stats" );
	CCP.PlayerMenu.CharacterStats:SetPos( 710, 370 );
	CCP.PlayerMenu.CharacterStats:SetSize( 80, 20 );
	function CCP.PlayerMenu.CharacterStats:DoClick()
		
		GAMEMODE:PMCreateStats();
		
	end
	CCP.PlayerMenu.CharacterStats:PerformLayout();
	
	CCP.PlayerMenu.CharacterAugments = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.CharacterAugments:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.CharacterAugments:SetText( "Augments" );
	CCP.PlayerMenu.CharacterAugments:SetPos( 710, 344 );
	CCP.PlayerMenu.CharacterAugments:SetSize( 80, 20 );
	function CCP.PlayerMenu.CharacterAugments:DoClick()
		
		GAMEMODE:PMCreateAugments();
		
	end
	CCP.PlayerMenu.CharacterAugments:PerformLayout();
	
end

function GM:PMCreateInventory()
	
	if( CCP.PlayerMenu.InvButtons ) then
		
		for _, v in pairs( CCP.PlayerMenu.InvButtons ) do
			
			v:Remove();
			
		end
		
	end
	
	CCP.PlayerMenu.InvButtons = { };
	
	CCP.PlayerMenu.InvModel = vgui.Create( "DModelPanel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.InvModel:SetPos( 420, 10 );
	CCP.PlayerMenu.InvModel:SetModel( "" );
	CCP.PlayerMenu.InvModel:SetSize( CCP.PlayerMenu.ContentPane:GetWide() - 430, 200 );
	CCP.PlayerMenu.InvModel:SetFOV( 20 );
	CCP.PlayerMenu.InvModel:SetCamPos( Vector( 50, 50, 50 ) );
	CCP.PlayerMenu.InvModel:SetLookAt( Vector( 0, 0, 0 ) );
	
	local p = CCP.PlayerMenu.InvModel.Paint;
	
	function CCP.PlayerMenu.InvModel:Paint( w, h )
		
		surface.SetDrawColor( 0, 0, 0, 70 );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( 0, 0, 0, 100 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
		p( self, w, h );
		
	end
	
	function CCP.PlayerMenu.InvModel:LayoutEntity( ent ) end
	
	CCP.PlayerMenu.InvTitle = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.InvTitle:SetText( "" );
	CCP.PlayerMenu.InvTitle:SetPos( 420, 220 );
	CCP.PlayerMenu.InvTitle:SetFont( "CombineControl.LabelGiant" );
	CCP.PlayerMenu.InvTitle:SetSize( CCP.PlayerMenu.ContentPane:GetWide() - 430 - 110, 22 );
	CCP.PlayerMenu.InvTitle:PerformLayout();
	
	CCP.PlayerMenu.InvWeight = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.InvWeight:SetText( "" );
	CCP.PlayerMenu.InvWeight:SetPos( 420, CCP.PlayerMenu.ContentPane:GetTall() - 30 );
	CCP.PlayerMenu.InvWeight:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.InvWeight:SetSize( CCP.PlayerMenu.ContentPane:GetWide() - 430 - 110, 22 );
	CCP.PlayerMenu.InvWeight:PerformLayout();
	
	CCP.PlayerMenu.InvDesc = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.InvDesc:SetText( "No item selected." );
	CCP.PlayerMenu.InvDesc:SetPos( 420, 250 );
	CCP.PlayerMenu.InvDesc:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.InvDesc:SetSize( CCP.PlayerMenu.ContentPane:GetWide() - 430 - 110, 14 );
	CCP.PlayerMenu.InvDesc:SetAutoStretchVertical( true );
	CCP.PlayerMenu.InvDesc:SetWrap( true );
	CCP.PlayerMenu.InvDesc:PerformLayout();
	
	if( #LocalPlayer().Inventory[LocalPlayer():GetDutyInventory()] == 0 ) then
		
		CCP.PlayerMenu.InvDesc:SetText( "You don't have any items!" );
		
	end
	
	CCP.PlayerMenu.InvScroll = vgui.Create( "DScrollPanel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.InvScroll:SetPos( 10, 10 );
	CCP.PlayerMenu.InvScroll:SetSize( 400, CCP.PlayerMenu.ContentPane:GetTall() - 50 );
	function CCP.PlayerMenu.InvScroll:Paint( w, h )
		
		surface.SetDrawColor( 0, 0, 0, 70 );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( 0, 0, 0, 100 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
	end
	
	CCP.PlayerMenu.InvWeightBar = vgui.Create( "CCProgressBar", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.InvWeightBar:SetPos( 10, CCP.PlayerMenu.ContentPane:GetTall() - 30 );
	CCP.PlayerMenu.InvWeightBar:SetSize( 400, 20 );
	
	self:PMUpdateInventory();
	
end

function GM:PMResetText()
	
	if( CCP.PlayerMenu.InvButtons ) then
		
		for _, v in pairs( CCP.PlayerMenu.InvButtons ) do
			
			v:Remove();
			
		end
		
	end
	
	if( !CCP.PlayerMenu.InvModel or !CCP.PlayerMenu.InvTitle or !CCP.PlayerMenu.InvWeight or !CCP.PlayerMenu.InvDesc ) then return end
	
	CCP.PlayerMenu.InvModel:SetModel( "" );
	CCP.PlayerMenu.InvTitle:SetText( "" );
	CCP.PlayerMenu.InvWeight:SetText( "" );
	CCP.PlayerMenu.InvDesc:SetText( "No item selected." );
	
	if( #LocalPlayer().Inventory[LocalPlayer():GetDutyInventory()] == 0 ) then
		
		CCP.PlayerMenu.InvDesc:SetText( "You don't have any items!" );
		
	end
	
end

function GM:PMUpdateInventory()
	
	if( !CCP.PlayerMenu or !CCP.PlayerMenu:IsValid() or !CCP.PlayerMenu.ContentPane or !CCP.PlayerMenu.ContentPane:IsValid() or !CCP.PlayerMenu.InvScroll or !CCP.PlayerMenu.InvScroll:IsValid() ) then return end
	
	CCP.PlayerMenu.InvScroll:Clear();
	
	local x = 0;
	local y = 0;
	
	for k, v in pairs( LocalPlayer().Inventory[LocalPlayer():GetDutyInventory()] ) do
		
		local i = GAMEMODE:GetItemByID( v );
		
		if( i ) then
			
			local icon = vgui.Create( "DModelPanel", CCP.PlayerMenu.InvScroll );
			icon.Item = v;
			icon.InventoryID = k;
			
			icon:SetPos( x, y );
			icon:SetModel( i.Model );
			if( i.ItemSubmaterials ) then for m,n in next, i.ItemSubmaterials do icon.Entity:SetSubMaterial( n[1], n[2] ) end end
			icon:SetSize( 48, 48 );
			
			if( i.LookAt ) then
				
				icon:SetFOV( i.FOV );
				icon:SetCamPos( i.CamPos );
				icon:SetLookAt( i.LookAt );
				
			else
				
				local a, b = icon.Entity:GetModelBounds();
				
				icon:SetFOV( 20 );
				icon:SetCamPos( Vector( math.abs( a.x ), math.abs( a.y ), math.abs( a.z ) ) * 5 );
				icon:SetLookAt( ( a + b ) / 2 );
				
			end
			
			if( i.IconMaterial ) then icon.Entity:SetMaterial( i.IconMaterial ) end
			if( i.IconColor ) then icon.Entity:SetColor( i.IconColor ) end
			
			function icon:LayoutEntity() end
			
			x = x + 48 + 10;
			
			if( x > CCP.PlayerMenu.InvScroll:GetWide() - 48 ) then
				
				x = 0;
				y = y + 48 + 10;
				
			end
			
			local p = icon.Paint;
			
			function icon:Paint( w, h )
				
				local pnl = self:GetParent():GetParent();
				local x2, y2 = pnl:LocalToScreen( 0, 0 );
				local w2, h2 = pnl:GetSize();
				render.SetScissorRect( x2, y2, x2 + w2, y2 + h2, true );

				p( self, w, h );
				
				render.SetScissorRect( 0, 0, 0, 0, false );
				
			end
			
			function icon:DoClick()
				
				CCP.PlayerMenu.SelectedItem = self.InventoryID;
				
				if( CCP.PlayerMenu.InvModel.Entity and CCP.PlayerMenu.InvModel:IsValid() ) then
					
					CCP.PlayerMenu.InvModel.Entity:SetMaterial( "" );
					CCP.PlayerMenu.InvModel.Entity:SetColor( Color( 255, 255, 255, 255 ) );
					
				end
				
				CCP.PlayerMenu.InvModel:SetModel( GAMEMODE:GetItemByID( self.Item ).Model );
				if( i.ItemSubmaterials ) then for m,n in next, i.ItemSubmaterials do CCP.PlayerMenu.InvModel.Entity:SetSubMaterial( n[1], n[2] ) end end
				CCP.PlayerMenu.InvTitle:SetText( GAMEMODE:GetItemByID( self.Item ).Name );
				CCP.PlayerMenu.InvWeight:SetText( "Weight: " .. tostring( GAMEMODE:GetItemByID( self.Item ).Weight ) );
				CCP.PlayerMenu.InvDesc:SetText( GAMEMODE:GetItemByID( self.Item ).Description );
				
				if( GAMEMODE:GetItemByID( self.Item ).LookAt ) then
					
					CCP.PlayerMenu.InvModel:SetFOV( GAMEMODE:GetItemByID( self.Item ).FOV );
					CCP.PlayerMenu.InvModel:SetCamPos( GAMEMODE:GetItemByID( self.Item ).CamPos );
					CCP.PlayerMenu.InvModel:SetLookAt( GAMEMODE:GetItemByID( self.Item ).LookAt );
					
				else
					
					local a, b = CCP.PlayerMenu.InvModel.Entity:GetModelBounds();
					
					CCP.PlayerMenu.InvModel:SetFOV( 20 );
					CCP.PlayerMenu.InvModel:SetCamPos( Vector( math.abs( a.x ), math.abs( a.y ), math.abs( a.z ) ) * 5 );
					CCP.PlayerMenu.InvModel:SetLookAt( ( a + b ) / 2 );
					
				end
				
				if( GAMEMODE:GetItemByID( self.Item ).IconMaterial ) then CCP.PlayerMenu.InvModel.Entity:SetMaterial( GAMEMODE:GetItemByID( self.Item ).IconMaterial ) end
				if( GAMEMODE:GetItemByID( self.Item ).IconColor ) then CCP.PlayerMenu.InvModel.Entity:SetColor( GAMEMODE:GetItemByID( self.Item ).IconColor ) end
				
				local y = 0;
				
				if( GAMEMODE:GetItemByID( self.Item ).Throwable ) then
					
					if( CCP.PlayerMenu.ButThrow and CCP.PlayerMenu.ButThrow:IsValid() ) then
						
						CCP.PlayerMenu.ButThrow:Remove();
						
					end
					
					CCP.PlayerMenu.ButThrow = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
					CCP.PlayerMenu.ButThrow:SetFont( "CombineControl.LabelSmall" );
					CCP.PlayerMenu.ButThrow:SetText( "Throw Out" );
					CCP.PlayerMenu.ButThrow:SetPos( CCP.PlayerMenu.ContentPane:GetWide() - 110, CCP.PlayerMenu.ContentPane:GetTall() - 30 + y );
					CCP.PlayerMenu.ButThrow:SetSize( 100, 20 );
					function CCP.PlayerMenu.ButThrow:DoClick()
						
						LocalPlayer():ThrowOutItem( self.InventoryID );
						
						GAMEMODE:PMResetText();
						
					end
					CCP.PlayerMenu.ButThrow:PerformLayout();
					CCP.PlayerMenu.ButThrow.InventoryID = self.InventoryID;
					table.insert( CCP.PlayerMenu.InvButtons, CCP.PlayerMenu.ButThrow );
					y = y - 30;
					
				elseif( CCP.PlayerMenu.ButThrow ) then
					
					CCP.PlayerMenu.ButThrow:Remove();
					CCP.PlayerMenu.ButThrow = nil;
					
				end
				
				if( GAMEMODE:GetItemByID( self.Item ).Droppable and !LocalPlayer():IsItemEquipped( self.Item ) ) then
					
					if( CCP.PlayerMenu.ButDrop and CCP.PlayerMenu.ButDrop:IsValid() ) then
						
						CCP.PlayerMenu.ButDrop:Remove();
						
					end
					
					CCP.PlayerMenu.ButDrop = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
					CCP.PlayerMenu.ButDrop:SetFont( "CombineControl.LabelSmall" );
					CCP.PlayerMenu.ButDrop:SetText( "Drop" );
					CCP.PlayerMenu.ButDrop:SetPos( CCP.PlayerMenu.ContentPane:GetWide() - 110, CCP.PlayerMenu.ContentPane:GetTall() - 30 + y );
					CCP.PlayerMenu.ButDrop:SetSize( 100, 20 );
					function CCP.PlayerMenu.ButDrop:DoClick()
						
						LocalPlayer():DropItem( self.InventoryID );
						
						GAMEMODE:PMResetText();
						
					end
					CCP.PlayerMenu.ButDrop:PerformLayout();
					CCP.PlayerMenu.ButDrop.InventoryID = self.InventoryID;
					table.insert( CCP.PlayerMenu.InvButtons, CCP.PlayerMenu.ButDrop );
					y = y - 30;
					
					if( CCP.PlayerMenu.ButMoveToStock and CCP.PlayerMenu.ButMoveToStock:IsValid() ) then
						
						CCP.PlayerMenu.ButMoveToStock:Remove();
						
					end
					
					if( DoDistanceCheckForStockpile( LocalPlayer() ) ) then
					
						CCP.PlayerMenu.ButMoveToStock = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
						CCP.PlayerMenu.ButMoveToStock:SetFont( "CombineControl.LabelSmall" );
						CCP.PlayerMenu.ButMoveToStock:SetText( "Stockpile" );
						CCP.PlayerMenu.ButMoveToStock:SetPos( CCP.PlayerMenu.ContentPane:GetWide() - 110, CCP.PlayerMenu.ContentPane:GetTall() - 30 + y );
						CCP.PlayerMenu.ButMoveToStock:SetSize( 100, 20 );
						function CCP.PlayerMenu.ButMoveToStock:DoClick()

							LocalPlayer():MoveToStockpile( self.InventoryID );
							
						end
						CCP.PlayerMenu.ButMoveToStock:PerformLayout();
						CCP.PlayerMenu.ButMoveToStock.InventoryID = self.InventoryID;
						table.insert( CCP.PlayerMenu.InvButtons, CCP.PlayerMenu.ButMoveToStock );
						y = y - 30;
						
					end
					
				else
					
					if( CCP.PlayerMenu.ButMoveToStock ) then
					
						CCP.PlayerMenu.ButMoveToStock:Remove();
						CCP.PlayerMenu.ButMoveToStock = nil;
						
					elseif( CCP.PlayerMenu.ButDrop ) then
					
						CCP.PlayerMenu.ButDrop:Remove();
						CCP.PlayerMenu.ButDrop = nil;
					
					end
					
				end
				
				if( GAMEMODE:GetItemByID( self.Item ).Usable ) then
					
					if( CCP.PlayerMenu.ButUse and CCP.PlayerMenu.ButUse:IsValid() ) then
						
						CCP.PlayerMenu.ButUse:Remove();
						
					end
					
					if( GAMEMODE:GetItemByID( self.Item ).CanPlayerUse ) then
					
						if( GAMEMODE:GetItemByID( self.Item ).CanPlayerUse( self.Item, LocalPlayer() ) == false ) then
						
							return
							
						end
						
					end
					
					local text = "Use";
					
					if( GAMEMODE:GetItemByID( self.Item ).UseText ) then
						
						text = GAMEMODE:GetItemByID( self.Item ).UseText;
						
					end
					
					if( GAMEMODE:GetItemByID( self.Item ).GetUseText ) then
					
						text = GAMEMODE:GetItemByID( self.Item ).GetUseText( LocalPlayer(), self.Item );
						
					end
					
					CCP.PlayerMenu.ButUse = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
					CCP.PlayerMenu.ButUse:SetFont( "CombineControl.LabelSmall" );
					CCP.PlayerMenu.ButUse:SetText( text );
					CCP.PlayerMenu.ButUse:SetPos( CCP.PlayerMenu.ContentPane:GetWide() - 110, CCP.PlayerMenu.ContentPane:GetTall() - 30 + y );
					CCP.PlayerMenu.ButUse:SetSize( 100, 20 );
					function CCP.PlayerMenu.ButUse:DoClick()
						
						LocalPlayer():UseItem( self.InventoryID );
						
					end
					CCP.PlayerMenu.ButUse:PerformLayout();
					CCP.PlayerMenu.ButUse.InventoryID = self.InventoryID;
					table.insert( CCP.PlayerMenu.InvButtons, CCP.PlayerMenu.ButUse );
					y = y - 30;
					
				elseif( CCP.PlayerMenu.ButUse ) then
					
					CCP.PlayerMenu.ButUse:Remove();
					CCP.PlayerMenu.ButUse = nil;
					
				end
				
			end
			
		end
		
	end
	
	if( CCP.PlayerMenu.SelectedItem ) then
		
		local bad = true;
		
		for k, v in pairs( LocalPlayer().Inventory ) do
			
			if( CCP.PlayerMenu.SelectedItem == k ) then
				
				bad = false;
				
			end
			
		end
		
		if( bad ) then
			
			self:PMResetText();
			
		end
		
	end
	
	CCP.PlayerMenu.InvWeightBar:SetProgress( LocalPlayer():InventoryWeight() / LocalPlayer():InventoryMaxWeight() );
	CCP.PlayerMenu.InvWeightBar:SetProgressText( "Weight: " .. LocalPlayer():InventoryWeight() .. "/" .. LocalPlayer():InventoryMaxWeight() );
	
end

function GM:PMResetStockpileText()
	
	if( CCP.StockpileMenu.InvButtons ) then
		
		for _, v in pairs( CCP.StockpileMenu.InvButtons ) do
			
			v:Remove();
			
		end
		
	end
	
	if( !CCP.StockpileMenu.InvModel or !CCP.StockpileMenu.InvTitle or !CCP.StockpileMenu.InvWeight or !CCP.StockpileMenu.InvDesc ) then return end
	
	CCP.StockpileMenu.InvModel:SetModel( "" );
	CCP.StockpileMenu.InvTitle:SetText( "" );
	CCP.StockpileMenu.InvWeight:SetText( "" );
	CCP.StockpileMenu.InvDesc:SetText( "No item selected." );
	
end

function GM:PMCreateStockpile()

	CCP.StockpileMenu = vgui.Create( "DFrame" );
	CCP.StockpileMenu:SetSize( 800, 500 );
	CCP.StockpileMenu:Center();
	CCP.StockpileMenu:SetTitle( "FedEx Saf-T-Store Personal Dropbox System" );
	CCP.StockpileMenu.lblTitle:SetFont( "CombineControl.Window" );
	CCP.StockpileMenu:MakePopup();
	CCP.StockpileMenu.PerformLayout = CCFramePerformLayout;
	CCP.StockpileMenu:PerformLayout();
	
	CCP.StockpileMenu.InvModel = vgui.Create( "DModelPanel", CCP.StockpileMenu );
	CCP.StockpileMenu.InvModel:SetPos( 420, 30 );
	CCP.StockpileMenu.InvModel:SetModel( "" );
	CCP.StockpileMenu.InvModel:SetSize( CCP.StockpileMenu:GetWide() - 430, 200 );
	CCP.StockpileMenu.InvModel:SetFOV( 20 );
	CCP.StockpileMenu.InvModel:SetCamPos( Vector( 50, 50, 50 ) );
	CCP.StockpileMenu.InvModel:SetLookAt( Vector( 0, 0, 0 ) );
	
	local p = CCP.StockpileMenu.InvModel.Paint;
	
	function CCP.StockpileMenu.InvModel:Paint( w, h )
		
		surface.SetDrawColor( 0, 0, 0, 70 );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( 0, 0, 0, 100 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
		p( self, w, h );
		
	end
	
	function CCP.StockpileMenu.InvModel:LayoutEntity( ent ) end
	
	CCP.StockpileMenu.InvTitle = vgui.Create( "DLabel", CCP.StockpileMenu );
	CCP.StockpileMenu.InvTitle:SetText( "" );
	CCP.StockpileMenu.InvTitle:SetPos( 420, 240 );
	CCP.StockpileMenu.InvTitle:SetFont( "CombineControl.LabelGiant" );
	CCP.StockpileMenu.InvTitle:SetSize( CCP.StockpileMenu:GetWide() - 430 - 110, 22 );
	CCP.StockpileMenu.InvTitle:PerformLayout();
	
	CCP.StockpileMenu.InvWeight = vgui.Create( "DLabel", CCP.StockpileMenu );
	CCP.StockpileMenu.InvWeight:SetText( "" );
	CCP.StockpileMenu.InvWeight:SetPos( 420, CCP.StockpileMenu:GetTall() - 30 );
	CCP.StockpileMenu.InvWeight:SetFont( "CombineControl.LabelSmall" );
	CCP.StockpileMenu.InvWeight:SetSize( CCP.StockpileMenu:GetWide() - 430 - 110, 22 );
	CCP.StockpileMenu.InvWeight:PerformLayout();
	
	CCP.StockpileMenu.InvDesc = vgui.Create( "DLabel", CCP.StockpileMenu );
	CCP.StockpileMenu.InvDesc:SetText( "No item selected." );
	CCP.StockpileMenu.InvDesc:SetPos( 420, 270 );
	CCP.StockpileMenu.InvDesc:SetFont( "CombineControl.LabelSmall" );
	CCP.StockpileMenu.InvDesc:SetSize( CCP.StockpileMenu:GetWide() - 430 - 110, 14 );
	CCP.StockpileMenu.InvDesc:SetAutoStretchVertical( true );
	CCP.StockpileMenu.InvDesc:SetWrap( true );
	CCP.StockpileMenu.InvDesc:PerformLayout();
	
	CCP.StockpileMenu.InvScroll = vgui.Create( "DScrollPanel", CCP.StockpileMenu );
	CCP.StockpileMenu.InvScroll:SetPos( 10, 30 );
	CCP.StockpileMenu.InvScroll:SetSize( 400, CCP.StockpileMenu:GetTall() - 50 );
	function CCP.StockpileMenu.InvScroll:Paint( w, h )
		
		surface.SetDrawColor( 0, 0, 0, 70 );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( 0, 0, 0, 100 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
	end
	
	self:PopulateStockpile();

end

function GM:PopulateStockpile()

	local x = 0;
	local y = 0;
	
	CCP.StockpileMenu.InvButtons = {};
	
	for k,v in next, LocalPlayer().Stockpile do
	
		local i = GAMEMODE:GetItemByID( v );
		
		if( i ) then
			
			local icon = vgui.Create( "DModelPanel", CCP.StockpileMenu.InvScroll );
			icon.Item = v;
			icon.InventoryID = k;
			
			icon:SetPos( x, y );
			icon:SetModel( i.Model );
			if( i.ItemSubmaterials ) then for m,n in next, i.ItemSubmaterials do icon.Entity:SetSubMaterial( n[1], n[2] ) end end
			icon:SetSize( 48, 48 );
			
			if( i.LookAt ) then
				
				icon:SetFOV( i.FOV );
				icon:SetCamPos( i.CamPos );
				icon:SetLookAt( i.LookAt );
				
			else
				
				local a, b = icon.Entity:GetModelBounds();
				
				icon:SetFOV( 20 );
				icon:SetCamPos( Vector( math.abs( a.x ), math.abs( a.y ), math.abs( a.z ) ) * 5 );
				icon:SetLookAt( ( a + b ) / 2 );
				
			end
			
			if( i.IconMaterial ) then icon.Entity:SetMaterial( i.IconMaterial ) end
			if( i.IconColor ) then icon.Entity:SetColor( i.IconColor ) end
			
			function icon:LayoutEntity() end
			
			x = x + 48 + 10;
			
			if( x > CCP.StockpileMenu.InvScroll:GetWide() - 48 ) then
				
				x = 0;
				y = y + 48 + 10;
				
			end
			
			local p = icon.Paint;
			
			function icon:Paint( w, h )
				
				local pnl = self:GetParent():GetParent();
				local x2, y2 = pnl:LocalToScreen( 0, 0 );
				local w2, h2 = pnl:GetSize();
				render.SetScissorRect( x2, y2, x2 + w2, y2 + h2, true );

				p( self, w, h );
				
				render.SetScissorRect( 0, 0, 0, 0, false );
				
			end
			
			function icon:DoClick()
				
				CCP.StockpileMenu.SelectedItem = self.InventoryID;
				
				if( CCP.StockpileMenu.InvModel.Entity and CCP.StockpileMenu.InvModel:IsValid() ) then
					
					CCP.StockpileMenu.InvModel.Entity:SetMaterial( "" );
					CCP.StockpileMenu.InvModel.Entity:SetColor( Color( 255, 255, 255, 255 ) );
					
				end
				
				CCP.StockpileMenu.InvModel:SetModel( GAMEMODE:GetItemByID( self.Item ).Model );
				CCP.StockpileMenu.InvTitle:SetText( GAMEMODE:GetItemByID( self.Item ).Name );
				CCP.StockpileMenu.InvWeight:SetText( "Weight: " .. tostring( GAMEMODE:GetItemByID( self.Item ).Weight ) );
				CCP.StockpileMenu.InvDesc:SetText( GAMEMODE:GetItemByID( self.Item ).Description );
				
				local y = 0;
				
				if( CCP.StockpileMenu.ButTake and CCP.StockpileMenu.ButTake:IsValid() ) then
					
					CCP.StockpileMenu.ButTake:Remove();
					
				end
				
				CCP.StockpileMenu.ButTake = vgui.Create( "DButton", CCP.StockpileMenu );
				CCP.StockpileMenu.ButTake:SetFont( "CombineControl.LabelSmall" );
				CCP.StockpileMenu.ButTake:SetText( "Take" );
				CCP.StockpileMenu.ButTake:SetPos( CCP.StockpileMenu:GetWide() - 110, CCP.StockpileMenu:GetTall() - 30 + y );
				CCP.StockpileMenu.ButTake:SetSize( 100, 20 );
				function CCP.StockpileMenu.ButTake:DoClick()
					
					LocalPlayer():TakeFromStockpile( self.InventoryID );
					GAMEMODE:PMResetStockpileText();
					icon:Remove();
					
				end
				CCP.StockpileMenu.ButTake:PerformLayout();
				CCP.StockpileMenu.ButTake.InventoryID = self.InventoryID;
				table.insert( CCP.StockpileMenu.InvButtons, CCP.StockpileMenu.ButTake );
				y = y - 30;
				
				if( GAMEMODE:GetItemByID( self.Item ).LookAt ) then
					
					CCP.StockpileMenu.InvModel:SetFOV( GAMEMODE:GetItemByID( self.Item ).FOV );
					CCP.StockpileMenu.InvModel:SetCamPos( GAMEMODE:GetItemByID( self.Item ).CamPos );
					CCP.StockpileMenu.InvModel:SetLookAt( GAMEMODE:GetItemByID( self.Item ).LookAt );
					
				else
					
					local a, b = CCP.StockpileMenu.InvModel.Entity:GetModelBounds();
					
					CCP.StockpileMenu.InvModel:SetFOV( 20 );
					CCP.StockpileMenu.InvModel:SetCamPos( Vector( math.abs( a.x ), math.abs( a.y ), math.abs( a.z ) ) * 5 );
					CCP.StockpileMenu.InvModel:SetLookAt( ( a + b ) / 2 );
					
				end
				
				if( GAMEMODE:GetItemByID( self.Item ).IconMaterial ) then CCP.StockpileMenu.InvModel.Entity:SetMaterial( GAMEMODE:GetItemByID( self.Item ).IconMaterial ) end
				if( GAMEMODE:GetItemByID( self.Item ).IconColor ) then CCP.StockpileMenu.InvModel.Entity:SetColor( GAMEMODE:GetItemByID( self.Item ).IconColor ) end
				
			end
			
		end
	
	end

end
function GM:PMPopulateBusiness()
	
	CCP.PlayerMenu.BusinessPane:Clear();
	
	local y = 0;
	
	local items_to_list = {}
	for k, v in pairs( self.Items ) do
		if !v.License or #v.License == 0 then continue end
		if( LocalPlayer():HasCharFlag(v.License) or string.find( LocalPlayer():BusinessLicenses(), v.License ) ) then
			items_to_list[#items_to_list+1] = v.ID
		end
	end
	
	if #items_to_list == 0 then
		CCP.PlayerMenu.BusinessSearch:SetText("You cannot buy any items!")
		return
	end
	
	CCP.PlayerMenu.BusinessPane.NextThink = CurTime()
	CCP.PlayerMenu.BusinessPane.CurrentItem = 1
	
	hook.Add("Think", "PopulateBusinessMenu", function()
		if !CCP.PlayerMenu.BusinessPane or !CCP.PlayerMenu.BusinessPane:IsValid() then
			hook.Remove("Think", "PopulateBusinessMenu")
			CCP.PlayerMenu.BusinessPane.NextThink = nil
			CCP.PlayerMenu.BusinessPane.CurrentItem = nil
			CCP.PlayerMenu.BusinessPane.IsGenerating = nil
			return
		end
	
		if !CCP.PlayerMenu.BusinessPane.CurrentItem then
			CCP.PlayerMenu.BusinessPane.CurrentItem = 1
		end
		
		local item = items_to_list[CCP.PlayerMenu.BusinessPane.CurrentItem]
		local metaitem = GAMEMODE:GetItemByID(item)
		if metaitem then
			
			local itempane = vgui.Create( "DPanel" );
			itempane:SetPos( 0, y );
			itempane.ItemName = metaitem.Name
			itempane:SetSize( 556, 64 );
			itempane:SetSkin( "STALKER" );
			function itempane:Paint( w, h )
				
				surface.SetDrawColor( 0, 0, 0, 70 );
				surface.DrawRect( 0, 0, w, h );
				
				surface.SetDrawColor( 0, 0, 0, 100 );
				surface.DrawOutlinedRect( 0, 0, w, h );
				
			end
			
			local icon = vgui.Create( "DModelPanel", itempane );
			icon:SetPos( 0, 0 );
			icon:SetModel( metaitem.Model );
			if( metaitem.ItemSubmaterials ) then for m,n in next, metaitem.ItemSubmaterials do icon.Entity:SetSubMaterial( n[1], n[2] ) end end
			icon:SetSize( 64, 64 );
			
			if( metaitem.LookAt ) then
				
				icon:SetFOV( metaitem.FOV );
				icon:SetCamPos( metaitem.CamPos );
				icon:SetLookAt( metaitem.LookAt );
				
			else
				
				local a, b = icon.Entity:GetModelBounds();
				
				icon:SetFOV( 20 );
				icon:SetCamPos( Vector( math.abs( a.x ), math.abs( a.y ), math.abs( a.z ) ) * 5 );
				icon:SetLookAt( ( a + b ) / 2 );
				
			end
			
			if( metaitem.IconMaterial ) then icon.Entity:SetMaterial( metaitem.IconMaterial ) end
			if( metaitem.IconColor ) then icon.Entity:SetColor( metaitem.IconColor ) end
			
			function icon:LayoutEntity() end
			
			local p = icon.Paint;
			
			function icon:Paint( w, h )
				
				local pnl = CCP.PlayerMenu.BusinessPane;
				local x2, y2 = pnl:LocalToScreen( 0, 0 );
				local w2, h2 = pnl:GetSize();
				render.SetScissorRect( x2, y2, x2 + w2, y2 + h2, true );
				
				p( self, w, h );
				
				render.SetScissorRect( 0, 0, 0, 0, false );
				
			end
			
			local name = vgui.Create( "DLabel", itempane );
			name:SetText( metaitem.Name );
			name:SetPos( 74, 10 );
			name:SetFont( "CombineControl.LabelSmall" );
			name:SizeToContents();
			name:PerformLayout();
			
			surface.SetFont( "CombineControl.LabelSmall" );
			local tW, tH = surface.GetTextSize( metaitem.Name );
			
			local d, n = GAMEMODE:FormatLine( metaitem.Description, "CombineControl.LabelTiny", 396 );
			
			local desc = vgui.Create( "DLabel", itempane );
			desc:SetText( d );
			desc:SetPos( 74, 24 );
			desc:SetFont( "CombineControl.LabelTiny" );
			desc:SizeToContents();
			desc:PerformLayout();
			
			local price = vgui.Create( "DLabel", itempane );
			price:SetText( "1 for $" .. string.format("%.2f", math.Round( (metaitem.BulkPrice / 5 + ( ( metaitem.BulkPrice / 5 ) / GAMEMODE.SellPercentage)), 2 )) );
			price:SetPos( 74 + tW + 20, 10 );
			price:SetFont( "CombineControl.LabelTiny" );
			price:SizeToContents();
			price:PerformLayout();
			
			local price = vgui.Create( "DLabel", itempane );
			price:SetText( "5 for $" .. string.format("%.2f", metaitem.BulkPrice));
			price:SetPos( 74 + tW + 120, 10 );
			price:SetFont( "CombineControl.LabelTiny" );
			price:SizeToContents();
			price:PerformLayout();
			
			local buyone = vgui.Create( "DButton", itempane );
			buyone:SetFont( "CombineControl.LabelSmall" );
			buyone:SetText( "Buy 1" );
			buyone:SetPos( 480, 6 );
			buyone:SetSize( 46, 24 );
			function buyone:DoClick()

				if( LocalPlayer():Money() >= metaitem.BulkPrice / 5 + ( ( metaitem.BulkPrice / 5 ) / GAMEMODE.SellPercentage ) ) then
					
					if( LocalPlayer():InventoryWeight() < LocalPlayer():InventoryMaxWeight() ) then

						net.Start( "nBuyItem" );
							net.WriteString( metaitem.ID );
							net.WriteBit( true );
						net.SendToServer();
						
						GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You bought one.", { CB_ALL, CB_IC } );
						
					else
						
						GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Your inventory is full. You can't carry this.", { CB_ALL, CB_IC } );
						
					end
					
				else
					
					GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You need more money to buy this!", { CB_ALL, CB_IC } );
					
				end
				
			end
			buyone:PerformLayout();
			
			local buyfive = vgui.Create( "DButton", itempane );
			buyfive:SetFont( "CombineControl.LabelSmall" );
			buyfive:SetText( "Buy 5" );
			buyfive:SetPos( 480, 32 );
			buyfive:SetSize( 46, 24 );
			function buyfive:DoClick()

				if( LocalPlayer():Money() >= metaitem.BulkPrice ) then
					
					if( LocalPlayer():InventoryWeight() < LocalPlayer():InventoryMaxWeight() ) then
						
						net.Start( "nBuyItem" );
							net.WriteString( metaitem.ID );
							net.WriteBit( false );
						net.SendToServer();
						
						GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You bought five.", { CB_ALL, CB_IC } );
						
					else
						
						GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Your inventory is full. You can't carry this.", { CB_ALL, CB_IC } );
						
					end
					
				else
					
					GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You need more money to buy this!", { CB_ALL, CB_IC } );
					
				end
				
			end
			buyfive:PerformLayout();
			
			CCP.PlayerMenu.BusinessPane:Add( itempane );
			
			y = y + 64;
		end
		
		if CCP.PlayerMenu.BusinessPane.CurrentItem == #items_to_list then
			hook.Remove("Think", "PopulateBusinessMenu")
			CCP.PlayerMenu.BusinessPane.NextThink = nil
			CCP.PlayerMenu.BusinessPane.CurrentItem = nil
			CCP.PlayerMenu.BusinessPane.IsGenerating = nil
			return
		end
		
		CCP.PlayerMenu.BusinessPane.CurrentItem = CCP.PlayerMenu.BusinessPane.CurrentItem + 1
		CCP.PlayerMenu.BusinessPane.IsGenerating = true
	end)
	
end

function nPopulateBusiness( len )
	
	GAMEMODE:PMPopulateBusiness();
	
end
net.Receive( "nPopulateBusiness", nPopulateBusiness );

function GM:PMCreateBusiness()
	
	local lic = LocalPlayer():BusinessLicenses();
	
	if( LocalPlayer():HasCharFlag( "X" ) ) then
		
		lic = lic + LICENSE_BLACK;
		
	end
	
	local y = CCP.PlayerMenu.ContentPane:GetTall() - 30;
	
	CCP.PlayerMenu.BusinessLicenses = { };
	
	for k, v in pairs( self.BusinessLicenses ) do
		
		if( v[2] ) then
			
			CCP.PlayerMenu.BusinessLicenses[k] = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
			CCP.PlayerMenu.BusinessLicenses[k]:SetFont( "CombineControl.LabelSmall" );
			CCP.PlayerMenu.BusinessLicenses[k]:SetText( v[1] .. " - " .. tostring( v[2] ) .. " dollars" );
			CCP.PlayerMenu.BusinessLicenses[k]:SetPos( 10, y );
			CCP.PlayerMenu.BusinessLicenses[k]:SetSize( 200, 20 );
			CCP.PlayerMenu.BusinessLicenses[k].Type = k;
			CCP.PlayerMenu.BusinessLicenses[k].Price = v[2];
			CCP.PlayerMenu.BusinessLicenses[k].DoClick = function( self )
				
				if( LocalPlayer():Money() >= self.Price ) then
					
					net.Start( "nBuyBusinessLicense" );
						net.WriteString( self.Type );
					net.SendToServer();
					
					self:SetDisabled( true );
					
				else
					
					GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You need more money to buy that license!", { CB_ALL, CB_IC } );
					
				end
				
			end
			CCP.PlayerMenu.BusinessLicenses[k]:PerformLayout();
			
			y = y - 30;
			
		end
		
	end
	
	local function PMBusinessFilter(str)
	
		local BusinessPanel = CCP.PlayerMenu.BusinessPane:GetChild(0); -- DScrollPanel consists of two panels by default: 0 - DPanel, 1 - ScrollBar.
		local ItemArr = BusinessPanel:GetChildren();
		
		for k, pnl in ipairs(ItemArr) do
			
			local ItemName = pnl.ItemName
			if str == "" or ItemName:lower():find(str:lower()) then
			
				pnl:Show();
				
			else
			
				pnl:Hide();
				
			end
			
		end
		
		local y = 0 -- reset panel positions
		for k, pnl in ipairs(ItemArr) do
			
			if pnl:IsVisible() then
				
				pnl:SetPos(0, y);
				y = y + 64;

			end
		
		end		
		
	end
	
	CCP.PlayerMenu.BusinessPane = vgui.Create( "DScrollPanel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.BusinessPane:SetSize( 570, 406 );
	CCP.PlayerMenu.BusinessPane:SetPos( 220, 10 );
	function CCP.PlayerMenu.BusinessPane:Paint( w, h )
		
		surface.SetDrawColor( 30, 30, 30, 255 );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( 20, 20, 20, 100 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
	end
	
	CCP.PlayerMenu.BusinessSearch = vgui.Create( "DTextEntry", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.BusinessSearch:SetPos( 10, 10 );
	CCP.PlayerMenu.BusinessSearch:SetSize( 200, 25 )
	CCP.PlayerMenu.BusinessSearch:SetText( "Search" )
	CCP.PlayerMenu.BusinessSearch:SetDisabled(true)
	CCP.PlayerMenu.BusinessSearch.OnEnter = function( self )
	
		PMBusinessFilter(self:GetValue());
		
	end
	CCP.PlayerMenu.BusinessSearch.Think = function( self )
		if !self.LastState and CCP.PlayerMenu.BusinessPane.IsGenerating then
			self:SetText("List is populating, please wait.")
		elseif self.LastState and !CCP.PlayerMenu.BusinessPane.IsGenerating then
			self:SetText("Search")
			self:SetDisabled(false)
		end
		
		self.LastState = CCP.PlayerMenu.BusinessPane.IsGenerating;
	end
	
	GAMEMODE:PMPopulateBusiness();
	
end

function GM:PMCreateSquadEdit( ply )
	
	CCP.CPPromotions.SquadEdit = vgui.Create( "DFrame" );
	CCP.CPPromotions.SquadEdit:SetSize( 250, 114 );
	CCP.CPPromotions.SquadEdit:Center();
	CCP.CPPromotions.SquadEdit:SetTitle( "Edit Squad" );
	CCP.CPPromotions.SquadEdit.lblTitle:SetFont( "CombineControl.Window" );
	CCP.CPPromotions.SquadEdit:MakePopup();
	CCP.CPPromotions.SquadEdit.PerformLayout = CCFramePerformLayout;
	CCP.CPPromotions.SquadEdit:PerformLayout();
	
	CCP.CPPromotions.SquadEdit.Entry = vgui.Create( "DTextEntry", CCP.CPPromotions.SquadEdit );
	CCP.CPPromotions.SquadEdit.Entry:SetFont( "CombineControl.LabelBig" );
	CCP.CPPromotions.SquadEdit.Entry:SetPos( 10, 34 );
	CCP.CPPromotions.SquadEdit.Entry:SetSize( 230, 30 );
	CCP.CPPromotions.SquadEdit.Entry:PerformLayout();
	CCP.CPPromotions.SquadEdit.Entry:RequestFocus();
	CCP.CPPromotions.SquadEdit.Entry:SetValue( ply.CombineSquad );
	CCP.CPPromotions.SquadEdit.Entry:SetCaretPos( string.len( CCP.CPPromotions.SquadEdit.Entry:GetValue() ) );
	
	CCP.CPPromotions.SquadEdit.OK = vgui.Create( "DButton", CCP.CPPromotions.SquadEdit );
	CCP.CPPromotions.SquadEdit.OK:SetFont( "CombineControl.LabelSmall" );
	CCP.CPPromotions.SquadEdit.OK:SetText( "OK" );
	CCP.CPPromotions.SquadEdit.OK:SetPos( 190, 74 );
	CCP.CPPromotions.SquadEdit.OK:SetSize( 50, 30 );
	function CCP.CPPromotions.SquadEdit.OK:DoClick()
		
		local val = CCP.CPPromotions.SquadEdit.Entry:GetValue();
		
		if( string.len( val ) > 10 ) then
			
			CCP.CPPromotions.SquadEdit:Remove();
			return;
			
		end
		
		CCP.CPPromotions.SquadEdit:Remove();
		
		net.Start( "nSetSquadOffline" );
			net.WriteString( ply.CharID );
			net.WriteString( ply.CombineFlag ); -- not good to trust the client with this lmao
			net.WriteString( val );
		net.SendToServer();
		
		GAMEMODE:PMRefreshCombinePromotions()
		
	end
	CCP.CPPromotions.SquadEdit.OK:PerformLayout();
	
	CCP.CPPromotions.SquadEdit.Entry.OnEnter = CCP.CPPromotions.SquadEdit.OK.DoClick;
	
end

function GM:PMCreateSquadIDEdit( ply )
	
	CCP.CPPromotions.SquadIDEdit = vgui.Create( "DFrame" );
	CCP.CPPromotions.SquadIDEdit:SetSize( 250, 114 );
	CCP.CPPromotions.SquadIDEdit:Center();
	CCP.CPPromotions.SquadIDEdit:SetTitle( "Edit Squad" );
	CCP.CPPromotions.SquadIDEdit.lblTitle:SetFont( "CombineControl.Window" );
	CCP.CPPromotions.SquadIDEdit:MakePopup();
	CCP.CPPromotions.SquadIDEdit.PerformLayout = CCFramePerformLayout;
	CCP.CPPromotions.SquadIDEdit:PerformLayout();
	
	CCP.CPPromotions.SquadIDEdit.Entry = vgui.Create( "DTextEntry", CCP.CPPromotions.SquadIDEdit );
	CCP.CPPromotions.SquadIDEdit.Entry:SetFont( "CombineControl.LabelBig" );
	CCP.CPPromotions.SquadIDEdit.Entry:SetPos( 10, 34 );
	CCP.CPPromotions.SquadIDEdit.Entry:SetSize( 230, 30 );
	CCP.CPPromotions.SquadIDEdit.Entry:PerformLayout();
	CCP.CPPromotions.SquadIDEdit.Entry:RequestFocus();
	CCP.CPPromotions.SquadIDEdit.Entry:SetNumeric( true );
	CCP.CPPromotions.SquadIDEdit.Entry:SetValue( ply.CombineSquadID );
	CCP.CPPromotions.SquadIDEdit.Entry:SetCaretPos( string.len( CCP.CPPromotions.SquadIDEdit.Entry:GetValue() ) );
	
	CCP.CPPromotions.SquadIDEdit.OK = vgui.Create( "DButton", CCP.CPPromotions.SquadIDEdit );
	CCP.CPPromotions.SquadIDEdit.OK:SetFont( "CombineControl.LabelSmall" );
	CCP.CPPromotions.SquadIDEdit.OK:SetText( "OK" );
	CCP.CPPromotions.SquadIDEdit.OK:SetPos( 190, 74 );
	CCP.CPPromotions.SquadIDEdit.OK:SetSize( 50, 30 );
	function CCP.CPPromotions.SquadIDEdit.OK:DoClick()
		
		local val = tonumber( CCP.CPPromotions.SquadIDEdit.Entry:GetValue() ) or 0;
		
		if( tonumber( val ) > 8 or tonumber( val ) < 0 ) then
			
			CCP.CPPromotions.SquadIDEdit:Remove();
			return;
			
		end
		
		CCP.CPPromotions.SquadIDEdit:Remove();
		
		net.Start( "nSetSquadIDOffline" );
			net.WriteString( ply.CharID );
			net.WriteString( ply.CombineFlag );
			net.WriteInt( tonumber( val ), 32 );
		net.SendToServer();
		
	end
	CCP.CPPromotions.SquadIDEdit.OK:PerformLayout();
	
	CCP.CPPromotions.SquadIDEdit.Entry.OnEnter = CCP.CPPromotions.SquadIDEdit.OK.DoClick;
	
end

function GM:PMRefreshCombinePromotions()
	
	if( !CCP or !CCP.CPPromotions or !CCP.CPPromotions:IsValid() or !CCP.CPPromotions.CPList or !CCP.CPPromotions.CPList:IsValid() ) then return end
	
	CCP.CPPromotions.CPList:Clear();
	CCP.CPPromotions.SelectedPlayer = nil;
	CCP.CPPromotions.PromoteBut:SetDisabled( true );
	CCP.CPPromotions.DemoteBut:SetDisabled( true );
	CCP.CPPromotions.EditSquadID:SetDisabled( true );
	CCP.CPPromotions.EditSquad:SetDisabled( true );
	
	net.Start( "nCPGetRosterList" );
	net.SendToServer();
	
end

function nRefreshCombinePromotions( len )
	
	GAMEMODE:PMRefreshCombinePromotions();
	
end
net.Receive( "nRefreshCombinePromotions", nRefreshCombinePromotions );

function GM:PMCreateCombinePromotions()
	
	CCP.CPPromotions = vgui.Create( "DFrame" );
	CCP.CPPromotions:SetSize( 800, 450 );
	CCP.CPPromotions:Center();
	CCP.CPPromotions:SetTitle( "SDPD-ARCS" );
	CCP.CPPromotions.lblTitle:SetFont( "CombineControl.Window" );
	CCP.CPPromotions:MakePopup();
	CCP.CPPromotions.PerformLayout = CCFramePerformLayout;
	CCP.CPPromotions:PerformLayout();
	
	CCP.CPPromotions.CPList = vgui.Create( "DListView", CCP.CPPromotions );
	CCP.CPPromotions.CPList:SetPos( 10, 34 );
	CCP.CPPromotions.CPList:SetSize( 780, 366 );
	CCP.CPPromotions.CPList:AddColumn( "Name" );
	CCP.CPPromotions.CPList:AddColumn( "Unit Name" );
	CCP.CPPromotions.CPList:AddColumn( "Squad" );
	CCP.CPPromotions.CPList:AddColumn( "Rank" );
	CCP.CPPromotions.CPList:AddColumn( "Last Active" );
	
	CCP.CPPromotions.SelectedPlayer = nil;
	
	function CCP.CPPromotions.CPList:OnRowSelected( id, line )
		
		CCP.CPPromotions.SelectedPlayer = line;
		CCP.CPPromotions.PromoteBut:SetDisabled( false );
		CCP.CPPromotions.DemoteBut:SetDisabled( false );
		CCP.CPPromotions.EditSquadID:SetDisabled( false );
		CCP.CPPromotions.EditSquad:SetDisabled( false );
		
	end
	
	CCP.CPPromotions.PromoteBut = vgui.Create( "DButton", CCP.CPPromotions );
	CCP.CPPromotions.PromoteBut:SetFont( "CombineControl.LabelSmall" );
	CCP.CPPromotions.PromoteBut:SetText( "Promote" );
	CCP.CPPromotions.PromoteBut:SetPos( 690, 410 );
	CCP.CPPromotions.PromoteBut:SetSize( 100, 30 );
	function CCP.CPPromotions.PromoteBut:DoClick()
	
		local s = CCP.CPPromotions.SelectedPlayer.SteamID;
		local c = CCP.CPPromotions.SelectedPlayer.CharID;
		local f = CCP.CPPromotions.SelectedPlayer.CombineFlag; -- you know this is bad security
		local flag = GAMEMODE:LookupCombineFlag( f );
		
		if( flag and flag.PromoteTo ) then
			
			net.Start( "nPromoteRecruit" );
				net.WriteString( s );
				net.WriteString( c );
				net.WriteString( f );
			net.SendToServer();
			
			GAMEMODE:PMRefreshCombinePromotions()
			
		end
		
	end
	CCP.CPPromotions.PromoteBut:SetDisabled( true );
	CCP.CPPromotions.PromoteBut:PerformLayout();
	
	CCP.CPPromotions.DemoteBut = vgui.Create( "DButton", CCP.CPPromotions );
	CCP.CPPromotions.DemoteBut:SetFont( "CombineControl.LabelSmall" );
	CCP.CPPromotions.DemoteBut:SetText( "Demote" );
	CCP.CPPromotions.DemoteBut:SetPos( 580, 410 );
	CCP.CPPromotions.DemoteBut:SetSize( 100, 30 );
	function CCP.CPPromotions.DemoteBut:DoClick()
		
		local s = CCP.CPPromotions.SelectedPlayer.SteamID;
		local c = CCP.CPPromotions.SelectedPlayer.CharID;
		local f = CCP.CPPromotions.SelectedPlayer.CombineFlag;
		local flag = GAMEMODE:LookupCombineFlag( CCP.CPPromotions.SelectedPlayer.CombineFlag );
		
		if( flag and flag.DemoteTo ) then

			net.Start( "nDemoteUnit" );
				net.WriteString( s );
				net.WriteString( c );
				net.WriteString( f );
			net.SendToServer();
			
			GAMEMODE:PMRefreshCombinePromotions()
			
		end
		
	end
	CCP.CPPromotions.DemoteBut:SetDisabled( true );
	CCP.CPPromotions.DemoteBut:PerformLayout();
	
	CCP.CPPromotions.EditSquadID = vgui.Create( "DButton", CCP.CPPromotions );
	CCP.CPPromotions.EditSquadID:SetFont( "CombineControl.LabelSmall" );
	CCP.CPPromotions.EditSquadID:SetText( "Edit Squad ID" );
	CCP.CPPromotions.EditSquadID:SetPos( 470, 410 );
	CCP.CPPromotions.EditSquadID:SetSize( 100, 30 );
	function CCP.CPPromotions.EditSquadID:DoClick()
		
		GAMEMODE:PMCreateSquadIDEdit( CCP.CPPromotions.SelectedPlayer );
		
	end
	CCP.CPPromotions.EditSquadID:SetDisabled( true );
	CCP.CPPromotions.EditSquadID:PerformLayout();
	
	CCP.CPPromotions.EditSquad = vgui.Create( "DButton", CCP.CPPromotions );
	CCP.CPPromotions.EditSquad:SetFont( "CombineControl.LabelSmall" );
	CCP.CPPromotions.EditSquad:SetText( "Edit Squad" );
	CCP.CPPromotions.EditSquad:SetPos( 360, 410 );
	CCP.CPPromotions.EditSquad:SetSize( 100, 30 );
	function CCP.CPPromotions.EditSquad:DoClick()
		
		GAMEMODE:PMCreateSquadEdit( CCP.CPPromotions.SelectedPlayer );
		
	end
	CCP.CPPromotions.EditSquad:SetDisabled( true );
	CCP.CPPromotions.EditSquad:PerformLayout();
	
	self:PMRefreshCombinePromotions();
	
end

function GM:PMCreateCombineLoans()
	
	CCP.CPLoans = vgui.Create( "DFrame" );
	CCP.CPLoans:SetSize( 800, 450 );
	CCP.CPLoans:Center();
	CCP.CPLoans:SetTitle( "ARCS Financial Aid" );
	CCP.CPLoans.lblTitle:SetFont( "CombineControl.Window" );
	CCP.CPLoans:MakePopup();
	CCP.CPLoans.PerformLayout = CCFramePerformLayout;
	CCP.CPLoans:PerformLayout();
	
	CCP.CPLoans.List = vgui.Create( "DListView", CCP.CPLoans );
	CCP.CPLoans.List:SetPos( 10, 34 );
	CCP.CPLoans.List:SetSize( 780, 400 - 34 );
	CCP.CPLoans.List:AddColumn( "ID Number" );
	CCP.CPLoans.List:AddColumn( "Name" );
	CCP.CPLoans.List:AddColumn( "Amount Owing" );
	function CCP.CPLoans.List:OnRowSelected( id, line )
		
		local flag = GAMEMODE:LookupCombineFlag( LocalPlayer():CombineFlag() );
		if( !flag or !flag.CanEditLoans ) then return end
		
		CCP.CPLoans.EditLoan:SetDisabled( false );
		CCP.CPLoans.SelectedPlayer = line.Player;
		
	end
	
	for _, v in pairs( player.GetAll() ) do
		
		if( !v:HasAnyCombineFlag() and v:Loan() > 0 ) then
			
			CCP.CPLoans.List:AddLine( v:FormattedCID(), v:VisibleRPName(), "$" .. v:Loan()).Player = v;
			
		end
		
	end
	
	CCP.CPLoans.EditLoan = vgui.Create( "DButton", CCP.CPLoans );
	CCP.CPLoans.EditLoan:SetFont( "CombineControl.LabelSmall" );
	CCP.CPLoans.EditLoan:SetText( "Edit Loan" );
	CCP.CPLoans.EditLoan:SetPos( 10, 410 );
	CCP.CPLoans.EditLoan:SetSize( 100, 30 );
	function CCP.CPLoans.EditLoan:DoClick()
		
		GAMEMODE:PMCreateCombineEditLoan();
		
	end
	CCP.CPLoans.EditLoan:SetDisabled( true );
	CCP.CPLoans.EditLoan:PerformLayout();
	
end

function GM:PMCreateCombineEditLoan()
	
	if( CCP.CPLoans.Loan and CCP.CPLoans.Loan:IsValid() ) then
		
		CCP.CPLoans.Loan:Remove();
		
	end
	
	if( CCP.CPLoans.SelectedPlayer and CCP.CPLoans.SelectedPlayer:IsValid() ) then
		
		CCP.CPLoans.Loan = vgui.Create( "DFrame" );
		CCP.CPLoans.Loan:SetSize( 250, 114 );
		CCP.CPLoans.Loan:Center();
		CCP.CPLoans.Loan:SetTitle( "Deduct Loan" );
		CCP.CPLoans.Loan.lblTitle:SetFont( "CombineControl.Window" );
		CCP.CPLoans.Loan:MakePopup();
		CCP.CPLoans.Loan.PerformLayout = CCFramePerformLayout;
		CCP.CPLoans.Loan:PerformLayout();
		CCP.CPLoans.Loan.Player = CCP.CPLoans.SelectedPlayer;
		
		CCP.CPLoans.Loan.Entry = vgui.Create( "DTextEntry", CCP.CPLoans.Loan );
		CCP.CPLoans.Loan.Entry:SetFont( "CombineControl.LabelBig" );
		CCP.CPLoans.Loan.Entry:SetPos( 10, 34 );
		CCP.CPLoans.Loan.Entry:SetSize( 100, 30 );
		CCP.CPLoans.Loan.Entry:PerformLayout();
		CCP.CPLoans.Loan.Entry:RequestFocus();
		CCP.CPLoans.Loan.Entry:SetNumeric( true );
		CCP.CPLoans.Loan.Entry:SetCaretPos( string.len( CCP.CPLoans.Loan.Entry:GetValue() ) );
		
		CCP.CPLoans.Loan.Label = vgui.Create( "DLabel", CCP.CPLoans.Loan );
		CCP.CPLoans.Loan.Label:SetText( "Dollars" );
		CCP.CPLoans.Loan.Label:SetPos( 120, 34 );
		CCP.CPLoans.Loan.Label:SetSize( 130, 30 );
		CCP.CPLoans.Loan.Label:SetFont( "CombineControl.LabelBig" );
		CCP.CPLoans.Loan.Label:PerformLayout();
		
		CCP.CPLoans.Loan.OK = vgui.Create( "DButton", CCP.CPLoans.Loan );
		CCP.CPLoans.Loan.OK:SetFont( "CombineControl.LabelSmall" );
		CCP.CPLoans.Loan.OK:SetText( "OK" );
		CCP.CPLoans.Loan.OK:SetPos( 190, 74 );
		CCP.CPLoans.Loan.OK:SetSize( 50, 30 );
		function CCP.CPLoans.Loan.OK:DoClick()
			
			if( !CCP.CPLoans.Loan.Player or !CCP.CPLoans.Loan.Player:IsValid() ) then
				
				CCP.CPLoans.Loan:Remove();
				return;
				
			end
			
			local val = tonumber( CCP.CPLoans.Loan.Entry:GetValue() );
			
			if( !val ) then
				
				CCP.CPLoans.Loan:Remove();
				return;
				
			end
			
			val = math.Round( val );
			
			if( val < 1 ) then
				
				CCP.CPLoans.Loan:Remove();
				return;
				
			end
			
			if( CCP.CPLoans.Loan.Player:Loan() - val >= 0 ) then
				
				CCP.CPLoans.Loan:Remove();
				
				if( CCP.CPLoans.List ) then
					
					CCP.CPLoans.List:Clear();
					
					for _, v in pairs( player.GetAll() ) do
						
						local loan = v:Loan();
						
						if( v == CCP.CPLoans.Loan.Player ) then
							
							loan = loan - val;
							
							if( loan <= 0 ) then
								
								if( CCP.CPLoans and CCP.CPLoans.EditLoan ) then
									
									CCP.CPLoans.EditLoan:SetDisabled( true );
									
								end
								
							end
							
						end
						
						if( !v:HasAnyCombineFlag() and loan > 0 ) then
							
							CCP.CPLoans.List:AddLine( v:FormattedCID(), v:VisibleRPName(), "$" .. loan ).Player = v;
							
						end
						
					end
					
				end
				
				net.Start( "nDeductLoan" );
					net.WriteEntity( CCP.CPLoans.Loan.Player );
					net.WriteUInt( val, 32 );
				net.SendToServer();
				
			else
				
				GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "They don't have that large a loan.", { CB_ALL, CB_OOC } );
				
			end
			
		end
		CCP.CPLoans.Loan.OK:PerformLayout();
		
		CCP.CPLoans.Loan.Entry.OnEnter = CCP.CPLoans.Loan.OK.DoClick;
		
	end
	
end

function nLoanDeducted( len )
	
	local ply = net.ReadEntity();
	local amt = net.ReadUInt( 32 );
	
	GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", ply:VisibleRPName() .. " reduced your loan by " .. amt .. " dollars.", { CB_ALL, CB_IC } );
	
end
net.Receive( "nLoanDeducted", nLoanDeducted );

function nRefreshSqL( len )
	
	if( CCP.CPPromotions and CCP.CPPromotions:IsValid() ) then
		
		CCP.CPPromotions.CPList:Clear();
		
		for _, v in pairs( player.GetAll() ) do
			
			local flag = GAMEMODE:LookupCombineFlag( v:CombineFlag() );
			if( flag and flag.PromoteTo ) then
				
				CCP.CPPromotions.CPList:AddLine( v:SteamID(), v:VisibleRPName(), v:CombineAppDate() );
				
			end
			
		end
		
	end
	
	if( CCP.CPDemotions and CCP.CPDemotions:IsValid() ) then
		
		CCP.CPDemotions.CPList:Clear();
		
		for _, v in pairs( player.GetAll() ) do
			
			local flag = GAMEMODE:LookupCombineFlag( v:CombineFlag() );
			if( flag and flag.DemoteTo ) then
				
				CCP.CPDemotions.CPList:AddLine( v:SteamID(), v:VisibleRPName(), v:CombineAppDate() );
				
			end
			
		end
		
	end
	
end
net.Receive( "nRefreshSqL", nRefreshSqL );

local function nReceiveCombineHousingDoors()
	
	CCP.CombineHousingEdit.Doors:Clear();
	CCP.CombineHousingEdit.Unassigned:Clear();
	CCP.CombineHousingEdit.Assigned:Clear();
	
	local n = net.ReadUInt( 10 );
	
	if( CCP.CombineHousingEdit and n > 0 ) then
		
		for i = 1, n do
			
			local str = net.ReadString();
			local id = net.ReadUInt( 16 );
			local num = net.ReadUInt( 6 );
			
			local l = CCP.CombineHousingEdit.Doors:AddLine( str );
			l.EntIndex = id;
			l.Players = { };
			
			if( num > 0 ) then
				
				for j = 1, num do
					
					table.insert( l.Players, net.ReadEntity() );
					
				end
				
			end
			
		end
		
	end
	
end
net.Receive( "nReceiveCombineHousingDoors", nReceiveCombineHousingDoors );

function GM:PMCreateCombineHousing()
	
	CCP.CombineHousingEdit = vgui.Create( "DFrame" );
	CCP.CombineHousingEdit:SetSize( 595, 504 );
	CCP.CombineHousingEdit:Center();
	CCP.CombineHousingEdit:SetTitle( "Manage Section 8 Housing" );
	CCP.CombineHousingEdit.lblTitle:SetFont( "CombineControl.Window" );
	CCP.CombineHousingEdit:MakePopup();
	CCP.CombineHousingEdit.PerformLayout = CCFramePerformLayout;
	CCP.CombineHousingEdit:PerformLayout();
	
	CCP.CombineHousingEdit.Doors = vgui.Create( "DListView", CCP.CombineHousingEdit );
	CCP.CombineHousingEdit.Doors:SetPos( 10, 34 );
	CCP.CombineHousingEdit.Doors:SetSize( 185, 430 );
	CCP.CombineHousingEdit.Doors:AddColumn( "Apartments" );
	
	net.Start( "nRequestCombineHousingDoors" );
	net.SendToServer();
	
	function CCP.CombineHousingEdit.Doors:OnRowSelected( id, line )
		
		CCP.CombineHousingEdit.Unassigned:Clear();
		CCP.CombineHousingEdit.Assigned:Clear();
		
		for _, v in pairs( player.GetAll() ) do
			
			if( !v:HasAnyCombineFlag() ) then
				
				if( !table.HasValue( line.Players, v ) ) then
					
					CCP.CombineHousingEdit.Unassigned:AddLine( v:VisibleRPName() ).Player = v;
					
				else
					
					CCP.CombineHousingEdit.Assigned:AddLine( v:VisibleRPName() ).Player = v;
					
				end
				
			end
			
		end
		
	end
	
	CCP.CombineHousingEdit.Unassigned = vgui.Create( "DListView", CCP.CombineHousingEdit );
	CCP.CombineHousingEdit.Unassigned:SetPos( 205, 34 );
	CCP.CombineHousingEdit.Unassigned:SetSize( 185, 430 );
	CCP.CombineHousingEdit.Unassigned:AddColumn( "Unassigned" );
	
	CCP.CombineHousingEdit.Assigned = vgui.Create( "DListView", CCP.CombineHousingEdit );
	CCP.CombineHousingEdit.Assigned:SetPos( 400, 34 );
	CCP.CombineHousingEdit.Assigned:SetSize( 185, 430 );
	CCP.CombineHousingEdit.Assigned:AddColumn( "Assigned" );
	
	CCP.CombineHousingEdit.AssignCitizen = vgui.Create( "DButton", CCP.CombineHousingEdit );
	CCP.CombineHousingEdit.AssignCitizen:SetFont( "CombineControl.LabelSmall" );
	CCP.CombineHousingEdit.AssignCitizen:SetText( ">" );
	CCP.CombineHousingEdit.AssignCitizen:SetPos( 205, 474 );
	CCP.CombineHousingEdit.AssignCitizen:SetSize( 185, 20 );
	function CCP.CombineHousingEdit.AssignCitizen:DoClick()
		
		if( CCP.CombineHousingEdit.Unassigned:GetSelected()[1] ) then
			
			local door = CCP.CombineHousingEdit.Doors:GetSelected()[1].EntIndex;
			local ply = CCP.CombineHousingEdit.Unassigned:GetSelected()[1].Player;
			
			net.Start( "nCAssignOwner" );
				net.WriteUInt( door, 16 );
				net.WriteEntity( ply );
			net.SendToServer();
			
			CCP.CombineHousingEdit.Unassigned:RemoveLine( CCP.CombineHousingEdit.Unassigned:GetSelected()[1]:GetID() );
			CCP.CombineHousingEdit.Assigned:AddLine( ply:VisibleRPName() ).Player = ply;
			
			table.insert( CCP.CombineHousingEdit.Doors:GetSelected()[1].Players, ply );
			
		end
		
	end
	CCP.CombineHousingEdit.AssignCitizen:PerformLayout();
	
	CCP.CombineHousingEdit.UnassignCitizen = vgui.Create( "DButton", CCP.CombineHousingEdit );
	CCP.CombineHousingEdit.UnassignCitizen:SetFont( "CombineControl.LabelSmall" );
	CCP.CombineHousingEdit.UnassignCitizen:SetText( "<" );
	CCP.CombineHousingEdit.UnassignCitizen:SetPos( 400, 474 );
	CCP.CombineHousingEdit.UnassignCitizen:SetSize( 185, 20 );
	function CCP.CombineHousingEdit.UnassignCitizen:DoClick()
		
		if( CCP.CombineHousingEdit.Assigned:GetSelected()[1] ) then
			
			local door = CCP.CombineHousingEdit.Doors:GetSelected()[1].EntIndex;
			local ply = CCP.CombineHousingEdit.Assigned:GetSelected()[1].Player;
			
			net.Start( "nCUnassignOwner" );
				net.WriteUInt( door, 16 );
				net.WriteEntity( ply );
			net.SendToServer();
			
			CCP.CombineHousingEdit.Assigned:RemoveLine( CCP.CombineHousingEdit.Assigned:GetSelected()[1]:GetID() );
			CCP.CombineHousingEdit.Unassigned:AddLine( ply:VisibleRPName() ).Player = ply;
			
			for k, v in pairs( CCP.CombineHousingEdit.Doors:GetSelected()[1].Players ) do
				
				if( v == ply ) then
					
					table.remove( CCP.CombineHousingEdit.Doors:GetSelected()[1].Players, k );
					
				end
				
			end
			
		end
		
	end
	CCP.CombineHousingEdit.UnassignCitizen:PerformLayout();
	
end

function GM:PMCreateCombineRoster()
	
	CCP.CombineRoster = vgui.Create( "DFrame" );
	CCP.CombineRoster:SetSize( 690, 500 );
	CCP.CombineRoster:Center();
	CCP.CombineRoster:SetTitle( "ARCS Roster" );
	CCP.CombineRoster.lblTitle:SetFont( "CombineControl.Window" );
	CCP.CombineRoster:MakePopup();
	CCP.CombineRoster.PerformLayout = CCFramePerformLayout;
	CCP.CombineRoster:PerformLayout();
	
	CCP.CombineRoster.Roster = vgui.Create( "DListView", CCP.CombineRoster );
	CCP.CombineRoster.Roster:SetPos( 10, 34 );
	CCP.CombineRoster.Roster:SetSize( 670, 406 );
	CCP.CombineRoster.Roster:AddColumn( "Name" );
	CCP.CombineRoster.Roster:AddColumn( "Unit Name" );
	CCP.CombineRoster.Roster:AddColumn( "Squad" );
	CCP.CombineRoster.Roster:AddColumn( "Rank" );
	CCP.CombineRoster.Roster:AddColumn( "Last Active" );
	
	function CCP.CombineRoster.Roster:OnRowSelected( id, line )
		
		CCP.CombineRoster.SelectedID = id;
		
		local flag = GAMEMODE:LookupCombineFlag( LocalPlayer():CombineFlag() );
		if( flag and flag.CanEditCPs and ( line.TimeSince > 60 * 24 * 7 or line.TimeSince == 0 ) ) then
			
			CCP.CombineRoster.PKBut:SetDisabled( false );
			
		else
			
			CCP.CombineRoster.PKBut:SetDisabled( true );
			
		end
		
	end
	
	CCP.CombineRoster.Roster:AddLine( "Loading...", "", "", "", "" );
	
	CCP.CombineRoster.PKBut = vgui.Create( "DButton", CCP.CombineRoster );
	CCP.CombineRoster.PKBut:SetFont( "CombineControl.LabelSmall" );
	CCP.CombineRoster.PKBut:SetText( "Inactivity PK" );
	CCP.CombineRoster.PKBut:SetPos( 10, 460 );
	CCP.CombineRoster.PKBut:SetSize( 100, 30 );
	CCP.CombineRoster.PKBut.DoClick = function( self )
		
		local line = CCP.CombineRoster.Roster:GetLine( CCP.CombineRoster.SelectedID );
		
		net.Start( "nCPPK" );
			net.WriteUInt( line.CharID, 32 );
			net.WriteString( line.CharName );
		net.SendToServer();
		
		CCP.CombineRoster.Roster:RemoveLine( line:GetID() );
		
	end
	CCP.CombineRoster.PKBut:PerformLayout();
	CCP.CombineRoster.PKBut:SetDisabled( true );
	
	net.Start( "nCPGetRosterList" );
	net.SendToServer();
	
end

function nCPRosterList( len )
	
	local tab = net.ReadTable();
	
	if( CCP.CombineRoster and CCP.CombineRoster.Roster and CCP.CombineRoster.Roster:IsValid() ) then
		
		CCP.CombineRoster.Roster:Clear();
		
		for k, v in pairs( tab ) do
			
			local line = CCP.CombineRoster.Roster:AddLine( v[1], GAMEMODE:CPName( v[1], v[2], v[3], v[4], GAMEMODE:LookupCombineFlag( v[5] ) ), v[2], GAMEMODE:FlagPrintName( v[5] ), v[6] );
			line.CharID = v[7];
			line.CharName = GAMEMODE:CPName( v[1], v[2], v[3], v[4], GAMEMODE:LookupCombineFlag( v[5] ) )
			line.TimeSince = v[8];
			line.NoSquad = ( v[2] == "" );
			
		end
		
	end
	
	if( CCP.CPPromotions.CPList and !CCP.CombineRoster and CCP.CPPromotions.CPList:IsValid() ) then
	
		CCP.CPPromotions.CPList:Clear();
		
		for k,v in next, tab do
		
			if( !GAMEMODE:LookupCombineFlag( LocalPlayer():CombineFlag() ).EditableRanks[v[5]] ) then continue end;
		
			local line = CCP.CPPromotions.CPList:AddLine( v[1], GAMEMODE:CPName( v[1], v[2], v[3], v[4], GAMEMODE:LookupCombineFlag( v[5] ) ), v[2], GAMEMODE:FlagPrintName( v[5] ), v[6] );
			line.CharID = v[7];
			line.CombineFlag = v[5];
			line.SteamID = v[9];
			line.CombineSquadID = v[3];
			line.CombineSquad = v[2];
			line.CharName = GAMEMODE:CPName( v[1], v[2], v[3], v[4], GAMEMODE:LookupCombineFlag( v[5] ) );
			line.TimeSince = v[8];
			line.NoSquad = ( v[2] == "" );
			
		end
	
	end
	
	timer.Simple( 0.01, function()
		
		if( CCP.CombineRoster and CCP.CombineRoster.Roster and CCP.CombineRoster.Roster.VBar and CCP.CombineRoster.Roster.VBar:IsValid() ) then
			
			CCP.CombineRoster.Roster.VBar:SetScroll( math.huge );
			
		end
		
		if( CCP.CPPromotions and CCP.CPPromotions.CPList and CCP.CPPromotions.CPList.VBar and CCP.CPPromotions.CPList.VBar:IsValid() ) then
		
			CCP.CPPromotions.CPList.VBar:SetScroll( math.huge );
		
		end
		
	end );
	
end
net.Receive( "nCPRosterList", nCPRosterList );

function GM:PMCreateCombineRecords()
	
	CCP.CombineRecords = vgui.Create( "DFrame" );
	CCP.CombineRecords:SetSize( 490, 480 );
	CCP.CombineRecords:Center();
	CCP.CombineRecords:SetTitle( "Criminal Records" );
	CCP.CombineRecords.lblTitle:SetFont( "CombineControl.Window" );
	CCP.CombineRecords:MakePopup();
	CCP.CombineRecords.PerformLayout = CCFramePerformLayout;
	CCP.CombineRecords:PerformLayout();
	
	CCP.CombineRecords.Records = vgui.Create( "DListView", CCP.CombineRecords );
	CCP.CombineRecords.Records:SetPos( 10, 34 );
	CCP.CombineRecords.Records:SetSize( 470, 406 );
	CCP.CombineRecords.Records:AddColumn( "ID Number" );
	CCP.CombineRecords.Records:AddColumn( "Name" );
	
	function CCP.CombineRecords.Records:OnRowSelected( id, line )
		
		CCP.CombineRecords.ViewRecord:SetDisabled( false );
		CCP.CombineRecords.EditRecord:SetDisabled( false );
		
	end
	
	for k, v in pairs( player.GetAll() ) do
		
		if( !v:HasAnyCombineFlag() ) then
			
			CCP.CombineRecords.Records:AddLine( v:FormattedCID(), v:VisibleRPName() ).Player = v;
			
		end
		
	end
	
	CCP.CombineRecords.ViewRecord = vgui.Create( "DButton", CCP.CombineRecords );
	CCP.CombineRecords.ViewRecord:SetFont( "CombineControl.LabelSmall" );
	CCP.CombineRecords.ViewRecord:SetText( "View Record" );
	CCP.CombineRecords.ViewRecord:SetPos( 10, 450 );
	CCP.CombineRecords.ViewRecord:SetSize( 100, 20 );
	function CCP.CombineRecords.ViewRecord:DoClick()
		
		if( CCP.CombineRecords.Records:GetSelected()[1] and CCP.CombineRecords.Records:GetSelected()[1].Player and CCP.CombineRecords.Records:GetSelected()[1].Player:IsValid() ) then
			
			if( CCP.CriminalRecord and CCP.CriminalRecord:IsValid() ) then
				
				CCP.CriminalRecord:Remove();
				
			end
			
			CCP.CriminalRecord = vgui.Create( "DFrame" );
			CCP.CriminalRecord:SetSize( 490, 250 );
			CCP.CriminalRecord:Center();
			CCP.CriminalRecord:SetTitle( CCP.CombineRecords.Records:GetSelected()[1].Player:VisibleRPName() );
			CCP.CriminalRecord.lblTitle:SetFont( "CombineControl.Window" );
			CCP.CriminalRecord:MakePopup();
			CCP.CriminalRecord.PerformLayout = CCFramePerformLayout;
			CCP.CriminalRecord:PerformLayout();
			
			CCP.CriminalRecord.Pane = vgui.Create( "DScrollPanel", CCP.CriminalRecord );
			CCP.CriminalRecord.Pane:SetSize( 470, 206 );
			CCP.CriminalRecord.Pane:SetPos( 10, 34 );
			function CCP.CriminalRecord.Pane:Paint( w, h ) end
			
			local text = vgui.Create( "DLabel" );
			text:SetText( CCP.CombineRecords.Records:GetSelected()[1].Player:CriminalRecord() );
			text:SetPos( 0, 0 );
			text:SetSize( 470, 14 );
			text:SetFont( "CombineControl.LabelSmall" );
			text:PerformLayout();
			text:SetWrap( true );
			text:SetAutoStretchVertical( true );
			
			CCP.CriminalRecord.Pane:Add( text );
			
		end
		
	end
	CCP.CombineRecords.ViewRecord:PerformLayout();
	CCP.CombineRecords.ViewRecord:SetDisabled( true );
	
	CCP.CombineRecords.EditRecord = vgui.Create( "DButton", CCP.CombineRecords );
	CCP.CombineRecords.EditRecord:SetFont( "CombineControl.LabelSmall" );
	CCP.CombineRecords.EditRecord:SetText( "Edit Record" );
	CCP.CombineRecords.EditRecord:SetPos( 120, 450 );
	CCP.CombineRecords.EditRecord:SetSize( 100, 20 );
	function CCP.CombineRecords.EditRecord:DoClick()
		
		if( CCP.CombineRecords.Records:GetSelected()[1] and CCP.CombineRecords.Records:GetSelected()[1].Player and CCP.CombineRecords.Records:GetSelected()[1].Player:IsValid() ) then
			
			if( CCP.CriminalRecord and CCP.CriminalRecord:IsValid() ) then
				
				CCP.CriminalRecord:Remove();
				
			end
			
			CCP.CriminalRecord = vgui.Create( "DFrame" );
			CCP.CriminalRecord:SetSize( 490, 280 );
			CCP.CriminalRecord:Center();
			CCP.CriminalRecord:SetTitle( CCP.CombineRecords.Records:GetSelected()[1].Player:VisibleRPName() );
			CCP.CriminalRecord.lblTitle:SetFont( "CombineControl.Window" );
			CCP.CriminalRecord:MakePopup();
			CCP.CriminalRecord.PerformLayout = CCFramePerformLayout;
			CCP.CriminalRecord:PerformLayout();
			
			CCP.CriminalRecord.Entry = vgui.Create( "DTextEntry", CCP.CriminalRecord );
			CCP.CriminalRecord.Entry:SetValue( CCP.CombineRecords.Records:GetSelected()[1].Player:CriminalRecord() );
			CCP.CriminalRecord.Entry:SetFont( "CombineControl.LabelSmall" );
			CCP.CriminalRecord.Entry:SetPos( 10, 34 );
			CCP.CriminalRecord.Entry:SetSize( 470, 206 );
			CCP.CriminalRecord.Entry:SetMultiline( true );
			CCP.CriminalRecord.Entry:PerformLayout();
			CCP.CriminalRecord.Entry:RequestFocus();
			CCP.CriminalRecord.Entry:SetCaretPos( string.len( CCP.CriminalRecord.Entry:GetValue() ) );
			
			CCP.CriminalRecord.OK = vgui.Create( "DButton", CCP.CriminalRecord );
			CCP.CriminalRecord.OK:SetFont( "CombineControl.LabelSmall" );
			CCP.CriminalRecord.OK:SetText( "OK" );
			CCP.CriminalRecord.OK:SetPos( 360, 250 );
			CCP.CriminalRecord.OK:SetSize( 100, 20 );
			CCP.CriminalRecord.OK.Player = CCP.CombineRecords.Records:GetSelected()[1].Player;
			function CCP.CriminalRecord.OK:DoClick()
				
				if( !self.Player or !self.Player:IsValid() ) then return end
				
				local val = CCP.CriminalRecord.Entry:GetValue();
				
				CCP.CriminalRecord:Remove();
				
				net.Start( "nUpdateRecord" );
					net.WriteString( string.sub( val, 1, 1024 ) );
					net.WriteEntity( self.Player );
				net.SendToServer();
				
			end
			CCP.CriminalRecord.OK:PerformLayout();
			
		end
		
	end
	CCP.CombineRecords.EditRecord:PerformLayout();
	CCP.CombineRecords.EditRecord:SetDisabled( true );
	
end

function GM:PMUpdateCombinePrison()
	
	if( !CCP.CombinePrison or !CCP.CombinePrison:IsValid() ) then return end
	
	for _, v in pairs( CCP.CombinePrison.Prisoners:GetLines() ) do
		
		local d = math.max( math.ceil( v.Player:PrisonReleaseTime() - CurTime() ), 0 );
		
		local column = v:SetColumnText( 2, string.ToMinutesSeconds( d ) );
		
		if( d <= 0 ) then
			
			column:SetTextColor( Color( 200, 0, 0, 255 ) );
			
		else
			
			column:SetTextColor( Color( 200, 200, 200, 255 ) );
			
		end
		
	end
	
end

function GM:PMCreateCombinePrison()
	
	CCP.CombinePrison = vgui.Create( "DFrame" );
	CCP.CombinePrison:SetSize( 600, 504 );
	CCP.CombinePrison:Center();
	CCP.CombinePrison:SetTitle( "Prison Management" );
	CCP.CombinePrison.lblTitle:SetFont( "CombineControl.Window" );
	CCP.CombinePrison:MakePopup();
	CCP.CombinePrison.PerformLayout = CCFramePerformLayout;
	CCP.CombinePrison:PerformLayout();
	
	CCP.CombinePrison.AllPlayers = vgui.Create( "DListView", CCP.CombinePrison );
	CCP.CombinePrison.AllPlayers:SetPos( 10, 34 );
	CCP.CombinePrison.AllPlayers:SetSize( 200, 430 );
	CCP.CombinePrison.AllPlayers:AddColumn( "Citizen" );
	
	for k, v in pairs( player.GetAll() ) do
		
		if( !v:HasAnyCombineFlag() and v:PrisonReleaseTime() == 0 ) then
			
			CCP.CombinePrison.AllPlayers:AddLine( v:VisibleRPName() ).Player = v;
			
		end
		
	end
	
	CCP.CombinePrison.Prisoners = vgui.Create( "DListView", CCP.CombinePrison );
	CCP.CombinePrison.Prisoners:SetPos( 220, 34 );
	CCP.CombinePrison.Prisoners:SetSize( 370, 430 );
	CCP.CombinePrison.Prisoners:AddColumn( "Prisoner" );
	CCP.CombinePrison.Prisoners:AddColumn( "Time Remaining" );
	CCP.CombinePrison.Prisoners:AddColumn( "Reason" );
	CCP.CombinePrison.Prisoners:AddColumn( "Arresting Officer" );
	
	for k, v in pairs( player.GetAll() ) do
		
		if( !v:HasAnyCombineFlag() and v:PrisonReleaseTime() > 0 ) then
			
			CCP.CombinePrison.Prisoners:AddLine( v:VisibleRPName(), string.ToMinutesSeconds( math.max( v:PrisonReleaseTime() - CurTime(), 0 ) ), v:PrisonReason(), v:Arrester() ).Player = v;
			
		end
		
	end
	
	CCP.CombinePrison.Imprison = vgui.Create( "DButton", CCP.CombinePrison );
	CCP.CombinePrison.Imprison:SetFont( "CombineControl.LabelSmall" );
	CCP.CombinePrison.Imprison:SetText( ">" );
	CCP.CombinePrison.Imprison:SetPos( 10, 474 );
	CCP.CombinePrison.Imprison:SetSize( 200, 20 );
	function CCP.CombinePrison.Imprison:DoClick()
		
		if( !CCP.CombinePrison.AllPlayers:GetSelected()[1] ) then return end
		
		local ply = CCP.CombinePrison.AllPlayers:GetSelected()[1].Player;
		
		if( ply and ply:IsValid() ) then
			
			CCP.CombinePrison.JailPlayer = vgui.Create( "DFrame" );
			CCP.CombinePrison.JailPlayer:SetSize( 250, 154 );
			CCP.CombinePrison.JailPlayer:Center();
			CCP.CombinePrison.JailPlayer:SetTitle( "Imprison Citizen" );
			CCP.CombinePrison.JailPlayer.lblTitle:SetFont( "CombineControl.Window" );
			CCP.CombinePrison.JailPlayer:MakePopup();
			CCP.CombinePrison.JailPlayer.PerformLayout = CCFramePerformLayout;
			CCP.CombinePrison.JailPlayer:PerformLayout();
			
			CCP.CombinePrison.JailPlayer.Entry = vgui.Create( "DTextEntry", CCP.CombinePrison.JailPlayer );
			CCP.CombinePrison.JailPlayer.Entry:SetFont( "CombineControl.LabelBig" );
			CCP.CombinePrison.JailPlayer.Entry:SetPos( 10, 34 );
			CCP.CombinePrison.JailPlayer.Entry:SetSize( 100, 30 );
			CCP.CombinePrison.JailPlayer.Entry:PerformLayout();
			CCP.CombinePrison.JailPlayer.Entry:RequestFocus();
			CCP.CombinePrison.JailPlayer.Entry:SetNumeric( true );
			CCP.CombinePrison.JailPlayer.Entry:SetCaretPos( string.len( CCP.CombinePrison.JailPlayer.Entry:GetValue() ) );
			
			CCP.CombinePrison.JailPlayer.Label = vgui.Create( "DLabel", CCP.CombinePrison.JailPlayer );
			CCP.CombinePrison.JailPlayer.Label:SetText( "minutes (1-10)" );
			CCP.CombinePrison.JailPlayer.Label:SetPos( 120, 34 );
			CCP.CombinePrison.JailPlayer.Label:SetSize( 130, 30 );
			CCP.CombinePrison.JailPlayer.Label:SetFont( "CombineControl.LabelBig" );
			CCP.CombinePrison.JailPlayer.Label:PerformLayout();
			
			CCP.CombinePrison.JailPlayer.Entry2 = vgui.Create( "DTextEntry", CCP.CombinePrison.JailPlayer );
			CCP.CombinePrison.JailPlayer.Entry2:SetFont( "CombineControl.LabelBig" );
			CCP.CombinePrison.JailPlayer.Entry2:SetPos( 70, 74 );
			CCP.CombinePrison.JailPlayer.Entry2:SetSize( 170, 30 );
			CCP.CombinePrison.JailPlayer.Entry2:PerformLayout();
			CCP.CombinePrison.JailPlayer.Entry2:SetCaretPos( string.len( CCP.CombinePrison.JailPlayer.Entry:GetValue() ) );
			
			CCP.CombinePrison.JailPlayer.Label2 = vgui.Create( "DLabel", CCP.CombinePrison.JailPlayer );
			CCP.CombinePrison.JailPlayer.Label2:SetText( "Reason:" );
			CCP.CombinePrison.JailPlayer.Label2:SetPos( 10, 74 );
			CCP.CombinePrison.JailPlayer.Label2:SetSize( 130, 30 );
			CCP.CombinePrison.JailPlayer.Label2:SetFont( "CombineControl.LabelBig" );
			CCP.CombinePrison.JailPlayer.Label2:PerformLayout();
			
			CCP.CombinePrison.JailPlayer.OK = vgui.Create( "DButton", CCP.CombinePrison.JailPlayer );
			CCP.CombinePrison.JailPlayer.OK:SetFont( "CombineControl.LabelSmall" );
			CCP.CombinePrison.JailPlayer.OK:SetText( "OK" );
			CCP.CombinePrison.JailPlayer.OK:SetPos( 190, 114 );
			CCP.CombinePrison.JailPlayer.OK:SetSize( 50, 30 );
			function CCP.CombinePrison.JailPlayer.OK:DoClick()
				
				if( !ply or !ply:IsValid() ) then
					
					CCP.CombinePrison.JailPlayer:Remove();
					return;
					
				end
				
				local val = tonumber( CCP.CombinePrison.JailPlayer.Entry:GetValue() );
				
				if( !val or val < 1 or val > 10 ) then
					
					CCP.CombinePrison.JailPlayer:Remove();
					return;
					
				end
				
				local val2 = CCP.CombinePrison.JailPlayer.Entry2:GetValue();
				
				if( string.len( val2 ) > 100 ) then
					
					CCP.CombinePrison.JailPlayer:Remove();
					return;
					
				end
				
				CCP.CombinePrison.JailPlayer:Remove();
				
				net.Start( "nAddPrison" );
					net.WriteEntity( ply );
					net.WriteUInt( val, 4 );
					net.WriteString( val2 );
				net.SendToServer();
				
				if( CCP.CombinePrison and CCP.CombinePrison:IsValid() ) then
					
					CCP.CombinePrison.AllPlayers:RemoveLine( CCP.CombinePrison.AllPlayers:GetSelected()[1]:GetID() );
					
					local line = CCP.CombinePrison.Prisoners:AddLine( ply:VisibleRPName(), string.ToMinutesSeconds( val * 60 ), val2, LocalPlayer():VisibleRPName() );
					line.Player = ply;
					
				end
				
			end
			CCP.CombinePrison.JailPlayer.OK:PerformLayout();
			
			CCP.CombinePrison.JailPlayer.Entry.OnEnter = CCP.CombinePrison.JailPlayer.OK.DoClick;
			CCP.CombinePrison.JailPlayer.Entry2.OnEnter = CCP.CombinePrison.JailPlayer.OK.DoClick;
			
		end
		
	end
	CCP.CombinePrison.Imprison:PerformLayout();
	
	CCP.CombinePrison.Release = vgui.Create( "DButton", CCP.CombinePrison );
	CCP.CombinePrison.Release:SetFont( "CombineControl.LabelSmall" );
	CCP.CombinePrison.Release:SetText( "<" );
	CCP.CombinePrison.Release:SetPos( 220, 474 );
	CCP.CombinePrison.Release:SetSize( 370, 20 );
	function CCP.CombinePrison.Release:DoClick()
		
		if( !CCP.CombinePrison.Prisoners:GetSelected()[1] ) then return end
		
		local ply = CCP.CombinePrison.Prisoners:GetSelected()[1].Player;
		
		if( ply and ply:IsValid() ) then
			
			net.Start( "nRemovePrison" );
				net.WriteEntity( ply );
			net.SendToServer();
			
			CCP.CombinePrison.Prisoners:RemoveLine( CCP.CombinePrison.Prisoners:GetSelected()[1]:GetID() );
			CCP.CombinePrison.AllPlayers:AddLine( ply:VisibleRPName() ).Player = ply;
			
		end
		
	end
	CCP.CombinePrison.Release:PerformLayout();
	
end

function GM:PMCreateCombineSurveillance()
	
	CCP.CombineSurveillance = vgui.Create( "DFrame" );
	CCP.CombineSurveillance:SetSize( 690, 500 );
	CCP.CombineSurveillance:Center();
	CCP.CombineSurveillance:SetTitle( "Local Camera Feeds" );
	CCP.CombineSurveillance.lblTitle:SetFont( "CombineControl.Window" );
	CCP.CombineSurveillance:MakePopup();
	CCP.CombineSurveillance.PerformLayout = CCFramePerformLayout;
	CCP.CombineSurveillance:PerformLayout();
	
	CCP.CombineSurveillance.List = vgui.Create( "DListView", CCP.CombineSurveillance );
	CCP.CombineSurveillance.List:SetPos( 10, 34 );
	CCP.CombineSurveillance.List:SetSize( 670, 406 );
	CCP.CombineSurveillance.List:AddColumn( "Coordinates" );
	CCP.CombineSurveillance.List:AddColumn( "Camera ID" );
	
	function CCP.CombineSurveillance.List:OnRowSelected( id, line )
		
		CCP.CombineSurveillance.SelectedID = id;
		CCP.CombineSurveillance.ViewBut:SetDisabled( false );
		
	end
	
	for _, v in pairs( ents.FindByClass( "npc_combine_camera" ) ) do
		
		local pos = v:GetPos();
		pos.x = math.floor( pos.x );
		pos.y = math.floor( pos.y );
		pos.z = math.floor( pos.z );
		local line = CCP.CombineSurveillance.List:AddLine( pos.x .. ", " .. pos.y .. ", " .. pos.z, v:EntIndex() );
		
		line.Ent = v;
		
	end
	
	for _, v in pairs( ents.FindByClass( "npc_cscanner" ) ) do
		
		local pos = v:GetPos();
		pos.x = math.floor( pos.x );
		pos.y = math.floor( pos.y );
		pos.z = math.floor( pos.z );
		local line = CCP.CombineSurveillance.List:AddLine( pos.x .. ", " .. pos.y .. ", " .. pos.z, v:EntIndex() );
		
		line.Ent = v;
		
	end
	
	CCP.CombineSurveillance.ViewBut = vgui.Create( "DButton", CCP.CombineSurveillance );
	CCP.CombineSurveillance.ViewBut:SetFont( "CombineControl.LabelSmall" );
	CCP.CombineSurveillance.ViewBut:SetText( "View" );
	CCP.CombineSurveillance.ViewBut:SetPos( 10, 460 );
	CCP.CombineSurveillance.ViewBut:SetSize( 100, 30 );
	CCP.CombineSurveillance.ViewBut.DoClick = function( self )
		
		local line = CCP.CombineSurveillance.List:GetLine( CCP.CombineSurveillance.SelectedID );
		
		if( line.Ent and line.Ent:IsValid() ) then
			
			GAMEMODE.CombineCameraView = line.Ent;
			
		end
		
	end
	CCP.CombineSurveillance.ViewBut:PerformLayout();
	CCP.CombineSurveillance.ViewBut:SetDisabled( true );
	
	CCP.CombineSurveillance.ResetBut = vgui.Create( "DButton", CCP.CombineSurveillance );
	CCP.CombineSurveillance.ResetBut:SetFont( "CombineControl.LabelSmall" );
	CCP.CombineSurveillance.ResetBut:SetText( "Reset" );
	CCP.CombineSurveillance.ResetBut:SetPos( 120, 460 );
	CCP.CombineSurveillance.ResetBut:SetSize( 100, 30 );
	CCP.CombineSurveillance.ResetBut.DoClick = function( self )
		
		GAMEMODE.CombineCameraView = nil;
		
	end
	CCP.CombineSurveillance.ResetBut:PerformLayout();
	
end

function nPrisonNotify30( len )
	
	local targ = net.ReadEntity();
	
	GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", targ:VisibleRPName() .. " (#" .. targ:FormattedCID() .. ")'s imprisonment cycle will end in 30 seconds.", { CB_ALL, CB_IC } );
	
end
net.Receive( "nPrisonNotify30", nPrisonNotify30 );

function nPrisonNotify( len )
	
	local targ = net.ReadEntity();
	
	GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", targ:VisibleRPName() .. " (#" .. targ:FormattedCID() .. ")'s imprisonment cycle has ended.", { CB_ALL, CB_IC } );
	
end
net.Receive( "nPrisonNotify", nPrisonNotify );

function GM:PMCreateCombine()
	
	local t = util.TimeSinceDate( LocalPlayer():CharCreationDate() );
	local ta = util.TimeSinceDate( LocalPlayer():CombineAppDate() );
	
	local d = math.floor( t / ( 60 * 24 ) );
	local da = math.floor( ta / ( 60 * 24 ) );
	
	if( LocalPlayer():HasCharFlag( "V" ) ) then
		
		CCP.PlayerMenu.NotCombine = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
		CCP.PlayerMenu.NotCombine:SetText( "Slavery's no fun!" );
		CCP.PlayerMenu.NotCombine:SetPos( 10, 10 );
		CCP.PlayerMenu.NotCombine:SetSize( 780, 14 );
		CCP.PlayerMenu.NotCombine:SetFont( "CombineControl.LabelSmall" );
		CCP.PlayerMenu.NotCombine:PerformLayout();
		CCP.PlayerMenu.NotCombine:SetWrap( true );
		CCP.PlayerMenu.NotCombine:SetAutoStretchVertical( true );
		
		return;
		
	end
	
	if( LocalPlayer():HasCharFlag( "W" ) ) then
		
		CCP.PlayerMenu.NotCombine = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
		CCP.PlayerMenu.NotCombine:SetText( "You're already with the Combine, technically. Unfortunately, you also have no freedom. Life's a bitch sometimes." );
		CCP.PlayerMenu.NotCombine:SetPos( 10, 10 );
		CCP.PlayerMenu.NotCombine:SetSize( 780, 14 );
		CCP.PlayerMenu.NotCombine:SetFont( "CombineControl.LabelSmall" );
		CCP.PlayerMenu.NotCombine:PerformLayout();
		CCP.PlayerMenu.NotCombine:SetWrap( true );
		CCP.PlayerMenu.NotCombine:SetAutoStretchVertical( true );
		
		return;
		
	end
	
	if( LocalPlayer():HasCharFlag( "S" ) ) then
		
		CCP.PlayerMenu.NotCombine = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
		CCP.PlayerMenu.NotCombine:SetText( "You're already a permanent slave to the Combine." );
		CCP.PlayerMenu.NotCombine:SetPos( 10, 10 );
		CCP.PlayerMenu.NotCombine:SetSize( 780, 14 );
		CCP.PlayerMenu.NotCombine:SetFont( "CombineControl.LabelSmall" );
		CCP.PlayerMenu.NotCombine:PerformLayout();
		CCP.PlayerMenu.NotCombine:SetWrap( true );
		CCP.PlayerMenu.NotCombine:SetAutoStretchVertical( true );
		
		return;
		
	end
	
	if( LocalPlayer():HasAnyCombineFlag() ) then
		
		if( GAMEMODE:LookupCombineFlag( LocalPlayer():ActiveFlag() ) ) then
		
			local terminalEnt;
		
			for k,v in next, ents.FindInSphere( LocalPlayer():GetPos(), 128 ) do
			
				if( v:GetClass() == "cc_terminal" ) then
				
					terminalEnt = v;
					
				end
			
			end
			
			if( terminalEnt ) then
			
				local flag = GAMEMODE:LookupCombineFlag( LocalPlayer():CombineFlag() );
				if( flag and flag.CanEditCPs ) then
					
					CCP.PlayerMenu.CombinePromoteBut = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
					CCP.PlayerMenu.CombinePromoteBut:SetFont( "CombineControl.LabelSmall" );
					CCP.PlayerMenu.CombinePromoteBut:SetText( "Edit Units" );
					CCP.PlayerMenu.CombinePromoteBut:SetPos( 640, 50 );
					CCP.PlayerMenu.CombinePromoteBut:SetSize( 150, 26 );
					CCP.PlayerMenu.CombinePromoteBut.DoClick = function( self )
						
						GAMEMODE:PMCreateCombinePromotions();
						
					end
					CCP.PlayerMenu.CombinePromoteBut:PerformLayout();
					
				end
				
				local icon = vgui.Create( "DModelPanel", CCP.PlayerMenu.ContentPane );
				icon:SetPos( 10, 10 );
				icon:SetModel( GAMEMODE:GetItemByID( "ration" ).Model );
				icon:SetSize( 64, 64 );
				
				if( GAMEMODE:GetItemByID( "ration" ).LookAt ) then
					
					icon:SetFOV( GAMEMODE:GetItemByID( "ration" ).FOV );
					icon:SetCamPos( GAMEMODE:GetItemByID( "ration" ).CamPos );
					icon:SetLookAt( GAMEMODE:GetItemByID( "ration" ).LookAt );
					
				else
					
					local a, b = icon.Entity:GetModelBounds();
					
					icon:SetFOV( 20 );
					icon:SetCamPos( Vector( math.abs( a.x ), math.abs( a.y ), math.abs( a.z ) ) * 5 );
					icon:SetLookAt( ( a + b ) / 2 );
					
				end
				
				function icon:LayoutEntity() end
				
				local p = icon.Paint;
				
				function icon:Paint( w, h )
					
					surface.SetDrawColor( 0, 0, 0, 70 );
					surface.DrawRect( 0, 0, w, h );
					
					surface.SetDrawColor( 0, 0, 0, 100 );
					surface.DrawOutlinedRect( 0, 0, w, h );
					
					p( self, w, h );
					
				end
				
				CCP.PlayerMenu.RationBut = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
				CCP.PlayerMenu.RationBut:SetFont( "CombineControl.LabelSmall" );
				CCP.PlayerMenu.RationBut:SetText( "Drop Ration" );
				CCP.PlayerMenu.RationBut:SetPos( 84, 10 );
				CCP.PlayerMenu.RationBut:SetSize( 150, 26 );
				CCP.PlayerMenu.RationBut.DoClick = function( self )
					
					if( GAMEMODE:Rations() > 0 ) then
						
						CCP.PlayerMenu.RationsLabel:SetText( "Remaining: " .. GAMEMODE:Rations() - 1 );
						
						net.Start( "nDropRation" );
						net.SendToServer();
						
					end
					
				end
				CCP.PlayerMenu.RationBut:PerformLayout();
				
				local flag = GAMEMODE:LookupCombineFlag( LocalPlayer():ActiveFlag() );
				if( !flag or !flag.CanSpawn ) then
					
					CCP.PlayerMenu.RationBut:SetDisabled( true );
					
				end
				
				CCP.PlayerMenu.RationsLabel = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
				CCP.PlayerMenu.RationsLabel:SetText( "Remaining: " .. GAMEMODE:Rations() );
				CCP.PlayerMenu.RationsLabel:SetPos( 84, 50 );
				CCP.PlayerMenu.RationsLabel:SetFont( "CombineControl.LabelSmall" );
				CCP.PlayerMenu.RationsLabel:SizeToContents();
				CCP.PlayerMenu.RationsLabel:PerformLayout();
				
				CCP.PlayerMenu.LoansBut = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
				CCP.PlayerMenu.LoansBut:SetFont( "CombineControl.LabelSmall" );
				CCP.PlayerMenu.LoansBut:SetText( "ARCS Financial Aid" );
				CCP.PlayerMenu.LoansBut:SetPos( 10, 158 );
				CCP.PlayerMenu.LoansBut:SetSize( 150, 26 );
				CCP.PlayerMenu.LoansBut.DoClick = function( self )
					
					GAMEMODE:PMCreateCombineLoans();
					
				end
				CCP.PlayerMenu.LoansBut:PerformLayout();
				
				CCP.PlayerMenu.HousingBut = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
				CCP.PlayerMenu.HousingBut:SetFont( "CombineControl.LabelSmall" );
				CCP.PlayerMenu.HousingBut:SetText( "Section 8 Management" );
				CCP.PlayerMenu.HousingBut:SetPos( 10, 194 );
				CCP.PlayerMenu.HousingBut:SetSize( 150, 26 );
				CCP.PlayerMenu.HousingBut.DoClick = function( self )
					
					GAMEMODE:PMCreateCombineHousing();
					
				end
				CCP.PlayerMenu.HousingBut:PerformLayout();
				
				CCP.PlayerMenu.RosterBut = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
				CCP.PlayerMenu.RosterBut:SetFont( "CombineControl.LabelSmall" );
				CCP.PlayerMenu.RosterBut:SetText( "View Roster" );
				CCP.PlayerMenu.RosterBut:SetPos( 10, 230 );
				CCP.PlayerMenu.RosterBut:SetSize( 150, 26 );
				CCP.PlayerMenu.RosterBut.DoClick = function( self )
					
					GAMEMODE:PMCreateCombineRoster();
					
				end
				CCP.PlayerMenu.RosterBut:PerformLayout();
				
				CCP.PlayerMenu.RecordBut = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
				CCP.PlayerMenu.RecordBut:SetFont( "CombineControl.LabelSmall" );
				CCP.PlayerMenu.RecordBut:SetText( "Criminal Records" );
				CCP.PlayerMenu.RecordBut:SetPos( 10, 266 );
				CCP.PlayerMenu.RecordBut:SetSize( 150, 26 );
				CCP.PlayerMenu.RecordBut.DoClick = function( self )
					
					GAMEMODE:PMCreateCombineRecords();
					
				end
				CCP.PlayerMenu.RecordBut:PerformLayout();
				
				CCP.PlayerMenu.PrisonBut = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
				CCP.PlayerMenu.PrisonBut:SetFont( "CombineControl.LabelSmall" );
				CCP.PlayerMenu.PrisonBut:SetText( "Prison Management" );
				CCP.PlayerMenu.PrisonBut:SetPos( 10, 302 );
				CCP.PlayerMenu.PrisonBut:SetSize( 150, 26 );
				CCP.PlayerMenu.PrisonBut.DoClick = function( self )
					
					GAMEMODE:PMCreateCombinePrison();
					
				end
				CCP.PlayerMenu.PrisonBut:PerformLayout();
				
				CCP.PlayerMenu.PrisonBut = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
				CCP.PlayerMenu.PrisonBut:SetFont( "CombineControl.LabelSmall" );
				CCP.PlayerMenu.PrisonBut:SetText( "Surveillance" );
				CCP.PlayerMenu.PrisonBut:SetPos( 10, 338 );
				CCP.PlayerMenu.PrisonBut:SetSize( 150, 26 );
				CCP.PlayerMenu.PrisonBut.DoClick = function( self )
					
					GAMEMODE:PMCreateCombineSurveillance();
					
				end
				CCP.PlayerMenu.PrisonBut:PerformLayout();
				
				CCP.PlayerMenu.JWButOn = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
				CCP.PlayerMenu.JWButOn:SetFont( "CombineControl.LabelSmall" );
				CCP.PlayerMenu.JWButOn:SetText( "Activate Precinct Lockdown" );
				CCP.PlayerMenu.JWButOn:SetPos( 625, 354 );
				CCP.PlayerMenu.JWButOn:SetSize( 165, 26 );
				CCP.PlayerMenu.JWButOn.DoClick = function( self )
					
					net.Start( "nSetJW" );
						net.WriteBit( true );
					net.SendToServer();
					
					CCP.PlayerMenu.JWButOn:SetDisabled( true );
					CCP.PlayerMenu.JWButOff:SetDisabled( false );
					
				end
				CCP.PlayerMenu.JWButOn:PerformLayout();
				
				CCP.PlayerMenu.JWButOff = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
				CCP.PlayerMenu.JWButOff:SetFont( "CombineControl.LabelSmall" );
				CCP.PlayerMenu.JWButOff:SetText( "Terminate Precinct Lockdown" );
				CCP.PlayerMenu.JWButOff:SetPos( 615, 390 );
				CCP.PlayerMenu.JWButOff:SetSize( 175, 26 );
				CCP.PlayerMenu.JWButOff.DoClick = function( self )
					
					net.Start( "nSetJW" );
						net.WriteBit( false );
					net.SendToServer();
					
					CCP.PlayerMenu.JWButOn:SetDisabled( false );
					CCP.PlayerMenu.JWButOff:SetDisabled( true );
					
				end
				CCP.PlayerMenu.JWButOff:PerformLayout();
				
				if( GAMEMODE:JudgementWaiver() == 1 ) then
					
					CCP.PlayerMenu.JWButOn:SetDisabled( true );
					CCP.PlayerMenu.JWButOff:SetDisabled( false );
					
				else
					
					CCP.PlayerMenu.JWButOn:SetDisabled( false );
					CCP.PlayerMenu.JWButOff:SetDisabled( true );
					
				end
				
				if( GAMEMODE:LookupCombineFlag( LocalPlayer():ActiveFlag() ) and !GAMEMODE:LookupCombineFlag( LocalPlayer():ActiveFlag() ).CanJW ) then
					
					CCP.PlayerMenu.JWButOn:SetDisabled( true );
					CCP.PlayerMenu.JWButOff:SetDisabled( true );
					
				end
				
			else
			
				CCP.PlayerMenu.NeedsTerminal = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
				CCP.PlayerMenu.NeedsTerminal:SetText( "ACCESS DENIED!\n\nTo access to the SDPD-ARCS precinct network, you must be near an SDPD network node." );
				CCP.PlayerMenu.NeedsTerminal:SetPos( 10, 10 );
				CCP.PlayerMenu.NeedsTerminal:SetSize( 780, 14 );
				CCP.PlayerMenu.NeedsTerminal:SetFont( "CombineControl.LabelSmall" );
				CCP.PlayerMenu.NeedsTerminal:PerformLayout();
				CCP.PlayerMenu.NeedsTerminal:SetWrap( true );
				CCP.PlayerMenu.NeedsTerminal:SetAutoStretchVertical( true );
			
			end
			
		else
			
			CCP.PlayerMenu.NeedsFlagged = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
			CCP.PlayerMenu.NeedsFlagged:SetText( "ACCESS DENIED!\n\nTo access to the SDPD-ARCS precinct network, you must be on the clock.\n\nType /sdpd in chat to go on duty." );
			CCP.PlayerMenu.NeedsFlagged:SetPos( 10, 10 );
			CCP.PlayerMenu.NeedsFlagged:SetSize( 780, 14 );
			CCP.PlayerMenu.NeedsFlagged:SetFont( "CombineControl.LabelSmall" );
			CCP.PlayerMenu.NeedsFlagged:PerformLayout();
			CCP.PlayerMenu.NeedsFlagged:SetWrap( true );
			CCP.PlayerMenu.NeedsFlagged:SetAutoStretchVertical( true );
			
		end
		
	else

		CCP.PlayerMenu.NotCombine = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
		CCP.PlayerMenu.NotCombine:SetText( "You're not a member of the CCA." );
		CCP.PlayerMenu.NotCombine:SetPos( 10, 10 );
		CCP.PlayerMenu.NotCombine:SetSize( 780, 14 );
		CCP.PlayerMenu.NotCombine:SetFont( "CombineControl.LabelSmall" );
		CCP.PlayerMenu.NotCombine:PerformLayout();
		CCP.PlayerMenu.NotCombine:SetWrap( true );
		CCP.PlayerMenu.NotCombine:SetAutoStretchVertical( true );
		
	end
	
end

function GM:PMCreateSettings()
	
	CCP.PlayerMenu.SettingsMusicL = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsMusicL:SetText( "Music Enabled" );
	CCP.PlayerMenu.SettingsMusicL:SetPos( 10, 10 );
	CCP.PlayerMenu.SettingsMusicL:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.SettingsMusicL:SizeToContents();
	CCP.PlayerMenu.SettingsMusicL:PerformLayout();
	
	CCP.PlayerMenu.SettingsMusic = vgui.Create( "DCheckBoxLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsMusic:SetText( "" );
	CCP.PlayerMenu.SettingsMusic:SetPos( 150, 10 );
	CCP.PlayerMenu.SettingsMusic:SetValue( cookie.GetNumber( "cc_music", 1 ) );
	CCP.PlayerMenu.SettingsMusic:PerformLayout();
	function CCP.PlayerMenu.SettingsMusic:OnChange( val )
		
		cookie.Set( "cc_music", val and 1 or 0 );
		
		if( !val ) then
			
			GAMEMODE:FadeOutMusic( 1 );
			
		end
		
	end
	
	CCP.PlayerMenu.SettingsHUDL = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsHUDL:SetText( "HUD Enabled" );
	CCP.PlayerMenu.SettingsHUDL:SetPos( 10, 40 );
	CCP.PlayerMenu.SettingsHUDL:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.SettingsHUDL:SizeToContents();
	CCP.PlayerMenu.SettingsHUDL:PerformLayout();
	
	CCP.PlayerMenu.SettingsHUD = vgui.Create( "DCheckBoxLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsHUD:SetText( "" );
	CCP.PlayerMenu.SettingsHUD:SetPos( 150, 40 );
	CCP.PlayerMenu.SettingsHUD:SetValue( cookie.GetNumber( "cc_hud", 1 ) );
	CCP.PlayerMenu.SettingsHUD:PerformLayout();
	function CCP.PlayerMenu.SettingsHUD:OnChange( val )
		
		cookie.Set( "cc_hud", val and 1 or 0 );
		
	end
	
	CCP.PlayerMenu.SettingsHUD:PerformLayout();
	CCP.PlayerMenu.SettingsHUD:SizeToContents();
	
	CCP.PlayerMenu.SettingsChatL = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsChatL:SetText( "HUD Chat Enabled" );
	CCP.PlayerMenu.SettingsChatL:SetPos( 10, 70 );
	CCP.PlayerMenu.SettingsChatL:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.SettingsChatL:SizeToContents();
	CCP.PlayerMenu.SettingsChatL:PerformLayout();
	
	CCP.PlayerMenu.SettingsChat = vgui.Create( "DCheckBoxLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsChat:SetText( "" );
	CCP.PlayerMenu.SettingsChat:SetPos( 150, 70 );
	CCP.PlayerMenu.SettingsChat:SetValue( cookie.GetNumber( "cc_chat", 1 ) );
	CCP.PlayerMenu.SettingsChat:PerformLayout();
	function CCP.PlayerMenu.SettingsChat:OnChange( val )
		
		cookie.Set( "cc_chat", val and 1 or 0 );
		
	end
	
	CCP.PlayerMenu.SettingsChat:PerformLayout();
	CCP.PlayerMenu.SettingsChat:SizeToContents();
	
	CCP.PlayerMenu.SettingsThirdL = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsThirdL:SetText( "Thirdperson Enabled" );
	CCP.PlayerMenu.SettingsThirdL:SetPos( 10, 100 );
	CCP.PlayerMenu.SettingsThirdL:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.SettingsThirdL:SizeToContents();
	CCP.PlayerMenu.SettingsThirdL:PerformLayout();
	
	CCP.PlayerMenu.SettingsThird = vgui.Create( "DCheckBoxLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsThird:SetText( "" );
	CCP.PlayerMenu.SettingsThird:SetPos( 150, 100 );
	CCP.PlayerMenu.SettingsThird:SetValue( cookie.GetNumber( "cc_thirdperson", 0 ) );
	CCP.PlayerMenu.SettingsThird:PerformLayout();
	function CCP.PlayerMenu.SettingsThird:OnChange( val )
		
		cookie.Set( "cc_thirdperson", val and 1 or 0 );
		
		if val then
		
			ctp:Enable();
			
		else
		
			ctp:Disable();
			
		end
		
	end
	
	CCP.PlayerMenu.SettingsThird:PerformLayout();
	CCP.PlayerMenu.SettingsThird:SizeToContents();
	
	CCP.PlayerMenu.SettingsChat = vgui.Create( "DNumSlider", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsChat:SetText( "Chat Height" );
	CCP.PlayerMenu.SettingsChat:SetPos( 10, 130 );
	CCP.PlayerMenu.SettingsChat:SetSize( 300, 16 );
	CCP.PlayerMenu.SettingsChat:SetMin( 200 );
	CCP.PlayerMenu.SettingsChat:SetMax( 800 );
	CCP.PlayerMenu.SettingsChat:SetDecimals( 0 );
	CCP.PlayerMenu.SettingsChat:SetValue( cookie.GetNumber( "cc_chatheight", 300 ) );
	CCP.PlayerMenu.SettingsChat.PerformLayout = CCSliderPerformLayout;
	CCP.PlayerMenu.SettingsChat:PerformLayout();
	function CCP.PlayerMenu.SettingsChat:ValueChanged( val )
		
		cookie.Set( "cc_chatheight", val );
		
	end
	
	CCP.PlayerMenu.SettingsChat:PerformLayout();
	CCP.PlayerMenu.SettingsChat:SizeToContents();
	
	CCP.PlayerMenu.SettingsChatLines = vgui.Create( "DNumSlider", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsChatLines:SetText( "Max Chat Lines" );
	CCP.PlayerMenu.SettingsChatLines:SetPos( 10, 160 );
	CCP.PlayerMenu.SettingsChatLines:SetSize( 300, 16 );
	CCP.PlayerMenu.SettingsChatLines:SetMin( 10 );
	CCP.PlayerMenu.SettingsChatLines:SetMax( 500 );
	CCP.PlayerMenu.SettingsChatLines:SetDecimals( 0 );
	CCP.PlayerMenu.SettingsChatLines:SetValue( math.floor( cookie.GetNumber( "cc_maxchatlines", 100 ) ) );
	CCP.PlayerMenu.SettingsChatLines.PerformLayout = CCSliderPerformLayout;
	CCP.PlayerMenu.SettingsChatLines:PerformLayout();
	function CCP.PlayerMenu.SettingsChatLines:ValueChanged( val )
		
		cookie.Set( "cc_maxchatlines", val );
		
		if( #GAMEMODE.ChatLines > math.floor( cookie.GetNumber( "cc_maxchatlines", 100 ) ) ) then
			
			for i = 1, #GAMEMODE.ChatLines - math.floor( cookie.GetNumber( "cc_maxchatlines", 100 ) ) do
				
				table.remove( GAMEMODE.ChatLines, 1 );
				
			end
			
		end
		
	end
	
	CCP.PlayerMenu.SettingsChatLines:PerformLayout();
	CCP.PlayerMenu.SettingsChatLines:SizeToContents();
	
	CCP.PlayerMenu.SettingsMOTDL = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsMOTDL:SetText( "MOTD Enabled" );
	CCP.PlayerMenu.SettingsMOTDL:SetPos( 10, 190 );
	CCP.PlayerMenu.SettingsMOTDL:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.SettingsMOTDL:SizeToContents();
	CCP.PlayerMenu.SettingsMOTDL:PerformLayout();
	
	CCP.PlayerMenu.SettingsMOTD = vgui.Create( "DCheckBoxLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsMOTD:SetText( "" );
	CCP.PlayerMenu.SettingsMOTD:SetPos( 150, 190 );
	CCP.PlayerMenu.SettingsMOTD:SetValue( cookie.GetNumber( "cc_motd", 1 ) );
	CCP.PlayerMenu.SettingsMOTD:PerformLayout();
	function CCP.PlayerMenu.SettingsMOTD:OnChange( val )
		
		cookie.Set( "cc_motd", val and 1 or 0 );
		
	end
	
	CCP.PlayerMenu.SettingsMOTD:PerformLayout();
	CCP.PlayerMenu.SettingsMOTD:SizeToContents();
	
	CCP.PlayerMenu.SettingsHeadbobL = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsHeadbobL:SetText( "Headbob Enabled" );
	CCP.PlayerMenu.SettingsHeadbobL:SetPos( 10, 220 );
	CCP.PlayerMenu.SettingsHeadbobL:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.SettingsHeadbobL:SizeToContents();
	CCP.PlayerMenu.SettingsHeadbobL:PerformLayout();
	
	CCP.PlayerMenu.SettingsHeadbob = vgui.Create( "DCheckBoxLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsHeadbob:SetText( "" );
	CCP.PlayerMenu.SettingsHeadbob:SetPos( 150, 220 );
	CCP.PlayerMenu.SettingsHeadbob:SetValue( cookie.GetNumber( "cc_headbob", 0 ) );
	CCP.PlayerMenu.SettingsHeadbob:PerformLayout();
	function CCP.PlayerMenu.SettingsHeadbob:OnChange( val )
		
		cookie.Set( "cc_headbob", val and 1 or 0 );
		
	end
	
	CCP.PlayerMenu.SettingsNewbieL = vgui.Create( "DLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsNewbieL:SetText( "Mark me as an inexperienced roleplayer" );
	CCP.PlayerMenu.SettingsNewbieL:SetPos( 200, 10 );
	CCP.PlayerMenu.SettingsNewbieL:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.SettingsNewbieL:SizeToContents();
	CCP.PlayerMenu.SettingsNewbieL:PerformLayout();
	
	CCP.PlayerMenu.SettingsNewbie = vgui.Create( "DCheckBoxLabel", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.SettingsNewbie:SetText( "" );
	CCP.PlayerMenu.SettingsNewbie:SetPos( 420, 10 );
	CCP.PlayerMenu.SettingsNewbie:SetValue( LocalPlayer():NewbieStatus() == NEWBIE_STATUS_NEW );
	CCP.PlayerMenu.SettingsNewbie:PerformLayout();
	function CCP.PlayerMenu.SettingsNewbie:OnChange( val )
		
		net.Start( "nSetNewbieStatus" );
			net.WriteBit( val );
		net.SendToServer();
		
	end
	
	local y = 346;
	
	if( GAMEMODE.WebsiteURL != "" ) then
		
		CCP.PlayerMenu.WebsiteBut = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
		CCP.PlayerMenu.WebsiteBut:SetFont( "CombineControl.LabelSmall" );
		CCP.PlayerMenu.WebsiteBut:SetText( "Open Website" );
		CCP.PlayerMenu.WebsiteBut:SetPos( 10, y );
		CCP.PlayerMenu.WebsiteBut:SetSize( 120, 30 );
		CCP.PlayerMenu.WebsiteBut.DoClick = function( self )
			
			gui.OpenURL( GAMEMODE.WebsiteURL );
			
		end
		CCP.PlayerMenu.WebsiteBut:PerformLayout();
		
		y = y - 40;
		
	end
	
	if( GAMEMODE.SteamGroupURL != "" ) then
		
		CCP.PlayerMenu.SteamBut = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
		CCP.PlayerMenu.SteamBut:SetFont( "CombineControl.LabelSmall" );
		CCP.PlayerMenu.SteamBut:SetText( "Open Steam Group" );
		CCP.PlayerMenu.SteamBut:SetPos( 10, y );
		CCP.PlayerMenu.SteamBut:SetSize( 120, 30 );
		CCP.PlayerMenu.SteamBut.DoClick = function( self )
			
			gui.OpenURL( GAMEMODE.SteamGroupURL );
			
		end
		CCP.PlayerMenu.SteamBut:PerformLayout();
		
		y = y - 40;
		
	end
	
	if( GAMEMODE.UpdatesURL != "" ) then
		
		CCP.PlayerMenu.UpdatesBut = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
		CCP.PlayerMenu.UpdatesBut:SetFont( "CombineControl.LabelSmall" );
		CCP.PlayerMenu.UpdatesBut:SetText( "Server Updates" );
		CCP.PlayerMenu.UpdatesBut:SetPos( 10, y );
		CCP.PlayerMenu.UpdatesBut:SetSize( 120, 30 );
		CCP.PlayerMenu.UpdatesBut.DoClick = function( self )
			
			gui.OpenURL( GAMEMODE.UpdatesURL );
			
		end
		CCP.PlayerMenu.UpdatesBut:PerformLayout();
		
		y = y - 40;
		
	end
	
	CCP.PlayerMenu.ClearDecalBut = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.ClearDecalBut:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.ClearDecalBut:SetText( "Clear Decals" );
	CCP.PlayerMenu.ClearDecalBut:SetPos( 10, 386 );
	CCP.PlayerMenu.ClearDecalBut:SetSize( 120, 30 );
	CCP.PlayerMenu.ClearDecalBut.DoClick = function( self )
		
		RunConsoleCommand( "r_cleardecals" );
		
	end
	CCP.PlayerMenu.ClearDecalBut:PerformLayout();
	
	if( GAMEMODE.IntroCamData ) then
		
		CCP.PlayerMenu.IntroBut = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
		CCP.PlayerMenu.IntroBut:SetFont( "CombineControl.LabelSmall" );
		CCP.PlayerMenu.IntroBut:SetText( "Play Intro" );
		CCP.PlayerMenu.IntroBut:SetPos( 690, 266 );
		CCP.PlayerMenu.IntroBut:SetSize( 100, 30 );
		CCP.PlayerMenu.IntroBut.DoClick = function( self )
			
			CCP.PlayerMenu:Remove();
			GAMEMODE:StartIntroCam();
			GAMEMODE:CreateSynopsis();
			
		end
		CCP.PlayerMenu.IntroBut:PerformLayout();
		
	end
	
	CCP.PlayerMenu.ResyncBut = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.ResyncBut:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.ResyncBut:SetText( "Resync Players" );
	CCP.PlayerMenu.ResyncBut:SetPos( 690, 306 );
	CCP.PlayerMenu.ResyncBut:SetSize( 100, 30 );
	CCP.PlayerMenu.ResyncBut.DoClick = function( self )
		
		net.Start( "nRequestAllPlayerData" );
		net.SendToServer();
		
	end
	CCP.PlayerMenu.ResyncBut:PerformLayout();
	
	CCP.PlayerMenu.KillBut = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.KillBut:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.KillBut:SetText( "Suicide" );
	CCP.PlayerMenu.KillBut:SetPos( 690, 346 );
	CCP.PlayerMenu.KillBut:SetSize( 100, 30 );
	CCP.PlayerMenu.KillBut.DoClick = function( self )
		
		RunConsoleCommand( "kill" );
		
	end
	CCP.PlayerMenu.KillBut:PerformLayout();
	
	CCP.PlayerMenu.RejoinBut = vgui.Create( "DButton", CCP.PlayerMenu.ContentPane );
	CCP.PlayerMenu.RejoinBut:SetFont( "CombineControl.LabelSmall" );
	CCP.PlayerMenu.RejoinBut:SetText( "Rejoin" );
	CCP.PlayerMenu.RejoinBut:SetPos( 690, 386 );
	CCP.PlayerMenu.RejoinBut:SetSize( 100, 30 );
	CCP.PlayerMenu.RejoinBut.DoClick = function( self )
		
		RunConsoleCommand( "retry" );
		
	end
	CCP.PlayerMenu.RejoinBut:PerformLayout();
	
end

function ccToggleThirdPerson( ply, cmd, args )
	
	cookie.Set( "cc_thirdperson", 1 - cookie.GetNumber( "cc_thirdperson", 0 ) );
	
	if( CCP.PlayerMenu and CCP.PlayerMenu:IsValid() and CCP.PlayerMenu.SettingsThird and CCP.PlayerMenu.SettingsThird:IsValid() ) then
		
		CCP.PlayerMenu.SettingsThird:SetValue( cookie.GetNumber( "cc_thirdperson", 0 ) );
		
	end
	
end
concommand.Add( "rp_thirdperson", ccToggleThirdPerson )