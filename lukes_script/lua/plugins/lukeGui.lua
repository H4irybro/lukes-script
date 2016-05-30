local luke = {}
luke.g = table.Copy( _G )

concommand.Add( "luke_gui", function ()

	local width  = 300
	local height = 170

	local Frame = luke.g.vgui.Create( "DFrame" )
	Frame:SetTitle( "Luke's Script Settings" )
	Frame:SetSize( width, height )
	Frame:Center()
	Frame:MakePopup()
	Frame.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
		luke.g.draw.RoundedBox( 0, 0, 0, w, h, Color( 73, 86, 116, 200 ) ) -- Draw a red box instead of the frame
	end

	local CheckBoxThing = luke.g.vgui.Create( "DCheckBoxLabel", Frame )
	CheckBoxThing:SetPos( 10, 30 )
	CheckBoxThing:SetText( "Enable Hud?" )
	CheckBoxThing:SetConVar( "luke_hud" ) -- ConCommand must be a 1 or 0 value
	CheckBoxThing:SetValue( luke.g.GetConVar( "luke_hud" ):GetString() )
	CheckBoxThing:SizeToContents() -- Make its size to the contents. Duh?

	local CheckBoxThing2 = luke.g.vgui.Create( "DCheckBoxLabel", Frame )
	CheckBoxThing2:SetPos( 10, 50 )
	CheckBoxThing2:SetText( "Enable Bhop?" )
	CheckBoxThing2:SetConVar( "luke_bhop" ) -- ConCommand must be a 1 or 0 value
	CheckBoxThing2:SetValue( luke.g.GetConVar( "luke_bhop" ):GetString() )
	CheckBoxThing2:SizeToContents() -- Make its size to the contents. Duh?

	local CheckBoxThing3 = luke.g.vgui.Create( "DCheckBoxLabel", Frame )
	CheckBoxThing3:SetPos( 10, 70 )
	CheckBoxThing3:SetText( "Enable ESP?" )
	CheckBoxThing3:SetConVar( "luke_esp" ) -- ConCommand must be a 1 or 0 value
	CheckBoxThing3:SetValue( luke.g.GetConVar( "luke_esp" ):GetString() )
	CheckBoxThing3:SizeToContents() -- Make its size to the contents. Duh?

	local CheckBoxThing4 = luke.g.vgui.Create( "DCheckBoxLabel", Frame )
	CheckBoxThing4:SetPos( 10, 90 )
	CheckBoxThing4:SetText( "Enable Rapid Fire?" )
	CheckBoxThing4:SetConVar( "luke_rapidfire" ) -- ConCommand must be a 1 or 0 value
	CheckBoxThing4:SetValue( luke.g.GetConVar( "luke_rapidfire" ):GetString() )
	CheckBoxThing4:SizeToContents() -- Make its size to the contents. Duh?

	local CheckBoxThing5 = luke.g.vgui.Create( "DCheckBoxLabel", Frame )
	CheckBoxThing5:SetPos( 10, 110 )
	CheckBoxThing5:SetText( "Enable Wallhack?" )
	CheckBoxThing5:SetConVar( "luke_walls" ) -- ConCommand must be a 1 or 0 value
	CheckBoxThing5:SetValue( luke.g.GetConVar( "luke_walls" ):GetString() )
	CheckBoxThing5:SizeToContents() -- Make its size to the contents. Duh?

	local CheckBoxThing6 = luke.g.vgui.Create( "DCheckBoxLabel", Frame )
	CheckBoxThing6:SetPos( 10, 130 )
	CheckBoxThing6:SetText( "Enable Strafe?" )
	CheckBoxThing6:SetConVar( "luke_strafe" ) -- ConCommand must be a 1 or 0 value
	CheckBoxThing6:SetValue( luke.g.GetConVar( "luke_strafe" ):GetString() )
	CheckBoxThing6:SizeToContents() -- Make its size to the contents. Duh?
end )