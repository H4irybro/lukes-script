---Luke's Script V2 --
--  Yes, this is a hack, not a fun pack, I know - Dank Beets is a litte bit silly. 
--  TODO:
--      Make everything 'luke.g.<whatever>',
--      Remove the crappy 'norecoil' / 'nospread',
--      Check with valve / facepuch whether lua bypassers are okay,
--      Place all the minor hack peices into plugins, --Working on it
--      render.DrawLine() sucks.
--      Learn more GLua

--      A 1/3 of the code here belongs to Lenny, but ya'know
---------------------------------------------------------------------------------

include("plugins/dankBeets.lua")
include("plugins/lukeGui.lua")
include("plugins/lukeHUD.lua")
include("plugins/lukeEsp.lua")
include("plugins/lukeWalls.lua")
include("plugins/lukeRapidFire.lua")
include("plugins/lukeBhop.lua")
include("plugins/lukeRemoved.lua")

local luke = {}
luke.g = table.Copy( _G )
luke.dankBeets = table.Copy( dankBeets )
luke.allowPlugins = true


luke.rainbow = function ( msg )
	luke.g.MsgC(Color(math.random(1, 255), math.random(1, 255), math.random(1,255)), msg)
end

luke.g.surface.CreateFont( "lukefont", {
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
luke.g.surface.CreateFont("lukefont2", {20, 500, true, true, "fonts/Walkway_Black.ttf"} )

local function cvar_running( cvar_ )
	if cvar_:GetString() == "1" then
		luke.g.MsgC( Color( 255, 255, 255), cvar_:GetName() .. " - " )
		luke.g.MsgC( Color( 0, 0, 255), cvar_:GetString() )
		luke.g.MsgC( Color( 255, 255, 255 ), "\n" )
	elseif cvar_:GetString() == "0" then
		luke.g.MsgC( Color( 255, 255, 255), cvar_:GetName() .. " - " )
		luke.g.MsgC( Color( 255, 0, 0), cvar_:GetString() )
		luke.g.MsgC( Color( 255, 255, 255 ), "\n" )
	end
end

if CLIENT then
	if (luke.allowPlugins == true) then luke.g.MsgC(Color(255,255,0), luke.dankBeets.Title() .. "\n") end
	luke.rainbow("------------------------\n")
	luke.g.MsgC(Color(0,255,255), "Luke's Script Running...\n")
	luke.g.MsgC(Color(255,255,255), "Your ingame nick is: ")
	luke.g.MsgC(Color(0,0,255), LocalPlayer():GetName()) 
	luke.g.MsgC(Color(255,255,255), "\n")
	luke.g.MsgC(Color(255,255,255), "Use luke_gui to open the settings.\n")
	luke.g.MsgC(Color(255,255,255), "Use luke_music to set music option. (REQUIRES Dank Beets)\n")
	luke.g.MsgC(Color(255,255,255), "Use luke_music_play to play music option. (REQUIRES Dank Beets)\n")
	cvar_running( luke.g.GetConVar("luke_bhop") )
	cvar_running( luke.g.GetConVar("luke_strafe") )
	cvar_running( luke.g.GetConVar("luke_rapidfire") )
	cvar_running( luke.g.GetConVar("luke_esp") )
	cvar_running( luke.g.GetConVar("luke_walls") )
	cvar_running( luke.g.GetConVar("luke_esp_printers") )
	cvar_running( luke.g.GetConVar("luke_hud") )
	luke.g.MsgC(Color(255,0,0), "luke_norecoil has been removed\n")
	luke.g.MsgC(Color(255,0,0), "luke_nospread has been removed\n")
	luke.rainbow("------------------------\n")
	if (luke.allowPlugins == true) then luke.dankBeets.wavSound("loaded") end
end