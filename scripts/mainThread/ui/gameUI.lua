local mod = {
    loadOrder = 2
}

local eventManager = mjrequire "mainThread/eventManager"
local keyMapping = mjrequire "mainThread/keyMapping"
local clientGameSettings = mjrequire "mainThread/clientGameSettings"

local logUI   = mjrequire "hammerstone/ui/logUI"

function mod:onload(gameUI)
    local superInit = gameUI.init
	function gameUI:init(controller, world)
        superInit(gameUI, controller, world)

        logUI:load(gameUI, controller)


		local keyMap = {
			[keyMapping:getMappingIndex("debug", "showLog")] = function(isDown, isRepeat)
				if isDown then
					clientGameSettings:changeSetting("renderLog", not clientGameSettings.values.renderLog)
				end
				return true 
			end,
		}


		local function keyChanged(isDown, mapIndexes, isRepeat)
			for i, mapIndex in ipairs(mapIndexes) do
				if keyMap[mapIndex]  then
					if keyMap[mapIndex](isDown, isRepeat) then
						return true
					end
				end
			end
			return false
		end


		eventManager:addEventListenter(keyChanged, eventManager.keyChangedListeners)
    end
end

return mod