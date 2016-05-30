local luke = {}

storedColors = {}
storedMaterials = {}
storedRenderModes = {}

adminColor      = Color( 255, 0, 0, 255 )
friendColor     = Color( 0, 255, 0, 255 )
normPlayerColor = Color( 0, 0, 255 )
printerColor    = Color( 80, 80, 80, 255 )
npcColor        = Color( 255, 0, 255, 255 )
vehicleColor    = Color( 255, 255, 255, 255 )
weaponColor     = Color( 255, 255, 255, 255 )


whiteMat     = "xray"
renderMode   = RENDERMODE_TRANSALPHA

luke.setIfNonExistant = function(ent)
	if(!storedMaterials[ent] and !storedColors[ent]) then
		storedMaterials[ent] = ent:GetMaterial();
		storedColors[ent] = ent:GetColor();
		storedRenderModes[ent] = ent:GetRenderMode();
	end
end

luke.Xray = function ( )
	for i,v in pairs(ents.GetAll()) do
		if (IsValid(v)) then
			luke.setIfNonExistant(v)
			if (v:IsPlayer()) then
				if (v:IsAdmin() || v:IsSuperAdmin()) then
					v:SetColor(adminColor)
				elseif (v:GetFriendStatus() == "friend") then
					v:SetColor(friendColor)
				else
					v:SetColor(normPlayerColor)
				end
			elseif (v:IsNPC()) then
				v:SetColor(npcColor)
			elseif (v:IsVehicle()) then
				v:SetColor(vehicleColor)
			elseif (v:IsWeapon()) then
				v:SetColor(weaponColor)
			else
				local class = string.lower(v:GetClass())
				if (string.find(class, "printer")) then
					v:SetColor(printerColor)
				end
			end
			v:SetMaterial("xray")
			v:SetRenderMode(RENDERMODE_TRANSALPHA)
		end
	end
end

luke.TurnOffXRay = function ()
	for i,v in pairs(ents.GetAll()) do
		if(IsValid(v)) then
			if(storedMaterials[v]) then
				v:SetMaterial(storedMaterials[v]);
			end
			if(storedColors[v]) then
				v:SetColor(storedColors[v]);
			end
			if(storedRenderModes[v]) then
				v:SetRenderMode(storedRenderModes[v]);
			end
		end
	end
	storedColors = {};
	storedMaterials = {};
	storedRenderModes = {};
end

local xRayOn = false
concommand.Add("luke_xray_toggle", function(client, command, arguments)
	if(xRayOn) then
		hook.Remove("RenderScene", "XRay");
		luke.TurnOffXRay();
		xRayOn = false;
	else
		hook.Add("RenderScene", "XRay", luke.Xray);
		xRayOn = true;
	end
end)