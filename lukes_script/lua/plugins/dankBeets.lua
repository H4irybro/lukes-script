dankBeets = {}

dankBeets.music = {
"music/hl1_song10.mp3",           // 1
"music/hl1_song11.mp3",           // 2
"music/hl1_song14.mp3",           // 3
"music/hl1_song15.mp3",           // 4
"music/hl1_song17.mp3",           // 5
"music/hl1_song19.mp3",           // 6
"music/hl1_song20.mp3",           // 7
"music/hl1_song21.mp3",           // 8
"music/hl1_song24.mp3",           // 9
"music/hl1_song25_remix3.mp3",    // 10
"music/hl1_song26.mp3",           // 11
"music/hl1_song3.mp3",            // 12
"music/hl1_song5.mp3",            // 13
"music/hl1_song6.mp3",            // 14
"music/hl1_song9.mp3",            // 15
"music/hl2_ambient_1.wav",        // 15
"music/hl2_intro.mp3",            // 16
"music/hl2_song0.mp3",            // 17
"music/hl2_song1.mp3",            // 18
"music/hl2_song10.mp3",           // 19
"music/hl2_song11.mp3",           // 20
"music/hl2_song12_long.mp3",      // 21
"music/hl2_song13.mp3",           // 22
"music/hl2_song14.mp3",           // 23
"music/hl2_song15.mp3",           // 24
"music/hl2_song16.mp3",           // 25
"music/hl2_song17.mp3",           // 26
"music/hl2_song19.mp3",           // 27
"music/hl2_song2.mp3",            // 28
"music/hl2_song20_submix0.mp3",   // 29
"music/hl2_song20_submix4.mp3",   // 31
"music/hl2_song23_suitsong3.mp3", // 32
"music/hl2_song25_teleporter.mp3",// 33
"music/hl2_song26.mp3",           // 34
"music/hl2_song26_trainstation1.mp3", // 35
"music/hl2_song27_trainstation2.mp3", // 36
"music/hl2_song28.mp3",           // 37
"music/hl2_song29.mp3",           // 38
"music/hl2_song3.mp3",            // 39
"music/hl2_song30.mp3",           // 40
"music/hl2_song31.mp3",           // 41
"music/hl2_song32.mp3",           // 42
"music/hl2_song33.mp3",           // 43
"music/hl2_song4.mp3",            // 44
"music/hl2_song6.mp3",            // 45
"music/hl2_song7.mp3",            // 45
"music/hl2_song8.mp3",            // 46
"music/radio1.mp3",               // 47
"music/ravenholm_1.mp3"           // 48
}

dankBeets.dank_beets_title = [[
Luke's Script
==========================================================================================================
 ________  ________  ________   ___  __            ________  _______   _______  _________  ________          
|\   ___ \|\   __  \|\   ___  \|\  \|\  \         |\   __  \|\  ___ \ |\  ___ \|\___   ___\\   ____\         
\ \  \_|\ \ \  \|\  \ \  \\ \  \ \  \/  /|_       \ \  \|\ /\ \   __/|\ \   __/\|___ \  \_\ \  \___|_        
 \ \  \ \\ \ \   __  \ \  \\ \  \ \   ___  \       \ \   __  \ \  \_|/_\ \  \_|/__  \ \  \ \ \_____  \       
  \ \  \_\\ \ \  \ \  \ \  \\ \  \ \  \\ \  \       \ \  \|\  \ \  \_|\ \ \  \_|\ \  \ \  \ \|____|\  \      
   \ \_______\ \__\ \__\ \__\\ \__\ \__\\ \__\       \ \_______\ \_______\ \_______\  \ \__\  ____\_\  \     
    \|_______|\|__|\|__|\|__| \|__|\|__| \|__|        \|_______|\|_______|\|_______|   \|__| |\_________\    
                                                                                             \|_________| Plugin
|========================================================================================================|
|                             dank_beets :: Enable / disable Dank Beets                                  |
|                    dank_beets_music_list :: List all possible numbers for music                        |
|                             dank_beets_music :: Set the music number                                   |
|                         dank_beets_music_play :: Play your selected song                               |
|========================================================================================================|
]]
CreateClientConVar("dank_beets", 1, true, false)	
CreateClientConVar("dank_beets_music", 10, true, false)

dankBeets.isEnabled = function()
	if (GetConVar("dank_beets"):GetInt() == 1) then
		return true
	elseif (GetConVar("dank_beets"):GetInt() == 0) then
		return false
	end
end

dankBeets.GetVersion = function ()
	local V = ""
	http.Fetch("http://dankbeets.xp3.biz/version.txt", 
		function( content ) 
			V = content 
		end, 
		function ( error ) 
			V = "FAILED TO RETRIEVE VERSION (ARE YOU ONLINE?)" 
		end )
	return V
end

dankBeets.wavSound = function ( soundname )
	if (dankBeets.isEnabled()) then
		surface.PlaySound(soundname .. ".wav")
	end
end

dankBeets.musicPlay = function ( m_name )
	if (dankBeets.isEnabled()) then
		surface.PlaySound( m_name )
	end
end

dankBeets.Enable = function ()
	RunConsoleCommand("dank_beets", 1)
end

dankBeets.Disable = function ()
	RunConsoleCommand("dank_beets", 0)
end

dankBeets.musicLister = function ()
	if (dankBeets.isEnabled()) then
		for k,v in pairs(dankBeets.music) do
			MsgC(Color(255,255,255), k.." :: "..dankBeets.music[k].."\n")
		end
	end
end

dankBeets.Title = function ()
	if (GetConVar("dank_beets"):GetInt() == 1) then
		return dankBeets.dank_beets_title
	else
		return "dank beets is currently disabled"
	end
end

concommand.Add("dank_beets_music_play", function ()
	if (dankBeets.isEnabled()) then
		if (GetConVar("dank_beets_music"):GetInt() < 49) then
			dankBeets.musicPlay(dankBeets.music[GetConVar("dank_beets_music"):GetInt()])
			MsgC(Color(255,255,255), "You are now playing: " .. dankBeets.music[GetConVar("dank_beets_music"):GetInt()] .. "\n")
		else
			RunConsoleCommand("dank_beets_music", 10)
			MsgC(Color(255,0,0), "Sound choice only goes up to 48\n")
		end
	end
end )

concommand.Add("dank_beets_music_list", function() dankBeets.musicLister() end)
concommand.Add("dank_beets_version", function () MsgC(Color(255,255,255), dankBeets.GetVersion() .. "\n") end)