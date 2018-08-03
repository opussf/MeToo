MeToo.defaultOptions = {
	["mountSuccess_doEmote"] = true,
	["mountSuccess_emote"] = "CHEER",
	["mountFailure_doEmote"] = true,
	["mountFailure_emote"] = "CRY",
	["companionSuccess_doEmote"] = true,
	["companionSuccess_emote"] = "CHEER",
	["companionFailure_doEmote"] = true,
	["companionFailure_emote"] = "CRY"
}
MeToo_options = {}

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
	--MeToo.Print( "Options_Panel_Cancel" )
	if MeToo.oldValues then
		for key,val in pairs( MeToo.oldValues ) do
			print( key )
			MeToo_options[key] = val
		end
	end
	MeToo.oldValues = nil
end
function MeToo.OptionsPanel_Default()
	--MeToo.Print("Default")
	for k,v in pairs( MeToo.defaultOptions ) do
		print( k )
		MeToo_options[k] = v
	end
end
function MeToo.OptionsPanel_Refresh()
	-- set the drop down values here...  Maybe more?
	MeToo.Print( "OptionsPanel_Refresh" )
	MeTooOptionsFrame_MountSuccessDoEmote:SetChecked( MeToo_options["mountSuccess_doEmote"] )
	MeTooOptionsFrame_MountSuccessEmoteEditBox:SetText( MeToo_options["mountSuccess_emote"] )
	MeTooOptionsFrame_MountSuccessEmoteEditBox:SetCursorPosition(0)
	MeTooOptionsFrame_MountFailureDoEmote:SetChecked( MeToo_options["mountFailure_doEmote"] )
	MeTooOptionsFrame_MountFailureEmoteEditBox:SetText( MeToo_options["mountFailure_emote"] )
	MeTooOptionsFrame_MountFailureEmoteEditBox:SetCursorPosition(0)


end
function MeToo.OptionsPanel_OnLoad( panel )
	--MeToo.Print( "OptionsPanel_OnLoad" )
	panel.name = "MeToo"
	MeTooOptionsFrame_Title:SetText( METOO_MSG_ADDONNAME.." "..METOO_MSG_VERSION )
	-- buttons
	panel.okay = MeToo.OptionsPanel_OKAY
	panel.cancel = MeToo.OptionsPanel_Cancel
	panel.default = MeToo.OptionsPanel_Default
	panel.refresh = MeToo.OptionsPanel_Refresh

	InterfaceOptions_AddCategory( panel )
	InterfaceAddOnsList_Update()
	for k,v in pairs( MeToo.defaultOptions ) do
		MeToo_options[k] = MeToo_options[k] or v
	end
	--MeToo_options = { unpack( MeToo.defaultOptions ) }
end
-----------------
function MeToo.OptionsPanel_CheckButton_OnShow( self, option, text )
	MeToo.Print( text..": OnShow" )
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
	--self:SetCursorPosition(0)
end
function MeToo.OptionsPanel_EditBox_OnShow( self, option )
	MeToo.Print( "EditBox_OnShow( "..option.." )" )
	--self:SetCursorPosition(0)
	--MeToo.Print( "Set to: "..MeToo_options[option] )
	--self:SetText( MeToo_options[option] )
end

function MeToo.OptionsPanel_EditBox_TextChanged( self, option )
	MeToo.Print( "TextChanged: "..option.." >"..self:GetText() )
	if MeToo.oldValues then
		MeToo.oldValues[option] = MeToo.oldValues[option] or MeToo_options[option]
	else
		MeToo.oldValues = { [option] = MeToo_options[option] }
	end
	MeToo_options[option] = self:GetText()
end


--[[




TextBox events:

    OnCursorChanged
    OnEditFocusGained
    OnEditFocusLost
    OnEnterPressed
    OnEscapePressed
    OnInputLanguageChanged
    OnSpacePressed
    OnTabPressed
    OnTextChanged
    OnTextSet






function INEED.OptionsPanel_Refresh()
	-- Called when options panel is opened.
--	INEEDOptionsFrame_ShowProgress:SetChecked(INEED_options["showProgress"])
--	INEEDOptionsFrame_AlertOnSuccess:SetChecked(INEED_options["showSuccess"])
--	INEEDOptionsFrame_AudibleAlert:SetChecked(INEED_options["audibleSuccess"])
--	INEEDOptionsFrame_DoEmote:SetChecked(INEED_options["doEmote"])
--	INEEDOptionsFrame_PlaySound:SetChecked(INEED_options["playSoundFile"])

	INEEDOptionsFrame_DoEmoteEditBox:SetText(INEED_options["emote"])
	INEEDOptionsFrame_PlaySoundEditBox:SetText(INEED_options["soundFile"])

	--INEED.Print("Options Panel Refresh: "..INEED_options["emote"])
end

function INEED.OptionsPanel_EditBox_TextChanged( self, option )
	if INEED.oldValues then
		INEED.oldValues[option] = INEED.oldValues[option] or INEED_options[option]
	else
		INEED.oldValues={[option]=INEED_options[option] }
	end
	INEED_options[option] = self:GetText()
end
]]