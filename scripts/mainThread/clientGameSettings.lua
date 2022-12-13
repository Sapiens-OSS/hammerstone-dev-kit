local mod = {
    loadOrder = 0
}

function mod:onload(clientGameSettings)
    
    clientGameSettings.values["renderLog"] = false
	
end

return mod