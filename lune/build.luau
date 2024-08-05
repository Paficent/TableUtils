local LuneUtils = require("lib/libraries/LuneUtils")

local CommandUtils = LuneUtils.CommandUtils
local Run = LuneUtils.Run

CommandUtils.CheckCommands({"lune", "luau", "lua5.1", "lua52", "rojo", "darklua"})

print("Building for production")

Run("rojo", {"build", "--output", "build/TableUtils.rbxm"})
Run("lune", {"run", "wax", "bundle", "output=build/TableUtils.luau"})
Run("lune", {"run", "wax", "bundle", "output=build/TableUtils.min.luau", "minify=true"})

print("Successfully built TableUtils")
