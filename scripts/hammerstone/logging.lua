local mod = {
	loadOrder = 0
}

local logUI = mjrequire "hammerstone/ui/logUI"

function mod:onload(logging)

	local super_log = logging.log
	logging.log = function(self, msg)
		super_log(self, msg)
		logUI:log("[Info] " .. msg)
	end

	local super_warning = logging.warning
	logging.warning = function(self, msg)
		super_warning(self, msg)
		logUI:log("[Warning] " .. msg)
	end

	local super_error = logging.error
	logging.error = function(self, msg)
		super_error(self, msg)
		logUI:log("[Error] " .. msg)
	end

end

return mod