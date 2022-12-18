local mjm = mjrequire "common/mjm"
local vec3 = mjm.vec3
local vec2 = mjm.vec2
local vec4 = mjm.vec4

local clientGameSettings = mjrequire "mainThread/clientGameSettings"
local gameConstants = mjrequire "common/gameConstants"
local locale = mjrequire "common/locale"


--local lightManager = mjrequire "mainThread/lightManager"

local logUI = {
    logs = {}
}

local mainView = nil

function logUI:load(gameUI, controller)
    mainView = ColorView.new(gameUI.view)
    mainView.relativePosition = ViewPosition(MJPositionInnerRight, MJPositionTop)
    mainView.size = vec2(gameUI.view.size.x * 0.25,1080)
    mainView.color = vec4(0.0,0.0,0.0,0.7)

    
    local consoleFont = Font(locale:getConsoleFont(), 12)

    local logView = TextView.new(mainView)
    logView.font = consoleFont
    logView.relativePosition = ViewPosition(MJPositionInnerLeft, MJPositionTop)
    logView.baseOffset = vec3(-4,-4, 0)
    
    mainView.update = function(dt)
        local string = table.concat(logUI.logs, "\n")
        logView.text = string
    end

    local function updateHiddenStatus()
        if clientGameSettings.values.renderLog and gameConstants.showDebugMenu then
            mainView.hidden = false
        else
            mainView.hidden = true
        end
    end

    updateHiddenStatus()

    clientGameSettings:addObserver("renderLog", updateHiddenStatus)


end

function logUI:log(str)
    logUI.logs[#(logUI.logs) + 1] = str
end

function logUI:show()
    if mainView then
        if clientGameSettings.values.renderLog and gameConstants.showDebugMenu then
            mainView.hidden = false
        end
    end
end
function logUI:hide()
    if mainView then
        mainView.hidden = true
    end
end

return logUI