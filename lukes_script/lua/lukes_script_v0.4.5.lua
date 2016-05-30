---Luke's Script V2 --
--  Yes, this is a hack, not a fun pack, I know - Dank Beets is a litte bit silly. 
--  TODO:
--      Make everything 'luke.g.<whatever>',
--      Remove the crappy 'norecoil' / 'nospread',
--      Check with valve / facepuch whether lua bypassers are okay,
--      Place all the minor hack peices into plugins, --DONE
--      render.DrawLine() sucks.
--      Learn more GLua

--      A 1/3 of the code here belongs to Lenny, but ya'know
---------------------------------------------------------------------------------

include("plugins/dankBeets.lua")         -- Dank Beet (a bit of fun)
include("plugins/lukeGui.lua")           -- Luke GUI
include("plugins/lukeHUD.lua")           -- Luke HUD
include("plugins/lukeEsp.lua")           -- Luke ESP, improved
include("plugins/lukeWalls.lua")         -- Luke Walls, laggy - needs material changing instead
include("plugins/lukeRapidFire.lua")     -- Luke Rapidfire
include("plugins/lukeBhop.lua")          -- Luke Bhop
include("plugins/lukeRemoved.lua")       -- All removed peices

local luke = {}
luke.allowPlugins = true
local g = table.Copy( _G )
luke.dankBeets = table.Copy( dankBeets )

luke.rainbow = function ( msg )
	g.MsgC(Color(math.random(1, 255), math.random(1, 255), math.random(1,255)), msg)
end

surface.CreateFont( "lukefont", {
	font = "Verdana",
	extended = false,
	size = 15,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )
surface.CreateFont("lukefont2", {20, 500, true, true, "fonts/Walkway_Black.ttf"} )

local function cvar_running( cvar_ )
	if cvar_:GetString() == "1" then
		g.MsgC( Color( 255, 255, 255), cvar_:GetName() .. " - " )
		g.MsgC( Color( 0, 0, 255), cvar_:GetString() )
		g.MsgC( Color( 255, 255, 255 ), "\n" )
	elseif cvar_:GetString() == "0" then
		g.MsgC( Color( 255, 255, 255), cvar_:GetName() .. " - " )
		g.MsgC( Color( 255, 0, 0), cvar_:GetString() )
		g.MsgC( Color( 255, 255, 255 ), "\n" )
	end
end

if CLIENT then
	if (luke.allowPlugins == true) then g.MsgC(Color(255,255,0), luke.dankBeets.dank_beets_title .. "\n") end
	luke.rainbow("------------------------\n")
	g.MsgC(Color(0,255,255), "Luke's Script Running...\n")
	g.MsgC(Color(255,255,255), "Your ingame nick is: ")
	g.MsgC(Color(0,0,255), LocalPlayer():GetName()) 
	g.MsgC(Color(255,255,255), "\n")
	g.MsgC(Color(255,255,255), "Use luke_gui to open the settings.\n")
	g.MsgC(Color(255,255,255), "Use luke_music to set music option. (REQUIRES Dank Beets)\n")
	g.MsgC(Color(255,255,255), "Use luke_music_play to play music option. (REQUIRES Dank Beets)\n")
	cvar_running( GetConVar("luke_bhop") )
	cvar_running( GetConVar("luke_strafe") )
	cvar_running( GetConVar("luke_rapidfire") )
	cvar_running( GetConVar("luke_esp") )
	cvar_running( GetConVar("luke_walls") )
	cvar_running( GetConVar("luke_esp_printers") )
	cvar_running( GetConVar("luke_hud") )
	g.MsgC(Color(255,0,0), "luke_norecoil has been removed\n")
	g.MsgC(Color(255,0,0), "luke_nospread has been removed\n")
	luke.rainbow("------------------------\n")
	if (luke.allowPlugins == true) then luke.dankBeets.wavSound("loaded") end
end