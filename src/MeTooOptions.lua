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
MeToo_options = { unpack( MeToo.defaultOptions ) }

function MeToo.OptionsPanel_OnLoad( panel )
	MeToo.Print( "OptionsPanel_OnLoad" )
	panel.name = "MeToo"
	MeTooOptionsFrame_Title:SetText( METOO_MSG_ADDONNAME.." "..METOO_MSG_VERSION )
	-- buttons
	panel.okay = MeToo.OptionsPanel_OKAY
	panel.cancel = MeToo.OptionsPanel_Cancel
	panel.default = MeToo.OptionsPanel_Default
	panel.refresh = MeToo.OptionsPanel_Refresh

	InterfaceOptions_AddCategory( panel )
	InterfaceAddOnsList_Update()
end
function MeToo.OptionsPanel_Reset()
	-- Called from Addon_loaded
	MeToo.OptionsPanel_Refresh()
end
function MeToo.OptionsPanel_OKAY()
	-- Data was recorded, clear the temp
	MeToo.oldValues = nil
end
function MeToo.OptionsPanel_Cancel()
	-- reset to temp and update the UI
	if MeToo.oldValues then
		for key,val in pairs( MeToo.oldValues ) do
			MeToo_options[key] = val
		end
	end
	MeToo.oldValues = nil
end
function MeToo.OptionsPanel_Default()
	MeToo.Print("Default")
end
function MeToo.OptionsPanel_Refresh()
	-- set the drop down values here...  Maybe more?
end
function MeToo.OptionsPanel_CheckButton_OnLoad( self, option, text )
	getglobal( self:GetName().."Text"):SetText( text )
	self:SetChecked( MeToo_options[option] )
end
function MeToo.OptionsPanel_CheckButton_PostClick( self, option )
	if MeToo.oldValues then
		MeToo.oldValues[option] = MeToo.oldValues[option] or MeToo_options[option]
	else
		MeToo.oldValues = { [option] = MeToo_options[option] }
	end
	MeToo_options[option] = self:GetChecked()
end


--[[

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

function INEED.OptionsPanel_EditBox_OnLoad( self, option )
	self:SetText(INEED_options[option])
	self:SetCursorPosition(0)
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