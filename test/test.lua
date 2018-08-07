#!/usr/bin/env lua

addonData = { ["Version"] = "1.0",
}

require "wowTest"

test.outFileName = "testOut.xml"

-- Figure out how to parse the XML here, until then....
--[[


INEED_Frame = CreateFrame()
SendMailNameEditBox = CreateFontString("SendMailNameEditBox")
INEEDUIListFrame = CreateFrame()
INEEDUIListFrame_TitleText = INEEDUIListFrame.CreateFontString()

]]
MeToo_Frame = CreateFrame()
MeTooOptionsFrame = CreateFrame()
MeTooOptionsFrame_MountSuccessDoEmote = CreateCheckButton("MeTooOptionsFrame_MountSuccessDoEmote")
MeTooOptionsFrame_MountSuccessEmoteEditBox =CreateEditBox("MeTooOptionsFrame_MountSuccessEmoteEditBox")
MeTooOptionsFrame_MountSuccessEmoteToTarget = CreateCheckButton("MeTooOptionsFrame_MountSuccessEmoteToTarget")
MeTooOptionsFrame_MountFailureDoEmote = CreateCheckButton("MeTooOptionsFrame_MountFailureDoEmote")
MeTooOptionsFrame_MountFailureEmoteEditBox =CreateEditBox("MeTooOptionsFrame_MountFailureEmoteEditBox")
MeTooOptionsFrame_MountFailureEmoteToTarget = CreateCheckButton("MeTooOptionsFrame_MountFailureEmoteToTarget")

MeTooOptionsFrame_CompanionSuccessDoEmote = CreateCheckButton("MeTooOptionsFrame_CompanionSuccessDoEmote")
MeTooOptionsFrame_CompanionSuccessEmoteEditBox = CreateEditBox("MeTooOptionsFrame_CompanionSuccessEmoteEditBox")
MeTooOptionsFrame_CompanionFailureDoEmote = CreateCheckButton("MeTooOptionsFrame_CompanionFailureDoEmote")
MeTooOptionsFrame_CompanionFailureEmoteEditBox = CreateEditBox("MeTooOptionsFrame_CompanionFailureEmoteEditBox")

-- require the file to test
package.path = "../src/?.lua;'" .. package.path
require "MeToo"
require "MeTooOptions"


-- addon setup

function test.before()
	MeToo.OnLoad()
	MeToo.ADDON_LOADED()
	actionLog = {}
end
function test.after()
end
function test.test_Command_Help()
	MeToo.Command( "help" )
end
function test.test_SlashCmdList()
	SlashCmdList["METOO"]()
end
function test.test_Command_Options()
	MeToo.Command( "options" )
end
function test.test_Command_nocmd()
	MeToo.Command()
	assertEquals( 0, #actionLog )
end
function test.test_Command_targetPlayer()
	TargetUnit("")
	MeToo.Command()
	assertEquals( "DoEmote( CRY, player )", actionLog[#actionLog] )
end



test.run()
