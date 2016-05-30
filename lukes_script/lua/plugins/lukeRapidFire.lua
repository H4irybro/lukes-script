local luke = {}
luke.g = table.Copy( _G )

// yea this is 100% lenny's 
luke.g.CreateClientConVar("luke_rapidfire", 0)

local toggler = 0

luke.rapidfire = function (cmd)
	if luke.g.LocalPlayer():KeyDown(IN_ATTACK) then
		if luke.g.LocalPlayer():Alive() then
			if luke.g.IsValid(luke.g.LocalPlayer():GetActiveWeapon()) and luke.g.LocalPlayer():GetActiveWeapon():GetClass() != "weapon_physgun" then
				if toggler == 0 then
					cmd:SetButtons(luke.g.bit.bor(cmd:GetButtons(), IN_ATTACK))
					toggler = 1
				else
					cmd:SetButtons(luke.g.bit.band(cmd:GetButtons(), bit.bnot(IN_ATTACK)))
					toggler = 0
				end
			end
		end
	end
end


-- prepping
luke.g.hook.Remove("CreateMove", "rapidfire")

if luke.g.GetConVarNumber("luke_rapidfire") == 1 then
	luke.g.hook.Add("CreateMove", "rapidfire", luke.rapidfire)
end
--end of prep

luke.g.cvars.AddChangeCallback("luke_rapidfire", function() 
	if luke.g.GetConVarNumber("luke_rapidfire") == 1 then
		luke.g.hook.Add("CreateMove", "rapidfire", luke.rapidfire)
	else
		luke.g.hook.Remove("CreateMove", "rapidfire")
	end
end)