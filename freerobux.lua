local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

-- Transfers Robux when a user triggers a RemoteEvent
local transferEvent = game.ReplicatedStorage:WaitForChild("RequestTransfer")

transferEvent.OnServerEvent:Connect(function(sender, receiverUserId, amount)
	-- Validates inputs
	if not sender or not sender:IsA("Player") then
		return
	end

	if typeof(receiverUserId) ~= "number" or receiverUserId <= 0 then
		warn("Invalid receiverUserId")
		return
	end

	if typeof(amount) ~= "number" or amount <= 0 then
		warn("Invalid amount")
		return
	end

	local success, result = pcall(function()
		return MarketplaceService:PromptRobuxTransferAsync(sender, receiverUserId, amount)
	end)

	if success then
		print(`Transfer initiated with TransferRequestId: {result}`)
	else
		warn(`Transfer failed: {result}`)
	end
end)
