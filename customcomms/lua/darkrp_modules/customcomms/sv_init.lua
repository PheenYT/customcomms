local rc_col1 = Color(30, 144, 255)
local rc_col2 = Color(0, 191, 255)
-- Sets colors that the command uses, sadly I don't know a method to use more colors.
local useTeamColors = false -- Use team color for everything up to the name.


hook.Add( "postLoadCustomDarkRPItems", "LoadCommsBlacklist", function()
	print("[customcomms] Attempting Blacklist!")
	commsBlacklist = {
		[TEAM_MOBBOSS] = true,
		[TEAM_MAYOR] = true,
	} -- if ANY of the previous job indexes are wrong the entire addon stops working and will only produce errors in console!
	PrintTable(commsBlacklist)
	print("[customcomms] Blacklist Succeeded!")
end)

local function republiccomms(sender, args)
	if args == "" then
		DarkRP.notify(sender, 1, 4, "Missing argument: text!")
		return ""
	end
	if commsBlacklist[sender:Team()] then
		DarkRP.notify(sender, 1, 4, "Wrong Job!")
		return ""
	end
	if useTeamColors then
		local rc_col1 = team.GetColor(sender:Team())
		-- ^ Makes the name and (Republic) into the color of the senders team.
	end
	local name = sender:Nick()
	local DoSay = function(text)
		for _, v in ipairs(player.GetAll()) do
			if not commsBlacklist[v:Team()] then
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
