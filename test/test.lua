#!/usr/bin/env lua

require "wowTest"

test.outFileName = "testOut.xml"

-- Figure out how to parse the XML here, until then....
--[[
INEED_SplashFrame = { ["Show"] = function() end,
		["AddMessage"] = function(msg) print( "SPLASHFRAME:", (msg or "")) end,
}
INEED_Frame = CreateFrame()
SendMailNameEditBox = CreateFontString("SendMailNameEditBox")
INEEDUIListFrame = CreateFrame()
INEEDUIListFrame_TitleText = INEEDUIListFrame.CreateFontString()
]]

ParseTOC( "../src/MeToo.toc" )

-- addon setup

function test.before()
end
function test.after()
end

test.run()
