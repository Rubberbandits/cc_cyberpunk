local meta = FindMetaTable( "Player" );

if( !mysqloo ) then
	
	require( "mysqloo" );
	
end

function GM:RunQueue()

	for k, v in pairs( self.SQLQueue ) do
		
		timer.Simple( 0.01 * ( k - 1 ), function()
			
			mysqloo.Query( v[1], v[2] );
			
		end );
		
	end
	
	self.SQLQueue = { };

end

GM.PreparedQueries = {
	["NEW_CHARACTER"] = [[
		INSERT INTO cc_chars ( SteamID, 
		RPName, 
		TitleOne, 
		TitleTwo, 
		Title, 
		Model, 
		Trait, 
		CID, 
		Date, 
		PDAName, 
		Inventory, 
		Augments, 
		Money,
		Skingroup,
		Bodygroups,
		StatStrength, 
		StatPerception, 
		StatEndurance,
		StatCharisma,
		StatIntelligence,
		StatAgility,
		StatLuck ) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? );
	]]
};

function GM:InitSQL()
	
	if( !CCSQL ) then
		
		self.SQLQueue = { };
		
	end
	
	CCSQL = mysqloo.connect( self.MySQLHost, self.MySQLUser, self.MySQLPass, self.MySQLDB, self.MySQLPort );
	
	function CCSQL:onConnected()
		
		MsgC( Color( 200, 200, 200, 255 ), "MySQL successfully connected to " .. self:hostInfo() .. ".\nMySQL server version: " .. self:serverInfo() .. "\n" );
		GAMEMODE.NoMySQL = false;
		
		GAMEMODE:InitSQLTables();
		
		for k, v in pairs( GAMEMODE.SQLQueue ) do
			
			timer.Simple( 0.01 * ( k - 1 ), function()
				
				mysqloo.Query( v[1], v[2] );
				
			end );
			
		end
		
		for k,v in next, GAMEMODE.PreparedQueries do
		
			_G["Cyberpunk."..k] = self:prepare(v);
			
		end
		
		GAMEMODE.SQLQueue = { };
		
		mysqloo.Query( "SET interactive_timeout = 28800" );
		mysqloo.Query( "SET wait_timeout = 28800" );
		
	end

	function CCSQL:onConnectionFailed( err )
		
		GAMEMODE:LogBug( "ERROR: MySQL connection failed (\"" .. err .. "\")." );
		GAMEMODE.NoMySQL = true;
		
		if( string.find( err, "Unknown MySQL server host" ) ) then return end
		
		GAMEMODE:InitSQL();
		
	end

	CCSQL:connect();
	
end

function mysqloo.Query( q, cb, cbe, noerr )
	
	if( GAMEMODE.NoMySQL ) then
		
		cb( { } );
		return;
		
	end
	
	local qo = CCSQL:query( q );
	
	if( !qo ) then
		
		table.insert( GAMEMODE.SQLQueue, { q, cb } );
		CCSQL:abortAllQueries();
		CCSQL:connect();
		return;
		
	end
	
	function qo:onSuccess( ret )
		
		if( cb ) then
			
			cb( ret, qo );
			
		end
		
	end
	
	function qo:onError( err )
		
		if( CCSQL:status() == mysqloo.DATABASE_NOT_CONNECTED ) then
			
			table.insert( GAMEMODE.SQLQueue, { q, cb } );
			GAMEMODE:RunQueue();
			return;
			
		end
		
		if( err == "MySQL server has gone away" ) then
			
			table.insert( GAMEMODE.SQLQueue, { q, cb } );
			GAMEMODE:RunQueue();
			return;
			
		end
		
		if( string.find( err, "Lost connection to MySQL server" ) ) then
			
			table.insert( GAMEMODE.SQLQueue, { q, cb } );
			GAMEMODE:RunQueue();
			return;
			
		end
		
		if( cbe ) then
			
			cbe( err, qo );
			
		end
		
		if( !noerr ) then
			
			GAMEMODE:LogBug( "ERROR: MySQL query \"" .. q .. "\" failed (\"" .. err .. "\")." );
			
		end
		
	end
	
	qo:start();
	
end

function mysqloo.Escape( s )
	
	if( !s ) then return "" end
	
	return CCSQL:escape( s );
	
end

local CharTable = {
	{ "SteamID", "VARCHAR(30)" },
	{ "RPName", "VARCHAR(100)" },
	{ "Model", "VARCHAR(100)" },
	{ "Title", "VARCHAR(8192)", "" },
	{ "TitleOne", "TEXT", "" },
	{ "TitleTwo", "TEXT", "" },
	{ "Inventory", "VARCHAR(2048)", "{\"onduty\":[],\"offduty\":[]}" },
	{ "Money", "INT", "100" },
	{ "Trait", "INT", TRAIT_NONE },
	{ "StatStrength", "FLOAT", "0" },
	{ "StatPerception", "FLOAT", "0" },
	{ "StatEndurance", "FLOAT", "0" },
	{ "StatCharisma", "FLOAT", "0" },
	{ "StatIntelligence", "FLOAT", "0" },
	{ "StatAgility", "FLOAT", "0" },
	{ "StatLuck", "FLOAT", "0" },
	{ "PDAName", "VARCHAR(128)", "" },
	{ "Loan", "INT", "0" },
	{ "BusinessLicenses", "VARCHAR(20)", "" },
	{ "CID", "INT", "0" },
	{ "CombineFlag", "VARCHAR(1)", "" },
	{ "CharFlags", "VARCHAR(10)", "" },
	{ "CombineSquad", "VARCHAR(20)", "" },
	{ "CombineSquadID", "FLOAT", "0" },
	{ "CriminalRecord", "VARCHAR(2048)", "" },
	{ "Hunger", "FLOAT", "0" },
	{ "CPRationDate", "VARCHAR(20)", "" },
	{ "Date", "VARCHAR(20)", "" },
	{ "LastOnline", "VARCHAR(20)", "" },
	{ "Location", "FLOAT", "1" },
	{ "EntryPort", "FLOAT", "1" },
	{ "Stockpile", "VARCHAR(2048)", "{}" },
	{ "Augments", "VARCHAR(2048)", "{}" },
	{ "Skingroup", "INT", "0" },
	{ "Bodygroups", "VARCHAR(2048)", "{}" },
	{ "SalaryInterval", "INT", "0" },
	{ "SalaryAmount", "INT", "0" },
};

local PlayerTable = {
	{ "LastName", "VARCHAR(128)", "" },
	{ "ToolTrust", "INT", "0" },
	{ "PhysTrust", "INT", "1" },
	{ "PropTrust", "INT", "1" },
	{ "NewbieStatus", "INT", NEWBIE_STATUS_NEW },
	{ "DonationAmount", "DOUBLE", "0" },
	{ "CustomMaxProps", "INT", "0" },
	{ "CustomMaxRagdolls", "INT", "0" },
	{ "ScoreboardTitle", "VARCHAR(100)", "" },
	{ "ScoreboardTitleC", "VARCHAR(100)", "200 200 200" },
	{ "ScoreboardBadges", "INT", "0" },
	{ "PlayerFlags", "VARCHAR(128)", "" },
};

local BansTable = {
	{ "Length", "INT" },
	{ "Reason", "VARCHAR(512)", "" },
	{ "Date", "VARCHAR(20)" }
};

local StockpileTable = {
	{ "Accessors", "TEXT" },
	{ "Inventory", "TEXT" },
	{ "Name", "TEXT" }
};

function GM:InitSQLTable( tab, dtab )
	
	for _, v in pairs( tab ) do
		
		local function qS()
			
			-- self:LogSQL( "Column \"" .. v[1] .. "\" already exists in table " .. dtab .. "." );
			
		end
		
		local function qF( err )
			
			if( string.find( string.lower( err ), "unknown column" ) ) then
				
				self:LogSQL( "Column \"" .. v[1] .. "\" does not exist in table " .. dtab .. ", creating..." );
				
				local q = "ALTER TABLE " .. dtab .. " ADD COLUMN " .. v[1] .. " " .. v[2] .. " NOT NULL";
				
				if( v[3] ) then
					
					q = q .. " DEFAULT '" .. tostring( v[3] ) .. "'";
					
				end
				
				mysqloo.Query( q );
				
			end
			
		end
		
		mysqloo.Query( "SELECT " .. v[1] .. " FROM " .. dtab, qS, qF, true );
		
	end
	
end

function GM:InitSQLTables()
	
	mysqloo.Query( "CREATE TABLE IF NOT EXISTS cc_chars ( id INT NOT NULL auto_increment, PRIMARY KEY ( id ) );" );
	mysqloo.Query( "CREATE TABLE IF NOT EXISTS cc_players ( SteamID VARCHAR(30) NOT NULL, PRIMARY KEY ( SteamID ) );" );
	mysqloo.Query( "CREATE TABLE IF NOT EXISTS cc_bans ( id INT NOT NULL auto_increment, SteamID VARCHAR(30) NOT NULL, PRIMARY KEY ( id ) );" );
	mysqloo.Query( "CREATE TABLE IF NOT EXISTS cc_stockpiles ( id INT NOT NULL auto_increment, PRIMARY KEY ( id ) );" );

	self:InitSQLTable( CharTable, "cc_chars" );
	self:InitSQLTable( PlayerTable, "cc_players" );
	self:InitSQLTable( BansTable, "cc_bans" );
	self:InitSQLTable( StockpileTable, "cc_stockpiles" );
	
end

function GM:DumpSQL( t )
	
	if( !t ) then return end
	
	local function qS( ret )
		
		MsgC( Color( 200, 200, 200, 255 ), "Dumping table...\n" );
		
		if( ret ) then
			
			PrintTable( ret );
			
		end
		
		MsgC( Color( 200, 200, 200, 255 ), "Finished dumping table.\n" );
		
	end
	
	MsgC( Color( 200, 200, 200, 255 ), "Loading table " .. t .. "...\n" );
	mysqloo.Query( "SELECT * FROM " .. t, qS );
	
end

function GM:PurgeSQL()
	
	local function qS( ret )
		
		GAMEMODE:LogSQL( "SQL has been purged." );
		
		game.ConsoleCommand( "changelevel " .. game.GetMap() .. "\n" );
		
	end
	
	local function qF( err )
		
		self:PurgeSQL();
		
	end
	
	mysqloo.Query( "DROP TABLE cc_chars;", qS, qF );
	
end

function GM:LoadBans()
	
	local function qS( ret )
		
		local nBans = #ret;
		
		self:LogSQL( "Banlist successfully retrieved. " .. nBans .. " entries loaded." );
		self.BanTable = ret;
		
		for k, v in pairs( self.BanTable ) do
			
			if( v.Length > 0 and util.TimeSinceDate( v.Date ) > v.Length ) then
				
				table.remove( self.BanTable, k );
				self:RemoveBan( v.SteamID, "time's up" );
				
			end
			
		end
		
	end
	
	local function qF( err )
		
		self:LoadBans();
		
	end
	
	mysqloo.Query( "SELECT * FROM cc_bans", qS, qF );
	
end

function GM:AddBan( steam, len, reason, t )
	
	local function qS( ret )
		
		self:LogSQL( "Banned SteamID " .. steam .. " for " .. len .. " minutes (" .. reason .. ")." );
		
	end
	
	local function qF( err )
		
		self:AddBan( steam, len, mysqloo.Escape( reason ), t );
		
	end
	
	mysqloo.Query( "INSERT INTO cc_bans ( SteamID, Length, Reason, Date ) VALUES ( '" .. steam .. "', '" .. len .. "', '" .. mysqloo.Escape( reason ) .. "', '" .. t .. "' )", qS, qF );
	
end

function GM:RemoveBan( steam, r )
	
	local function qS( ret )
		
		self:LogSQL( "Unbanned SteamID " .. steam .. ": " .. r .. "." );
		
	end
	
	local function qF( err )
		
		self:RemoveBan( steam, r );
		
	end
	
	mysqloo.Query( "DELETE FROM cc_bans WHERE SteamID = '" .. steam .. "'", qS, qF );
	
end

function GM:LookupBan( steam )
	
	if( !GAMEMODE.BanTable ) then GAMEMODE.BanTable = { } end
	
	for k, v in pairs( self.BanTable ) do
		
		if( v.SteamID == steam ) then
			
			return k;
			
		end
		
	end
	
end

function meta:SQLSaveNewPlayer()
	
	local function qS( ret )
		
		GAMEMODE:LogSQL( "Created new player record for user " .. self:Nick() .. "." );
		
		local tab = { };
		
		for _, v in pairs( PlayerTable ) do
			
			if( v[3] ) then
				
				tab[v[1]] = tostring( v[3] );
				
			end
			
		end
		
		tab["SteamID"] = self:SteamID();
		
		self.SQLPlayerData = tab;
		
		self:LoadPlayer( self.SQLPlayerData );
		
		self:LoadCharsInfo();
		
	end
	
	GAMEMODE:LogSQL( "Creating new player record for user " .. self:Nick() .. "..." );
	mysqloo.Query( "INSERT INTO cc_players ( SteamID ) VALUES ( '" .. self:SteamID() .. "' )", qS );
	
end

function meta:PostLoadCharsInfo()
	
	if( self:SQLGetNumChars() > 0 ) then
		
		net.Start( "nCharacterList" );
			net.WriteTable( self.SQLCharData );
		net.Send( self );
		
		net.Start( "nOpenCharCreate" );
			
			if( GAMEMODE.CurrentLocation and GAMEMODE.CurrentLocation != LOCATION_CITY ) then
				net.WriteUInt( CC_SELECT, 3 );
			else
				if( self:SQLGetNumChars() < GAMEMODE.MaxCharacters ) then
					net.WriteUInt( CC_CREATESELECT, 3 );
				else
					net.WriteUInt( CC_SELECT, 3 );
				end
			end
		net.Send( self );
		
	else
		
		if( GAMEMODE.CurrentLocation and GAMEMODE.CurrentLocation != LOCATION_CITY ) then
			
			net.Start( "nConnect" );
				net.WriteString( IP_GENERAL .. PORT_CITY );
			net.Send( self );
			return;
			
		end
		
		net.Start( "nOpenCharCreate" );
			net.WriteUInt( CC_CREATE, 3 );
		net.Send( self );
		
	end
	
end

function meta:PostLoadPlayerInfo()
	
	net.Start( "nIntroStart" );
		net.WriteBit( false );
	net.Send( self );
	
	if( !self:SQLHasPlayer() ) then
		
		self:SQLSaveNewPlayer();
		
	else
		
		self:LoadPlayer( self.SQLPlayerData );
		self:LoadCharsInfo();
		
	end
	
	self:UpdateCharacterField( "LastName", self:Nick() );
	
end

function meta:LoadCharsInfo()
	
	local function qS( ret )
		
		self.SQLCharData = ret;
		self:PostLoadCharsInfo();
		
	end
	
	local function qF( err )
		
		self.SQLCharData = { };
		self:PostLoadCharsInfo();
		
	end
	
	mysqloo.Query( "SELECT * FROM cc_chars WHERE SteamID = '" .. self:SteamID() .. "'", qS, qF );
	
end

function meta:LoadPlayerInfo()
	
	local function qS( ret )
		
		self.SQLPlayerData = ret[1];
		self:PostLoadPlayerInfo();
		
	end
	
	local function qF( err )
		
		self.SQLPlayerData = { };
		self:PostLoadPlayerInfo();
		
	end
	
	mysqloo.Query( "SELECT * FROM cc_players WHERE SteamID = '" .. self:SteamID() .. "'", qS, qF );
	
end

function meta:SQLCharExists( id )
	
	for _, v in pairs( self.SQLCharData ) do
		
		if( tonumber( v.id ) == id ) then
			
			return true;
			
		end
		
	end
	
	return false;
	
end

function meta:SQLHasPlayer()
	
	return self.SQLPlayerData and table.Count( self.SQLPlayerData ) > 0;
	
end

function meta:SQLGetNumChars()
	
	if( !self.SQLCharData ) then return 0 end
	
	return #self.SQLCharData;
	
end

function meta:GetCharFromID( id )
	
	for _, v in pairs( self.SQLCharData ) do
		
		if( tonumber( v.id ) == id ) then
			
			return v;
			
		end
		
	end
	
end

function meta:GetCharIndexFromID( id )
	
	for k, v in pairs( self.SQLCharData ) do
		
		if( tonumber( v.id ) == id ) then
			
			return k;
			
		end
		
	end
	
end

function meta:SaveNewCharacter( name, title, titleone, titletwo, model, traits, stats, skin, bodygroups )
	
	local cid = math.random( 1, 99999 );
	local d = os.date( "!%m/%d/%y %H:%M:%S" );
	
	local trait = 0;
	for k,v in next, traits do
		
		trait = trait + k;
		
	end
	
	_G["Cyberpunk.NEW_CHARACTER"].onSuccess = function( qo, ret )
		
		GAMEMODE:LogSQL( "Player " .. self:Nick() .. " created character " .. name .. "." );
		
		local tab = { };
		
		for _, v in pairs( CharTable ) do
			
			if( v[3] ) then
				
				tab[v[1]] = tostring( v[3] );
				
			end
			
		end
		
		tab["SteamID"] = self:SteamID();
		tab["RPName"] = name;
		tab["PDAName"] = name;
		tab["Title"] = util.TableToJSON( { ["onduty"] = "", ["offduty"] = title } );
		tab["TitleOne"] = util.TableToJSON( { ["onduty"] = "", ["offduty"] = titleone } );
		tab["TitleTwo"] = util.TableToJSON( { ["onduty"] = "", ["offduty"] = titletwo } );
		tab["Stockpile"] = "[]";
		tab["Model"] = model;
		tab["Money"] = 100;
		if( bit.band( trait, TRAIT_INVESTOR ) == TRAIT_INVESTOR ) then
		
			tab["Money"] = 1000;
			
		end
		tab["Skingroup"] = skin;
		tab["Trait"] = trait;
		tab["Augments"] = "{}";
		tab["Bodygroups"] = util.TableToJSON( bodygroups );
		tab["CID"] = tostring( cid );
		tab["Date"] = d;
		tab["LastOnline"] = d;
		
		if( bit.band( trait, TRAIT_LOYALIST ) == TRAIT_LOYALIST ) then
			
			tab["Inventory"] = "{\"onduty\":[],\"offduty\":[\"radio\"]}";
			
		end
		
		local augments = {};
		if( bit.band( trait, TRAIT_NOCORTICAL ) != TRAIT_NOCORTICAL ) then
		
			augments["corticalstack"] = true;
		
		end
		if( bit.band( trait, TRAIT_VETERAN ) == TRAIT_VETERAN ) then
		
			augments["diffusor"] = true;
			
		end
		
		tab["Augments"] = util.TableToJSON( augments ) or "{}";
		
		for k, v in pairs( stats ) do
		
			local number = v;
			for m,n in next, GAMEMODE.Traits do
			
				if( bit.band( trait, m ) == m and n[5] ) then
				
					if( n[5][k] ) then
			
						number = math.Clamp( number + n[5][k], 1, 10 );
						
					end
					
				end
				
			end
			
			tab["Stat" .. k] = number;
			
		end
		
		tab["id"] = tonumber( qo:lastInsert() );
		
		table.insert( self.SQLCharData, tab );
		
		net.Start( "nCharacterList" );
			net.WriteTable( self.SQLCharData );
		net.Send( self );
		
		self:LoadCharacter( tab );
		
	end
	
	local augments = {};
	if( bit.band( trait, TRAIT_NOCORTICAL ) != TRAIT_NOCORTICAL ) then
	
		augments["corticalstack"] = true;
	
	end
	if( bit.band( trait, TRAIT_VETERAN ) == TRAIT_VETERAN ) then
	
		augments["diffusor"] = true;
		
	end
	
	local inventory = "{\"onduty\":[],\"offduty\":[]}";
	if( bit.band( trait, TRAIT_LOYALIST ) == TRAIT_LOYALIST ) then
		
		inventory = "{\"onduty\":[],\"offduty\":[\"radio\"]}";
		
	end
	
	local money = 100;
	if( bit.band( trait, TRAIT_INVESTOR ) == TRAIT_INVESTOR ) then
	
		money = 1000;
	
	end
	
	local realStats = {};
	for k, v in pairs( stats ) do
	
		local number = v;
		for m,n in next, GAMEMODE.Traits do
		
			if( bit.band( trait, m ) == m and n[5] ) then
			
				if( n[5][k] ) then
		
					number = math.Clamp( number + n[5][k], 1, 10 );
					
				end
				
			end
			
		end
		
		realStats[k] = number;
		
	end
	
	_G["Cyberpunk.NEW_CHARACTER"]:setString( 1, self:SteamID() );
	_G["Cyberpunk.NEW_CHARACTER"]:setString( 2, name );
	_G["Cyberpunk.NEW_CHARACTER"]:setString( 3, util.TableToJSON( { ["onduty"] = "", ["offduty"] = titleone } ) );
	_G["Cyberpunk.NEW_CHARACTER"]:setString( 4, util.TableToJSON( { ["onduty"] = "", ["offduty"] = titletwo } ) );
	_G["Cyberpunk.NEW_CHARACTER"]:setString( 5, util.TableToJSON( { ["onduty"] = "", ["offduty"] = title } ) );
	_G["Cyberpunk.NEW_CHARACTER"]:setString( 6, model );
	_G["Cyberpunk.NEW_CHARACTER"]:setString( 7, tostring( trait ) );
	_G["Cyberpunk.NEW_CHARACTER"]:setString( 8, tostring( cid ) );
	_G["Cyberpunk.NEW_CHARACTER"]:setString( 9, d );
	_G["Cyberpunk.NEW_CHARACTER"]:setString( 10, name );
	_G["Cyberpunk.NEW_CHARACTER"]:setString( 11, inventory );
	_G["Cyberpunk.NEW_CHARACTER"]:setString( 12, util.TableToJSON( augments ) or "{}" );
	_G["Cyberpunk.NEW_CHARACTER"]:setString( 13, tostring( money ) );
	_G["Cyberpunk.NEW_CHARACTER"]:setNumber( 14, skin );
	_G["Cyberpunk.NEW_CHARACTER"]:setString( 15, util.TableToJSON( bodygroups ) or "{}" );
	_G["Cyberpunk.NEW_CHARACTER"]:setNumber( 16, realStats["Strength"] );
	_G["Cyberpunk.NEW_CHARACTER"]:setNumber( 17, realStats["Perception"] );
	_G["Cyberpunk.NEW_CHARACTER"]:setNumber( 18, realStats["Endurance"] );
	_G["Cyberpunk.NEW_CHARACTER"]:setNumber( 19, realStats["Charisma"] );
	_G["Cyberpunk.NEW_CHARACTER"]:setNumber( 20, realStats["Intelligence"] );
	_G["Cyberpunk.NEW_CHARACTER"]:setNumber( 21, realStats["Agility"] );
	_G["Cyberpunk.NEW_CHARACTER"]:setNumber( 22, realStats["Luck"] );
	_G["Cyberpunk.NEW_CHARACTER"]:start();
	
end

function GM:DeleteCharacter( id, deleter, name )
	
	local function qS()
		
		GAMEMODE:LogSQL( "Player " .. deleter .. " deleted character " .. name .. "." );
		
	end
	
	mysqloo.Query( "DELETE FROM cc_chars WHERE id = '" .. tostring( id ) .. "'", qS );
	
end

function meta:DeleteCharacter( id, name )
	
	for k, v in pairs( self.SQLCharData ) do
		
		if( v.id == id ) then
			
			table.remove( self.SQLCharData, k );
			
		end
		
	end
	
	local function qS()
		
		GAMEMODE:LogSQL( "Player " .. self:Nick() .. " deleted character " .. name .. "." );
		
	end
	
	mysqloo.Query( "DELETE FROM cc_chars WHERE id = '" .. tostring( id ) .. "'", qS );
	
end

function meta:UpdateCharacterField( field, value, nolog, novalueescape )
	
	if( self:IsBot() ) then return end
	if( self:CharID() == -1 ) then return end
	
	if( self.SQLCharData[self:GetCharIndexFromID( self:CharID() )][field] == tostring( value ) ) then return end
	
	local q = "UPDATE cc_chars";
	q = q .. " SET " .. mysqloo.Escape( field );
	if( !novalueescape ) then
	
		q = q .. " = '" .. mysqloo.Escape( tostring( value ) );
		
	else
	
		q = q .. " = '" .. tostring( value );
	
	end
	q = q .. "' WHERE id = '" .. self:CharID() .. "'";
	
	local function qS( ret )
		
		if( !nolog ) then
			
			GAMEMODE:LogSQL( "Player " .. self:Nick() .. " (" .. self:RPName() .. ") updated character field " .. field .. " to " .. tostring( value ) .. "." );
			
		end
		
		self.SQLCharData[self:GetCharIndexFromID( self:CharID() )][field] = tostring( value );
		
	end
	
	mysqloo.Query( q, qS );
	
end

function GM:UpdateCharacterFieldOffline( id, field, value, nolog )
	
	local q = "UPDATE cc_chars";
	q = q .. " SET " .. mysqloo.Escape( field );
	q = q .. " = '" .. mysqloo.Escape( tostring( value ) );
	q = q .. "' WHERE id = '" .. id .. "'";
	
	local function qS( ret )
		
		if( !nolog ) then
			
			GAMEMODE:LogSQL( "Character " .. id .. " updated character field " .. field .. " to " .. tostring( value ) .. "." );
			
		end
		
	end
	
	mysqloo.Query( q, qS );
	
	for _, v in pairs( player.GetAll() ) do
		
		if( v.SQLCharData["id"] == id ) then
			
			v.SQLCharData[field] = value;
			
		end
		
	end
	
end

function GM:AddCharacterFieldOffline( id, field, value, min, max )
	
	local q = "SELECT " .. field .. " FROM cc_chars WHERE id = '" .. id .. "'";
	
	local function qS( ret )
		
		local q = "UPDATE cc_chars";
		q = q .. " SET " .. mysqloo.Escape( field );
		q = q .. " = '" .. mysqloo.Escape( tostring( math.Clamp( tonumber( ret[1][field] ) + tonumber( value ), min or -math.huge, max or math.huge ) ) );
		q = q .. "' WHERE id = '" .. id .. "'";
		
		local function qS( ret )
			
			GAMEMODE:LogSQL( "Character " .. id .. " updated character field " .. field .. " to " .. tostring( value ) .. "." );
			
		end
		
		mysqloo.Query( q, qS );
		
	end
	
	mysqloo.Query( q, qS );
	
end

function meta:UpdatePlayerField( field, value )
	
	local q = "UPDATE cc_players";
	q = q .. " SET " .. mysqloo.Escape( field );
	q = q .. " = '" .. mysqloo.Escape( tostring( value ) );
	q = q .. "' WHERE SteamID = '" .. self:SteamID() .. "'";
	
	local function qS( ret )
		
		GAMEMODE:LogSQL( "Player " .. self:Nick() .. " (" .. self:RPName() .. ") updated player field " .. field .. " to " .. tostring( value ) .. "." );
		
		self.SQLPlayerData[field] = tostring( value );
		
	end
	
	mysqloo.Query( q, qS );
	
end

function GM:UpdatePlayerFieldOffline( steamid, field, value )
	
	local q = "UPDATE cc_players";
	q = q .. " SET " .. mysqloo.Escape( field );
	q = q .. " = '" .. mysqloo.Escape( tostring( value ) );
	q = q .. "' WHERE SteamID = '" .. steamid .. "'";
	
	local function qS( ret )
		
		GAMEMODE:LogSQL( "Player " .. steamid .. " updated player field " .. field .. " to " .. tostring( value ) .. "." );
		
	end
	
	mysqloo.Query( q, qS );
	
end

function GM:SQLThink()
	
end