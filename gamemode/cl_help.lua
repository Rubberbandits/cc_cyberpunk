GM.HelpContent = GM.HelpContent or {
	{ "Synopsis",
		[[The year is 2248.

Two hundred twenty years ago, a probe identified a complex structure of unknown elemental composition partially concealed beneath the ice on Jupiter's second moon, Europa. One by one, all other possibilities were ruled out: the structure must have been left behind by an intelligent species.

Exploration of the facility yielded new technologies that radically reshaped human civilization. From terraforming to quantum computing to new interstellar propulsion techniques, humanity was catapulted forward centuries in only a few short years. For the average Earthling, however, the most important discovery by far was the cortical stack - a microchip implant capable of storing a sentient mind; a continuous stream of consciousness with personality, memories, and all.

The facility on Europa provides the means to manufacture the cortical stack practically ad infinitum. Nearly every citizen of the United Earth Commonwealth receives a cortical stack implant at birth, intended to act as a guarantee against wrongful death, terminal illness, and neurodegenerative disorders. However, ethical concerns with sourcing replacement bodies (termed sleeves) and mounting overpopulation issues hobble the full potential offered by the cortical stack. With society's development outpaced by technology, the cortical stack allows for new depths of exploitation, and taxes levied on exceeding a natural healthy lifespan intended to slow overpopulation only serve to create a truly immortal class of hyper-rich 'Meths'.

The city of San Diego is a sprawling, multi-level metropolis home to over two hundred million people. Almost unmanageable in scale, San Diego - like Earth's other megacities - is rife with poverty, crime, and unregulated industry. Huge swaths of the city are practically without rule of law, and those living in its depths survive on a new type of frontier, where morals take a back seat to survival.

Thirty years ago, an apocalyptic earthquake shook Japan, leaving hundreds of millions dead, destitute, and hopeless. Record numbers of refugees found their way to American megacities. In total, San Diego took in fifteen million, divided across five of the city's wards. Ward Seventeen, already overpopulated, underpoliced, and infamous for corruption and filth, received and retained the most.

With few other options, the San Diego Police Department chose to subcontract law enforcement, insofar as law can be enforced in such conditions, to Anderson Risk Control Services, a private security company maintaining many local industrial contracts. Japanese refugees cannot leave the ward.

Far above, in gleaming skyscrapers and airborne palaces, an elite few - the robber barons, media moguls, and socialites - enjoy unnaturally extended lives, untouchable and detached from the man-made hell beneath their feet. For now.]]
	},
	{ "Credits",
		[[CombineControl created by Disseminate.
		
		Casadis - for all the support and ideas.
		Kamern - ideas and support.
		rusty - fixing combinecontrol, augments, stockpiles, stims]]
	},
	{ "Chat Commands",
		[[Just entering something in the chatbox will make you say it in character.
		
		/help - Show this menu
		
		/y - Yell
		/w - Whisper
		/me - Action
		/it - World action
		/an - Anonymous
		// - Global OOC
		[ [, .// - Local OOC
		/a - Talk to admins
		/pm [name] [text] - PM another player
		/r - Talk on your radio if you have one
		/cr - Talk on your CR device if you have one
		/bc - Broadcast a message as a CP
		/ad - Send out an advertisement (costs 10 dollars)
		/help - Open this menu
		
		/civilian - Flag down.
		/sdpd - Flag up.
		
		/rus - Speak Russian.
		/chi - Speak Chinese.
		/jap - Speak Japanese.
		/spa - Speak Spanish.
		/fre - Speak French.
		/ger - Speak German.
		/ita - Speak Italian. ]] },
	{ "Key Bindings", [[F1 - Open help menu.
	F2 - Open character menu.
	F3 - Open player menu.
	F4 - Open admin menu.
	C - Open context menu.]] },
	{ "Flags", [[CombineControl uses a flag system for police and some other character types.
	
	If an admin sets your police flags, you can "flag up" or become the faction with /sdpd, and become a civilian again with /civilian.
	Non-police flags are automatic - you don't need to flag up for them.
	
	Police Flags
	A - Technician
	B - Patrol Officer
	C - Corporal
	D - Sergeant
	E - Lieutenant
	F - Captain
	G - Precinct Commander
	
	Character Flags
	B - Food merchant
	A - Alcohol merchant
	E - Electronics merchant
	M - Miscellaneous merchant
	F - FFL Dealer
	X - Blackmarket dealer
	Q - Cybernetic Prosthetist
	O - AutoCop]] },
	{ "Tooltrust", [[By default, you don't have tooltrust, you have phystrust, and you have proptrust. Phys- and proptrust give you a physgun and the ability to spawn props respectively. Tooltrust gives you a toolgun.
	
	Basic tooltrust gives you some common simple tools, a slightly increased prop limit, and slightly increased prop spawn permissions. To get this, ask an admin.
	
	Advanced tooltrust gives you most tools, an increased prop limit, and increased prop spawn permissions. Advanced tooltrust users' props are solid, whereas basic and non tooltrusted props are no-collided.
	
	Admins can take away phys and proptrust if you abuse the privillege - you can get it back on the forums.]] },
	{ "PAC Rules", [[PAC is available on this server as a flag.
	
	The use of PAC is a privilege. Find a head model you would like to use in the "Double Barrel - Content Part 3" addon (Workshop), then ask an administrator for the flag and to set your player model to the model you chose. Right click on the spawn icon to copy its model path.
	
	You can find the basic clothing options in "Double Barrel - Content Part 2" at the top of the list as b_torso, b_legs, b_femtorso, etc. (the icons are mostly invisible). Copy the path for the torso model that applies to your character.
	
	In PAC, create a "model" part from the "experimental" category and paste in the torso's path for the model field. To refresh the options, you will have to click on My Outfit and then back to the model you created. Tick the "bonemerge" option to apply it to your character's skeleton. Now you will be able to pick a bodygroup of your choice on the torso. Repeat this process for the legs.
	
	You do not have to use the Double Barrel (Gunsmoke) content if your grasp on PAC is more advanced! Please feel free to be creative. However, abusing PAC will result in the permanent loss of your flag, so read the following carefully:
	
	- If your character does not have a piece of equipment such as a firearm or armor vest, do not use PAC to depict it.
	- Streaming (downloading) some parts is fine, but do not stream a complete character model. This has a high bandwidth overhead and has been identified as a crash cause for players with lower end PCs.
	- Do not open the PAC editor in high traffic areas, and do not open the PAC editor when someone is roleplaying with you. It's obnoxious.
	- PAC has options that may tempt you to be silly. That is fine in certain contexts, but disruption of roleplay caused by unserious PAC outfits will not be tolerated. Use your head.
	
	As long as you use common sense and do not abuse PAC, you are free to customize your character's appearance to your heart's content. Feel free to visually represent augments or prosthetic limbs that may not necessarily be represented in the script, as long as they do not imply an advantage (unless cleared by the admin team).
	
	Enjoy! ]] },
};

function GM:RefreshHelpMenuContent()

	self.HelpContent = {
		{ "Synopsis",
			[[The year is 2248.

Two hundred twenty years ago, a probe identified a complex structure of unknown elemental composition partially concealed beneath the ice on Jupiter's second moon, Europa. One by one, all other possibilities were ruled out: the structure must have been left behind by an intelligent species.

Exploration of the facility yielded new technologies that radically reshaped human civilization. From terraforming to quantum computing to new interstellar propulsion techniques, humanity was catapulted forward centuries in only a few short years. For the average Earthling, however, the most important discovery by far was the cortical stack - a microchip implant capable of storing a sentient mind; a continuous stream of consciousness with personality, memories, and all.

The facility on Europa provides the means to manufacture the cortical stack practically ad infinitum. Nearly every citizen of the United Earth Commonwealth receives a cortical stack implant at birth, intended to act as a guarantee against wrongful death, terminal illness, and neurodegenerative disorders. However, ethical concerns with sourcing replacement bodies (termed sleeves) and mounting overpopulation issues hobble the full potential offered by the cortical stack. With society's development outpaced by technology, the cortical stack allows for new depths of exploitation, and taxes levied on exceeding a natural healthy lifespan intended to slow overpopulation only serve to create a truly immortal class of hyper-rich 'Meths'.

The city of San Diego is a sprawling, multi-level metropolis home to over two hundred million people. Almost unmanageable in scale, San Diego - like Earth's other megacities - is rife with poverty, crime, and unregulated industry. Huge swaths of the city are practically without rule of law, and those living in its depths survive on a new type of frontier, where morals take a back seat to survival.

Thirty years ago, an apocalyptic earthquake shook Japan, leaving hundreds of millions dead, destitute, and hopeless. Record numbers of refugees found their way to American megacities. In total, San Diego took in fifteen million, divided across five of the city's wards. Ward Seventeen, already overpopulated, underpoliced, and infamous for corruption and filth, received and retained the most.

With few other options, the San Diego Police Department chose to subcontract law enforcement, insofar as law can be enforced in such conditions, to Anderson Risk Control Services, a private security company maintaining many local industrial contracts. Japanese refugees cannot leave the ward.

Far above, in gleaming skyscrapers and airborne palaces, an elite few - the robber barons, media moguls, and socialites - enjoy unnaturally extended lives, untouchable and detached from the man-made hell beneath their feet. For now.]]
		},
		{ "Credits",
			[[CombineControl created by Disseminate.
			
			Casadis - for all the support and ideas.
			Kamern - ideas and support.
			rusty - running server, fixing combinecontrol.]]
		},
		{ "Chat Commands",
			[[Just entering something in the chatbox will make you say it in character.
			
			/help - Show this menu
			
			/y - Yell
			/w - Whisper
			/me - Action
			/it - World action
			/an - Anonymous
			// - Global OOC
			[ [, .// - Local OOC
			/a - Talk to admins
			/pm [name] [text] - PM another player
			/r - Talk on your radio if you have one
			/cr - Talk on your CR device if you have one
			/bc - Broadcast a message as a CP
			/ad - Send out an advertisement (costs 10 dollars)
			/help - Open this menu
			
			/civilian - Flag down.
			/sdpd - Flag up.
			
			/rus - Speak Russian.
			/chi - Speak Chinese.
			/jap - Speak Japanese.
			/spa - Speak Spanish.
			/fre - Speak French.
			/ger - Speak German.
			/ita - Speak Italian. ]] },
		{ "Key Bindings", [[F1 - Open help menu.
		F2 - Open character menu.
		F3 - Open player menu.
		F4 - Open admin menu.
		C - Open context menu.]] },
		{ "Flags", [[CombineControl uses a flag system for police and some other character types.
		
		If an admin sets your police flags, you can "flag up" or become the faction with /sdpd, and become a civilian again with /civilian.
		Non-police flags are automatic - you don't need to flag up for them.
		
		Police Flags
		A - Technician
		B - Patrol Officer
		C - Corporal
		D - Sergeant
		E - Lieutenant
		F - Captain
		G - Precinct Commander
		
		Character Flags
		B - Food merchant
		A - Alcohol merchant
		E - Electronics merchant
		M - Miscellaneous merchant
		F - FFL Dealer
		X - Blackmarket dealer
		Q - Cybernetic Prosthetist
		O - AutoCop]] },
		{ "Tooltrust", [[By default, you don't have tooltrust, you have phystrust, and you have proptrust. Phys- and proptrust give you a physgun and the ability to spawn props respectively. Tooltrust gives you a toolgun.
		
		Basic tooltrust gives you some common simple tools, a slightly increased prop limit, and slightly increased prop spawn permissions. To get this, ask an admin.
		
		Advanced tooltrust gives you most tools, an increased prop limit, and increased prop spawn permissions. Advanced tooltrust users' props are solid, whereas basic and non tooltrusted props are no-collided.
		
		Admins can take away phys and proptrust if you abuse the privillege - you can get it back on the forums.]] },
		{ "PAC Rules", [[PAC is available on this server as a flag.
		
		The use of PAC is a privilege. Find a head model you would like to use in the "Double Barrel - Content Part 3" addon (Workshop), then ask an administrator for the flag and to set your player model to the model you chose. Right click on the spawn icon to copy its model path.
		
		You can find the basic clothing options in "Double Barrel - Content Part 2" at the top of the list as b_torso, b_legs, b_femtorso, etc. (the icons are mostly invisible). Copy the path for the torso model that applies to your character.
		
		In PAC, create a "model" part from the "experimental" category and paste in the torso's path for the model field. To refresh the options, you will have to click on My Outfit and then back to the model you created. Tick the "bonemerge" option to apply it to your character's skeleton. Now you will be able to pick a bodygroup of your choice on the torso. Repeat this process for the legs.
		
		You do not have to use the Double Barrel (Gunsmoke) content if your grasp on PAC is more advanced! Please feel free to be creative. However, abusing PAC will result in the permanent loss of your flag, so read the following carefully:
		
		- If your character does not have a piece of equipment such as a firearm or armor vest, do not use PAC to depict it.
		- Streaming (downloading) some parts is fine, but do not stream a complete character model. This has a high bandwidth overhead and has been identified as a crash cause for players with lower end PCs.
		- Do not open the PAC editor in high traffic areas, and do not open the PAC editor when someone is roleplaying with you. It's obnoxious.
		- PAC has options that may tempt you to be silly. That is fine in certain contexts, but disruption of roleplay caused by unserious PAC outfits will not be tolerated. Use your head.
		
		As long as you use common sense and do not abuse PAC, you are free to customize your character's appearance to your heart's content. Feel free to visually represent augments or prosthetic limbs that may not necessarily be represented in the script, as long as they do not imply an advantage (unless cleared by the admin team).
		
		Enjoy! ]] },
	};

	if( LocalPlayer():IsAdmin() ) then
		
		table.insert( self.HelpContent, { "Admin Commands", [[Press F4 to open the admin menu.
		
		If you want to enter commands manually, below is a list of all admin commands in CombineControl.
		
		Note: In CombineControl, there is no rpa_observe - observe mode is just noclip.
		
		If the command needs a player, you can specify "^" to target yourself and "-" to target the player you're looking at.
		
		rpa_restart - Restart the server.
		rpa_kill [player] - Kill a player.
		rpa_slap [player] - Slap a player.
		rpa_ko [player] - Knock out a player.
		rpa_kick [player] (reason) - Kick a player.
		rpa_ban [player] [time] (reason) - Ban a player. A time of 0 is a permaban.
		rpa_unban [SteamID] - Unban a player.
		rpa_changebanlength [SteamID] [duration] - Change a ban's length for a player.
		rpa_goto [player] - Teleport to a player.
		rpa_bring [player] - Teleport a player to you.
		rpa_namewarn [player] - Give a player a name warning.
		rpa_setname [player] [new name] - Change a player's name.
		rpa_setcharmodel [player] [model] - Change a player's model. You can use citizen IDs ("male_01", for example) instead of the full path.
		rpa_seeall - Toggle admin ESP mode.
		
		rpa_editinventory [player] - Open a character's inventory for editing.
		
		rpa_setcombineflag [player] [flag] - Set a player's police flag.
		rpa_setcharflags [player] [flag(s)] - Set a player's character flags.
		rpa_setcombinesquad [player] [squad] - Set a player's police squad.
		rpa_setcombinesquadid [player] [id #] - Set a player's police ID number.
		rpa_combineroster - See all characters with police flags.
		rpa_flagsroster - See all characters with player flags.
		
		rpa_settooltrust [tt] - Set a player's tooltrust. 0 is none, 1 is basic, 2 is advanced.
		rpa_setphystrust [0/1] - Set a player's phystrust. Default is 1, set to 0 to take away the physgun.
		rpa_setproptrust [0/1] - Set a player's proptrust. Default is 1, set to 0 to take away the ability to spawn props.
		
		rpa_togglesaved - Toggle the prop you're looking at's static property. If static, it will glow pink in SeeAll and will save across restarts.
		
		rpa_playmusic [music/0/1/2] - Play music. 0 is calm, 1 is alert, 2 is action. Alternatively you can specify a song by filename.
		rpa_stopmusic - Stop any playing music.
		rpa_playoverwatch [id] - Play an overwatch line. If you don't enter an id, a list of valid ids and lines will display instead.
		
		rpa_createitem [item] - Spawn an item.
		rpa_givemoney [player] [amount] - Give a player money.
		
		rpa_spawncanister [number headcrabs] [regular/fast/poison] - Send a headcrab canister to wherever you're looking, from behind you.
		rpa_createexplosion - Create an explosion where you're looking at.
		rpa_createfire [duration] - Create a fire where you're looking at.
		
		rpa_stopsound - Stop all playing sounds for everyone.
		
		/ev - Broadcast an IC event.]] } );
		
	end
	
end

function GM:CreateHelpMenu()
	
	self:RefreshHelpMenuContent();
	
	CCP.HelpMenu = vgui.Create( "DFrame" );
	CCP.HelpMenu:SetSize( 800, 600 );
	CCP.HelpMenu:Center();
	CCP.HelpMenu:SetTitle( "Help" );
	CCP.HelpMenu.lblTitle:SetFont( "CombineControl.Window" );
	CCP.HelpMenu:MakePopup();
	CCP.HelpMenu.PerformLayout = CCFramePerformLayout;
	CCP.HelpMenu:PerformLayout();
	function CCP.HelpMenu:Think()
	
		if( input.IsKeyDown( KEY_F1 ) and !self.LastKeyState and self.HasOpened ) then
		
			self:Close();
		
		end
		
		self.LastKeyState = input.IsKeyDown( KEY_F1 );
		if( !self.HasOpened ) then
		
			self.HasOpened = true;
			
		end
		
	end
	
	CCP.HelpMenu.ContentPane = vgui.Create( "DScrollPanel", CCP.HelpMenu );
	CCP.HelpMenu.ContentPane:SetSize( 650, 556 );
	CCP.HelpMenu.ContentPane:SetPos( 140, 34 );
	function CCP.HelpMenu.ContentPane:Paint( w, h )
		
		surface.SetDrawColor( 30, 30, 30, 255 );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( 20, 20, 20, 100 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
	end
	
	CCP.HelpMenu.Content = vgui.Create( "CCLabel" );
	CCP.HelpMenu.Content:SetPos( 10, 10 );
	CCP.HelpMenu.Content:SetSize( 630, 14 );
	CCP.HelpMenu.Content:SetFont( "CombineControl.LabelMedium" );
	CCP.HelpMenu.Content:SetText( "Welcome to the help menu! Press a button on the left to select a topic." );
	CCP.HelpMenu.Content:PerformLayout();
	CCP.HelpMenu.ContentPane:AddItem( CCP.HelpMenu.Content );
	
	local y = 34;
	
	for _, v in pairs( self.HelpContent ) do
		
		local but = vgui.Create( "DButton", CCP.HelpMenu );
		but:SetPos( 10, y );
		but:SetSize( 120, 20 );
		but:SetText( v[1] );
		but:PerformLayout();
		function but:DoClick()
			
			CCP.HelpMenu.Content:SetText( string.gsub( v[2], "\t", "" ) );
			
			CCP.HelpMenu.Content:InvalidateLayout( true );
			CCP.HelpMenu.ContentPane:PerformLayout();
			
		end
		
		y = y + 30;
		
	end
	
end