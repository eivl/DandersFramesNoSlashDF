local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function()
	C_Timer.After(0, function()
		-- Drop "/df" from DandersFrames aliases, compacting indices.
		local n = 0
		for i = 1, 20 do
			local key = "SLASH_DANDERSFRAMES" .. i
			local val = _G[key]
			_G[key] = nil
			if val and val ~= "/df" then
				n = n + 1
				_G["SLASH_DANDERSFRAMES" .. n] = val
			end
		end

		-- Hand /df back to whoever else registered it (Blizzard's LFG handler).
		for k, v in pairs(_G) do
			if v == "/df" and type(k) == "string" then
				local cmd = k:match("^SLASH_(.-)%d+$")
				if cmd and cmd ~= "DANDERSFRAMES" and SlashCmdList[cmd] then
					hash_SlashCmdList["/DF"] = SlashCmdList[cmd]
					return
				end
			end
		end
		hash_SlashCmdList["/DF"] = nil
	end)
end)
