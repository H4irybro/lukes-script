local luke = {}
luke.g = table.Copy( _G )

--- Lenny's Bhop --

local bhop_cv = luke.g.CreateClientConVar("luke_bhop", 0);
local auto_cv = luke.g.CreateClientConVar("luke_strafe", 0);

local FW = true; -- forward
local BW = false; -- backwards
local NONE = nil; -- neither

local cd = 6; -- cooldown
local ccd = 0; -- current cooldown
local lastc = 0; -- last cmd number
local lp = luke.g.LocalPlayer(); -- localplayer

local function FWorBW(vel, ang)
	local a = vel;
	a:Rotate(-ang) 
	if(a.x > 0) then 
		return FW;
	elseif(a.x < 0) then
		return BW;
	end
	return NONE
end

luke.bhopper = function( cmd )
	if(lp:GetMoveType() == MOVETYPE_NOCLIP or lp:WaterLevel() >= 2) then return; end --does it make sense to jump?
	if (cmd:KeyDown(IN_JUMP)) then
		if(auto_cv:GetBool()) then
			local mul = FWorBW(lp:GetVelocity(), lp:EyeAngles()) == BW and -1 or 1;
			if(cmd:GetMouseX() < 0) then
				cmd:SetSideMove(-10000 * mul);
				ccd = -cd;
			elseif(cmd:GetMouseX() > 0) then
				cmd:SetSideMove(10000 * mul);
				ccd = cd;
			elseif(ccd < 0) then
				cmd:SetSideMove(-10000 * mul);
				ccd = ccd + 1;
			elseif(ccd > 0) then
				cmd:SetSideMove(10000 * mul);
				ccd = ccd - 1;
			end
		end
		if (lp:OnGround() and cmd:CommandNumber() ~= lastc + 1) then
			cmd:SetButtons(bit.bor(cmd:GetButtons(), IN_JUMP));
			if(cmd:CommandNumber() ~= 0) then lastc = cmd:CommandNumber(); end
			return;
		end
	end
	cmd:RemoveKey(IN_JUMP);
end

-- preperation
luke.g.hook.Remove("CreateMove", "bunnyhop");
if(bhop_cv:GetBool()) then
	luke.g.hook.Add("CreateMove", "bunnyhop", luke.bhopper);
end
-- end of prep


luke.g.cvars.AddChangeCallback("luke_bhop", function() 
	if(bhop_cv:GetBool()) then
		luke.g.hook.Add("CreateMove", "bunnyhop", luke.bhopper);
	else
		luke.g.hook.Remove("CreateMove", "bunnyhop");
	end
end)
