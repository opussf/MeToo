MeToo.defaultOptions = {
	["mountSuccess_doEmote"] = true,
	["mountSuccess_emote"] = "CHEER",
	["mountSuccess_useTarget"] = nil,
	["mountFailure_doEmote"] = true,
	["mountFailure_emote"] = "CRY",
	["mountFailure_useTarget"] = nil,
	["companionSuccess_doEmote"] = true,
	["companionSuccess_emote"] = "CHEER",
	["companionSuccess_useTarget"] = nil,
	["companionFailure_doEmote"] = true,
	["companionFailure_emote"] = "CRY",
	["companionFailure_useTarget"] = nil,
	["daysTrackWanted"] = 7

}
MeToo_options = {}
function MeToo.UpdateOptions()
	for k,v in pairs( MeToo.defaultOptions ) do
		MeToo_options[k] = ( MeToo_options[k] == nil and v or MeToo_options[k] )
	end
end
function MeToo.OptionsPanel_Reset()
	-- Called from Addon_loaded
	-- MeToo.Print( "Reset" )
	MeToo.OptionsPanel_Refresh()
end
function MeToo.OptionsPanel_OKAY()
	-- Data was recorded, clear the temp
	MeToo.oldValues = nil
end
function MeToo.OptionsPanel_Cancel()
	-- reset to temp and update the UI
	-- MeToo.Print( "Options_Panel_Cancel" )
	if MeToo.oldValues then
		for key,val in pairs( MeToo.oldValues ) do
			MeToo_options[key] = val
		end
	end
	MeToo.oldValues = nil
end
function MeToo.OptionsPanel_Default()
	-- MeToo.Print("Default")
	for k,v in pairs( MeToo.defaultOptions ) do
		MeToo_options[k] = v
	end
end
function MeToo.OptionsPanel_Refresh()
	-- set the drop down values here...  Maybe more?
	-- MeToo.Print( "OptionsPanel_Refresh" )
	MeTooOptionsFrame_MountSuccessDoEmote:SetChecked( MeToo_options["mountSuccess_doEmote"] )
	MeTooOptionsFrame_MountSuccessEmoteEditBox:SetText( MeToo_options["mountSuccess_emote"] )
	MeTooOptionsFrame_MountSuccessEmoteEditBox:SetCursorPosition(0)
	MeTooOptionsFrame_MountSuccessEmoteToTarget:SetChecked( MeToo_options["mountSuccess_useTarget"] )

	MeTooOptionsFrame_MountFailureDoEmote:SetChecked( MeToo_options["mountFailure_doEmote"] )
	MeTooOptionsFrame_MountFailureEmoteEditBox:SetText( MeToo_options["mountFailure_emote"] )
	MeTooOptionsFrame_MountFailureEmoteEditBox:SetCursorPosition(0)
	MeTooOptionsFrame_MountFailureEmoteToTarget:SetChecked( MeToo_options["mountFailure_useTarget"] )

	MeTooOptionsFrame_CompanionSuccessDoEmote:SetChecked( MeToo_options["companionSuccess_doEmote"] )
	MeTooOptionsFrame_CompanionSuccessEmoteEditBox:SetText( MeToo_options["companionSuccess_emote"] )
	MeTooOptionsFrame_CompanionSuccessEmoteEditBox:SetCursorPosition(0)
	MeTooOptionsFrame_CompanionSuccessEmoteToTarget:SetChecked( MeToo_options["companionSuccess_useTarget"] )

	MeTooOptionsFrame_CompanionFailureDoEmote:SetChecked( MeToo_options["companionFailure_doEmote"] )
	MeTooOptionsFrame_CompanionFailureEmoteEditBox:SetText( MeToo_options["companionFailure_emote"] )
	MeTooOptionsFrame_CompanionFailureEmoteEditBox:SetCursorPosition(0)
	MeTooOptionsFrame_CompanionFailureEmoteToTarget:SetChecked( MeToo_options["companionFailure_useTarget"] )
end
function MeToo.OptionsPanel_OnLoad( panel )
	--MeToo.Print( "OptionsPanel_OnLoad" )
	panel.name = "MeToo"
	MeTooOptionsFrame_Title:SetText( METOO_MSG_ADDONNAME.." v"..METOO_MSG_VERSION )
	-- buttons
	--panel.okay = MeToo.OptionsPanel_OKAY
	panel.cancel = MeToo.OptionsPanel_Cancel
	--panel.default = MeToo.OptionsPanel_Default
	--panel.refresh = MeToo.OptionsPanel_Refresh

	-- These NEED to be set
	panel.OnCommit = MeToo.OptionsPanel_OKAY
	panel.OnDefault = MeToo.OptionsPanel_Default
	panel.OnRefresh = MeToo.OptionsPanel_Refresh

	-- Register Options frame
	local category, layout = Settings.RegisterCanvasLayoutCategory( panel, panel.name )
	panel.category = category
	Settings.RegisterAddOnCategory(category)
	MeToo.UpdateOptions()
end
-----------------
function MeToo.OptionsPanel_CheckButton_OnShow( self, option, text )
	--MeToo.Print( text..": OnShow" )
	getglobal( self:GetName().."Text"):SetText( text )
end
function MeToo.OptionsPanel_CheckButton_PostClick( self, option )
	if MeToo.oldValues then
		MeToo.oldValues[option] = MeToo.oldValues[option] or MeToo_options[option]
	else
		MeToo.oldValues = { [option] = MeToo_options[option] }
	end
	MeToo_options[option] = self:GetChecked()
end
---------------
function MeToo.OptionsPanel_EditBox_OnLoad( self, option )
	--MeToo.Print( "EditBox_OnLoad( "..self:GetName()..", "..option.." )" )
	self:SetAutoFocus( false )
end
function MeToo.OptionsPanel_EditBox_TextChanged( self, option )
	--MeToo.Print( "TextChanged: "..option.." >"..self:GetText() )
	if MeToo.oldValues then
		MeToo.oldValues[option] = MeToo.oldValues[option] or MeToo_options[option]
	else
		MeToo.oldValues = { [option] = MeToo_options[option] }
	end
	MeToo_options[option] = self:GetText()
end
