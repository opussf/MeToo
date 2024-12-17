#!/usr/bin/env lua

require "wowTest"

test.outFileName = "testOut.xml"
test.coberturaFileName = "../coverage.xml"

-- MeToo_Frame = CreateFrame()
MeTooOptionsFrame = CreateFrame()
MeTooOptionsFrame_MountSuccessDoEmote = CreateCheckButton("MeTooOptionsFrame_MountSuccessDoEmote")
MeTooOptionsFrame_MountSuccessEmoteEditBox =CreateEditBox("MeTooOptionsFrame_MountSuccessEmoteEditBox")
MeTooOptionsFrame_MountSuccessEmoteToTarget = CreateCheckButton("MeTooOptionsFrame_MountSuccessEmoteToTarget")
MeTooOptionsFrame_MountFailureDoEmote = CreateCheckButton("MeTooOptionsFrame_MountFailureDoEmote")
MeTooOptionsFrame_MountFailureEmoteEditBox =CreateEditBox("MeTooOptionsFrame_MountFailureEmoteEditBox")
MeTooOptionsFrame_MountFailureEmoteToTarget = CreateCheckButton("MeTooOptionsFrame_MountFailureEmoteToTarget")

MeTooOptionsFrame_CompanionSuccessDoEmote = CreateCheckButton("MeTooOptionsFrame_CompanionSuccessDoEmote")
MeTooOptionsFrame_CompanionSuccessEmoteEditBox = CreateEditBox("MeTooOptionsFrame_CompanionSuccessEmoteEditBox")
MeTooOptionsFrame_CompanionSuccessEmoteToTarget = CreateCheckButton("MeTooOptionsFrame_CompanionSuccessEmoteToTarget")
MeTooOptionsFrame_CompanionFailureDoEmote = CreateCheckButton("MeTooOptionsFrame_CompanionFailureDoEmote")
MeTooOptionsFrame_CompanionFailureEmoteEditBox = CreateEditBox("MeTooOptionsFrame_CompanionFailureEmoteEditBox")
MeTooOptionsFrame_CompanionFailureEmoteToTarget = CreateCheckButton("MeTooOptionsFrame_CompanionFailureEmoteToTarget")

-- require the file to test
ParseTOC( "../src/MeToo.toc" )

-- addon setup
function test.before()
	MeToo.OnLoad()
	MeToo.ADDON_LOADED( nil, "MeToo" )
	actionLog = {}
	chatLog = {}
end
function test.after()
end
function test.test_Command_Help()
	MeToo.Command( "help" )
	assertEquals( "|cff0000ffMeToo> |rMeToo (@VERSION@) by opussf", chatLog[1].msg )
end
function test.test_Command_nocmd()
	Units["target"] = {["isBattlePet"] = false}
	MeToo.Command()
	assertEquals( 0, #actionLog )
end
-- function test.test_Command_targetPlayer()
-- 	TargetUnit("")
-- 	MeToo.Command()
-- 	assertEquals( "DoEmote( CRY, player )", actionLog[#actionLog] )
-- 	test.dump( chatLog )
-- end



test.run()
