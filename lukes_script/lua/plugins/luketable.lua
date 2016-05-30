luke = {}
luke.g = table.Copy( _G ) // Attempt at hiding the scripts?

luke.getconvar = function ( c_name )
	if ( !luke.g.ConVarExists( c_name ) ) then return end
	return luke.g.GetConVar( c_name )
end
luke.setconvar = function ( c_name, c_value )
	if ( !luke.g.ConVarExists( c_name ) ) then return end
	luke.g.RunConsoleCommand( c_name, c_value )
end
luke.makeconvar = function ( c_name, c_value )
	if ( luke.g.ConVarExists( c_name ) ) then return end
	luke.g.CreateClientConVar( c_name, c_value )
end
luke.includeAll = function ()
	include("dankbeets.lua")
	include("lukegui.lua")
	include("lukehUD.lua")
	include("lukeesp.lua")
	include("lukewalls.lua")
	include("lukerapidFire.lua")
	include("lukebhop.lua")
	include("lukeremoved.lua")
end
