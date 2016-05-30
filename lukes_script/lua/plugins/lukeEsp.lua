luke = {}

--- ESP by Lenny (Modded By Me) ---
CreateClientConVar("luke_esp", 0, true, false)
CreateClientConVar("luke_esp_printers", 0, true, false)

luke.wallhack = function ()
	if GetConVar("luke_esp"):GetInt() == 1 then
		for k, v in pairs (player.GetAll()) do
			local plypos = (v:GetPos() + Vector(0,0,80)):ToScreen()
			local _plypos = (v:GetPos() + Vector(0,0,40)):ToScreen()
			local plypos_= (math.Round(v:GetPos():Distance(LocalPlayer():GetPos())))
			if v:IsSuperAdmin() then
				draw.DrawText("[SuperAdmin]" .. "["..v:SteamID().."] " ..v:Name().. "", "TabLarge", plypos.x, plypos.y, Color(0,0,0,255), 1)
			elseif v:IsAdmin() then
				draw.DrawText("[Admin]" .. "["..v:SteamID().."] " ..v:Name().. "", "TabLarge", plypos.x, plypos.y, Color(0,0,0,255), 1)
			else
				draw.DrawText("["..v:SteamID().."] "..v:Name(), "TabLarge", plypos.x, plypos.y, Color(0,0,0,255), 1)
			end
			draw.DrawText("D: " .. plypos_, "TabLarge", plypos.x, plypos.y-20, Color(0,0,0), 1)
		end
	end
end

hook.Add("HUDPaint", "ESP", luke.wallhack)