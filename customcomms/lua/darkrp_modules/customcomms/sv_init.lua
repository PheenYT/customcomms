local rc_col1 = Color(30, 144, 255)
local rc_col2 = Color(0, 191, 255)
-- Sets colors that the command uses, sadly I don't know a method to use more colors.
local useTeamColors = false -- Use team color for everything up to the name.


hook.Add( "postLoadCustomDarkRPItems", "LoadBlacklist", function()
    Blacklist = {
        [TEAM_CIV] = true,
        [TEAM_CITIZEN] = true,
        [TEAM_POLICE] = true,
        [TEAM_GANG] = true
    }
end)

local function republiccomms(sender, args)
	if args == "" then
		DarkRP.notify(sender, 1, 4, "You have to put in actual text!")
		PrintMessage(3, "You have to put in actual text!")
		return ""
	end
	if Blacklist[sender:Team()] then
		DarkRP.notify(sender, 1, 4, "Wrong Job!")
		PrintMessage(3, "Wrong Job!")
		return ""
	end
	if useTeamColors then
		local rc_col1 = team.GetColor(sender:Team())
		-- ^ Makes the name and (Republic) into the color of the senders team.
	end
	local name = sender:Nick()
	local DoSay = function(text)
		for _, v in ipairs(player.GetAll()) do
			if not Blacklist[v:Team()] then
				DarkRP.talkToPerson(v, rc_col1, "(Republic) " .. name, rc_col2, text, sender)
			else
				return ""
			end
		end
	end
	return args, DoSay
end

DarkRP.defineChatCommand("rc", republiccomms, 2)
DarkRP.defineChatCommand("republic", republiccomms, 2)
DarkRP.defineChatCommand("comms", republiccomms, 2)