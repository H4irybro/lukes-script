---Luke's Script V2 ---
---A lot of the code here belongs to Lenny, but ya'know---

local luke = {}
local g = table.Copy( _G )

function luke.rainbow( msg )
	g.MsgC(Color(math.random(1, 255), math.random(1, 255), math.random(1,255)), msg)
end

--- ESP by Lenny (Modded By Me) ---
CreateClientConVar("luke_esp", 0, true, false)
CreateClientConVar("luke_esp_printers", 0, true, false)

local function wallhack()
	if GetConVar("luke_esp"):GetInt() == 1 then
		for k, v in pairs (player.GetAll()) do
			local plypos = (v:GetPos() + Vector(0,0,80)):ToScreen()
			if v:IsAdmin() or v:IsSuperAdmin() then
				draw.DrawText("" ..v:Name().. "[Admin]", "TabLarge", plypos.x, plypos.y, Color(220,60,90,255), 1)
			else
				draw.DrawText(v:Name(), "Trebuchet18", plypos.x, plypos.y, Color(255,255,255), 1)
			end
		end
	end
end

hook.Add("HUDPaint", "ESP", wallhack)

--- RapidFire By Lenny (Modded By Me) ---
CreateClientConVar("luke_rapidfire", 0)

local toggler = 0

local function rapidfire(cmd)
	if LocalPlayer():KeyDown(IN_ATTACK) then
		if LocalPlayer():Alive() then
			if IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass() != "weapon_physgun" then
				if toggler == 0 then
					cmd:SetButtons(bit.bor(cmd:GetButtons(), IN_ATTACK))
					toggler = 1
				else
					cmd:SetButtons(bit.band(cmd:GetButtons(), bit.bnot(IN_ATTACK)))
					toggler = 0
				end
			end
		end
	end
end


-- prepping
hook.Remove("CreateMove", "rapidfire")

if GetConVarNumber("luke_rapidfire") == 1 then
	hook.Add("CreateMove", "rapidfire", rapidfire)
end
--end of prep

cvars.AddChangeCallback("luke_rapidfire", function() 
	if GetConVarNumber("luke_rapidfire") == 1 then
		hook.Add("CreateMove", "rapidfire", rapidfire)
	else
		hook.Remove("CreateMove", "rapidfire")
	end
end)

--- Lenny's Bhop --

local bhop_cv = CreateClientConVar("luke_bhop", 0);
local auto_cv = CreateClientConVar("luke_strafe", 0);

local FW = true; -- forward
local BW = false; -- backwards
local NONE = nil; -- neither

local cd = 6; -- cooldown
local ccd = 0; -- current cooldown
local lastc = 0; -- last cmd number
local lp = LocalPlayer(); -- localplayer

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

local function bhopper(cmd)
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
hook.Remove("CreateMove", "bunnyhop");
if(bhop_cv:GetBool()) then
	hook.Add("CreateMove", "bunnyhop", bhopper);
end
-- end of prep


cvars.AddChangeCallback("luke_bhop", function() 
	if(bhop_cv:GetBool()) then
		hook.Add("CreateMove", "bunnyhop", bhopper);
	else
		hook.Remove("CreateMove", "bunnyhop");
	end
end)

--- Luke's Speed_Hud ---
CreateClientConVar("luke_hud", 1)

local w, h = ScrW(), ScrH()

local function hud()
	local vel = LocalPlayer():GetVelocity()
	vel.z = 0
	draw.RoundedBox(0,w*0.5-25,0,50,12,Color(0,0,0))
	draw.SimpleText("Vel: "..math.Round(vel:Length()), "Default", w*.5, 0, Color(255,0,255), 1)
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

---NoRecoil
CreateClientConVar("luke_norecoil", 1)


local function norecoil()
	if LocalPlayer():GetActiveWeapon():Clip1() > 0  then
		if LocalPlayer():GetActiveWeapon().Recoil then
			LocalPlayer():GetActiveWeapon().Recoil = 0
		end
		if LocalPlayer():GetActiveWeapon().Primary.Recoil then
			LocalPlayer():GetActiveWeapon().Primary.Recoil = 0
		end
	end
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
	if LocalPlayer():GetActiveWeapon():Clip1() > 0 then
		if LocalPlayer():GetActiveWeapon().Cone then
			LocalPlayer():GetActiveWeapon().Cone = 0
		end
		if LocalPlayer():GetActiveWeapon().Primary.Cone then
			LocalPlayer():GetActiveWeapon().Primary.Cone = 0
		end
	end
end



-- prepping
hook.Remove("PlayerSwitchWeapon", "nospread")

if GetConVarNumber("luke_norecoil") == 1 then
	hook.Add("PlayerSwitchWeapon", "nospread", nospread)
end
--end of prep

cvars.AddChangeCallback("luke_nospread", function() 
	if GetConVarNumber("luke_nospread") == 1 then
		hook.Add("PlayerSwitchWeapon", "nospread", nospread)
	else
		hook.Remove("PlayerSwitchWeapon", "nospread")
	end
end)

-------------------------------------------------------------------------

-------------------------------------------------------------------------

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
	luke.rainbow("------------------------\n")
	g.MsgC(Color(0,255,255), "Luke's Script Running...\n")
	g.MsgC(Color(255,255,255), "Your ingame nick is: ")
	g.MsgC(Color(0,0,255), LocalPlayer():GetName()) 
	g.MsgC(Color(255,255,255), "\n")
	cvar_running( GetConVar("luke_bhop") )
	cvar_running( GetConVar("luke_strafe") )
	cvar_running( GetConVar("luke_rapidfire") )
	cvar_running( GetConVar("luke_esp") )
	cvar_running( GetConVar("luke_esp_printers") )
	cvar_running( GetConVar("luke_hud") )
	cvar_running( GetConVar("luke_norecoil") )
	cvar_running( GetConVar("luke_nospread") )
	luke.rainbow("------------------------\n")
end