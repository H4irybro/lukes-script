---NoRecoil
CreateClientConVar("luke_norecoil", 1)


local function norecoil()
	// DEPRICATED
	g.MsgC(Color(255,0,0), "DEPRICATED")
end

-- prepping
hook.Remove("PlayerSwitchWeapon", "norecoil")

if GetConVarNumber("luke_norecoil") == 1 then
	hook.Add("PlayerSwitchWeapon", "norecoil", norecoil)
end
--end of prep

cvars.AddChangeCallback("luke_norecoil", function() 
	if GetConVarNumber("luke_norecoil") == 1 then
		hook.Add("PlayerSwitchWeapon", "norecoil", norecoil)
	else
		hook.Remove("PlayerSwitchWeapon", "norecoil")
	end
end)


--- NoSpread ---
CreateClientConVar("luke_nospread", 1)


local function nospread()
	g.MsgC(Color(255,0,0), "luke_norecoil has been removed")
end



-- prepping
hook.Remove("PlayerSwitchWeapon", "nospread")

if GetConVarNumber("luke_norecoil") == 1 then
	hook.Add("PlayerSwitchWeapon", "nospread", nospread)
end
--end of prep

cvars.AddChangeCallback("luke_nospread", function() 
	
end)