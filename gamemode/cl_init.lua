MsgC( Color( 200, 200, 200, 255 ), "Loading clientside...\n" );

GM.FullyLoaded = GM.FullyLoaded or false;

if( !CCP ) then
	
	CCP = { }; -- CombineControl Panels.
	
end

include( "sh_enum.lua" );

include( "config/sh_config.lua" );

include( "shared.lua" );

include( "sh_admin.lua" );
include( "sh_animation.lua" );
include( "sh_chat.lua" );
include( "sh_consciousness.lua" );
include( "sh_door.lua" );
include( "sh_entity.lua" );
include( "sh_inventory.lua" );
include( "sh_items.lua" );
include( "sh_flags.lua" );
include( "sh_map.lua" );
include( "sh_mapevents.lua" );
include( "sh_npc.lua" );
include( "sh_player.lua" );
include( "sh_playerclass.lua" );
include( "sh_reload.lua" );
include( "sh_sandbox.lua" );
include( "sh_weapons.lua" );
include( "sh_augments.lua" );
include( "sh_stims.lua" );
include( "cl_admin.lua" );
include( "cl_adminmenu.lua" );
include( "cl_binds.lua" );
include( "cl_charcreate.lua" );
include( "cl_chat.lua" );
include( "cl_context.lua" );
include( "cl_dev.lua" );
include( "cl_drugs.lua" );
include( "cl_help.lua" );
include( "cl_hud.lua" );
include( "cl_map.lua" );
include( "cl_music.lua" );
include( "cl_names.lua" );
include( "cl_npc.lua" );
include( "cl_playermenu.lua" );
include( "cl_scoreboard.lua" );
include( "cl_sql.lua" );
include( "cl_think.lua" );
include( "cl_weaponselect.lua" );
include( "cl_stockpiles.lua" );
include( "cl_augments.lua" );
include( "cl_stims.lua" );

include( "gui/skin.lua" );
include( "gui/ccarea.lua" );
include( "gui/cccamera.lua" );
include( "gui/ccchat.lua" );
include( "gui/ccframe.lua" );
include( "gui/cclabel.lua" );
include( "gui/ccprogbar.lua" );
include( "gui/cctree.lua" );
include( "gui/cctree_node.lua" );
include( "gui/cctree_node_button.lua" );

function GM:Initialize()
	
	RunConsoleCommand( "cl_showhints", "0" );
	RunConsoleCommand( "gmod_mcore_test", "1" );
	
	self:LoadMOTD();
	
end

function GM:OnGamemodeLoaded()
	
	self:LoadWeaponItems();
	self:LoadBooks();
	
end

function GM:InitPostEntity()
	
	net.Start( "nRequestPData" );
	net.SendToServer();
	net.Start("nRequestAugments")
	net.SendToServer()
	if cookie.GetNumber( "cc_thirdperson", 0 ) == 1 then
	
		ctp:Enable();
	
	end
	
end

local meta = FindMetaTable( "Player" );

function meta:GetCharFromID( id )

	for _, v in pairs( GAMEMODE.Characters ) do
		
		if( tonumber( v.id ) == id ) then
			
			return v;
			
		end
		
	end
	
end

net.Receive( "RequestServerTransfer", function( len )

	if( GAMEMODE.ServerTransfer and IsValid( GAMEMODE.ServerTransfer ) ) then return end

	local transition = net.ReadString();
	local server = net.ReadString();
	local password = net.ReadString();
	
	GAMEMODE.ServerTransfer = Derma_Query( Format( "Are you sure you'd like to go to %s?", transition ), transition, "Yes", function()
	
		LocalPlayer():ConCommand( "password "..password.."\n" );
		LocalPlayer():ConCommand( "connect "..server.."\n" );
	
	end, "No" );

end );

if( LiteGibs ) then

	LiteGibs.SetupMenu = function()
	
	end
	
end

GM.FullyLoaded = true;

MsgC( Color( 200, 200, 200, 255 ), "Clientside loaded.\n" );