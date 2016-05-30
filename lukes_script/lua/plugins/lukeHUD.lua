--- Luke's Speed_Hud ---
CreateClientConVar("luke_hud", 1)

local w, h = ScrW(), ScrH()

local function hud()
	local vel = LocalPlayer():GetVelocity()
	local fps = 1 / FrameTime()
	local plyhealth = LocalPlayer():Health()
	vel.z = 0
	draw.RoundedBox(0,w*0.5-25,0,50,12,Color(0,0,0))
	draw.SimpleText("Vel: "..math.Round(vel:Length()), "Default", w*.5, 0, Color(255,0,255), 1)

	draw.RoundedBox(0,w*0.5-25,10,50,12,Color(0,0,0))
	draw.SimpleText("Fps: ".. math.Round(fps), "Default", w*.5, 10, Color(255,0,255), 1)

	// Custom HP bar :P
	draw.RoundedBox(0, w*0.5-50, h-30, 100, 10,Color(255,0,0)) // red box
	draw.RoundedBox(0, w*0.5-50, h-30, plyhealth, 10, Color(0,255,0)) // green box
	draw.SimpleText(plyhealth , "lukefont2", w/2-5, h-32, Color(0,0,255)) // text
end


--prepping
hook.Remove("HUDPaint", "lukehud")
timer.Simple(1, function()
if GetConVarNumber("luke_hud") == 1 then
	hook.Add("HUDPaint", "lukehud", hud)
end
end)
-- end of prep


cvars.AddChangeCallback("luke_hud", function() 
	if GetConVarNumber("luke_hud") == 1 then
		hook.Add("HUDPaint", "lukehud", hud)
	else
		hook.Remove("HUDPaint", "lukehud")
	end
end)
