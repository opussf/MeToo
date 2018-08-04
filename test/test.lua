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

-- require the file to test
package.path = "../src/?.lua;'" .. package.path
require "MeToo"

-- addon setup

function test.before()
	MeToo.OnLoad()
	MeToo.ADDON_LOADED()
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
end


function test.notest_ParseCmd_01()
	out = MeToo.ParseCmd( "" )
	assertEquals( "", out )
end
function test.notest_ParseCmd_02()
	out = MeToo.ParseCmd( "help" )
	assertEquals( "help", out )
end
function test.notest_Command_01()
	MeToo.Command()
end

function test.notest_Command_03()
	MeToo.Command( "unknown" )
end

test.run()
