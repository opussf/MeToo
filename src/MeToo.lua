METOO_MSG_ADDONNAME = "MeToo";
METOO_MSG_VERSION   = GetAddOnMetadata(METOO_MSG_ADDONNAME,"Version");
METOO_MSG_AUTHOR    = "opussf";

-- Colours
COLOR_RED = "|cffff0000";
COLOR_GREEN = "|cff00ff00";
COLOR_BLUE = "|cff0000ff";
COLOR_PURPLE = "|cff700090";
COLOR_YELLOW = "|cffffff00";
COLOR_ORANGE = "|cffff6d00";
COLOR_GREY = "|cff808080";
COLOR_GOLD = "|cffcfb52b";
COLOR_NEON_BLUE = "|cff4d4dff";
COLOR_END = "|r";

MeToo = {}
MeToo_options = {}

function MeToo.Print( msg, showName)
	-- print to the chat frame
	-- set showName to false to suppress the addon name printing
	if (showName == nil) or (showName) then
		msg = COLOR_PURPLE..METOO_MSG_ADDONNAME.."> "..COLOR_END..msg
	end
	DEFAULT_CHAT_FRAME:AddMessage( msg )
end
function MeToo.OnLoad()
	SLASH_METOO1 = "/M2"
	SLASH_METOO2 = "/METOO"
	SlashCmdList["METOO"] = function( msg ) MeToo.Command( msg ); end
	--MeToo_Frame:RegisterEvent( "UNIT_PET" )
	--MeToo_Frame:RegisterEvent( "COMPANION_UPDATE" )
end
function MeToo.OnUpdate( ... )
end
function MeToo.Command( msg )
	if( UnitIsBattlePetCompanion( "target" ) ) then
		-- MeToo.Print( "Target IS battle pet" )
		speciesID = UnitBattlePetSpeciesID( "target" )
		petType = UnitBattlePetType( "target" )

		-- MeToo.Print( "SpeciesID: "..speciesID.." <> Type: "..petType )

		isOwned = ( C_PetJournal.GetOwnedBattlePetString( speciesID ) and true or nil )
		--MeToo.Print( "You do"..( isOwned and " " or " NOT").." own the target pet." )

		if isOwned then
			petName = C_PetJournal.GetPetInfoBySpeciesID( speciesID )
			-- MeToo.Print( "Name: "..petName )

			_, petID = C_PetJournal.FindPetIDByName( petName )  -- == speciesID?
			-- MeToo.Print( "petID: "..petID.." ("..string.len(petID)..")" )

			currentPet = C_PetJournal.GetSummonedPetGUID()
			-- MeToo.Print( "Current pet: "..currentPet )

			currentSpeciesID = C_PetJournal.GetPetInfoByPetID( currentPet )
			-- MeToo.Print( "currentSpeciesID: "..currentSpeciesID )

			if( speciesID == currentSpeciesID ) then
				--MeToo.Print( "Pets are the same" )
			else
				C_PetJournal.SummonPetByGUID( petID )
			end
		else
			DoEmote( "cry", "player" )
		end

		---- note...  repalce timer
	else
		MeToo.Print( "Target is NOT a battle pet" )
	end
end
--==--==--

