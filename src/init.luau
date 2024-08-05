--!strict
--!native
--!optimize 2
--// Paficent \\

local TableUtil = {}

local types = require(script.types)
local modules = require(script.modules)

TableUtil.Types = types
TableUtil.Array = modules.Array
TableUtil.Table = modules.Table

return TableUtil