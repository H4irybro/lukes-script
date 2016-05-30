--- Walls by me (LAGGY AF WATCH OUT EDGY M8)---
-- Yea this part is shit, like really shit.
CreateClientConVar("luke_walls", 0, true, false)

luke = {}

luke.walls = function ()
	if GetConVar( "luke_walls" ):GetInt() == 1 then 
		halo.Add(player.GetAll(), Color( 255, 0, 0 ), 2, 2, 10, true, true )
	end
end

hook.Add("HUDPaint", "wall", luke.walls)