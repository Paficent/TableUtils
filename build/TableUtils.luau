-- ++++++++ WAX BUNDLED DATA BELOW ++++++++ --

-- Will be used later for getting flattened globals
local ImportGlobals

-- Holds direct closure data (defining this before the DOM tree for line debugging etc)
local ClosureBindings = {
    function()local wax,script,require=ImportGlobals(1)local ImportGlobals return (function(...)--!strict
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
end)() end,
    function()local wax,script,require=ImportGlobals(2)local ImportGlobals return (function(...)-- The current Table.dump module isn't strictly typed, will need to rewrite
end)() end,
    function()local wax,script,require=ImportGlobals(3)local ImportGlobals return (function(...)return {
    Table = require(script.Parent.modules.Table),
    Array = require(script.Parent.modules.Array)
}
end)() end,
    function()local wax,script,require=ImportGlobals(4)local ImportGlobals return (function(...)--!strict
--!native
--!optimize 2
--// Paficent \\

local Array = {}
local Types = require(script.Parent.Parent.types)

--[=[
    Checks if the inputted table is an array.

    @param array Array<V> | Table<any, V> -- The inputted array or table
    @return boolean -- Returns whether or not the input table is an array
]=]
function Array.isArray<V>(array: Types.Array<V> | Types.Table<any,V>): boolean
	if typeof(array) ~= "table" then
		return false
	end

	for key in array :: any do
		if typeof(key) ~= "number" then
			return false
		end
	end

	return true
end

--[=[
    Counts the number of items in an array.

    @param array Array<V> -- The inputted array
    @return number -- Returns the total number of objects within an array
]=]
function Array.length<V>(array: Types.Array<V>): number
	if not Array.isArray(array) then
		error("Array.reverse called on non-array")
	end

	return #array
end

--[=[
    Finds the index of a value within the inputted array.

    @param array Array<V> -- The inputted array
    @param value V -- The value to search for in the array
    @return number -- Returns the index of value, if not found returns -1
]=]
function Array.indexOf<V>(array: Types.Array<V>, value: V): number
	if not Array.isArray(array) then
		error("Array.reverse called on non-array")
	end
	
	for Index, Val in ipairs(array) do
		if Val == value then
			return Index
		end
	end

	return -1
end

--[=[
    Reverses the elements of an array in place.

    @param array Array<V> -- The inputted array
    @return Array<V> -- The reversed array
]=]
function Array.reverse<V>(array: Types.Array<V>): Types.Array<V>
    if not Array.isArray(array) then
        error("Array.reverse called on non-array")
    end

    local i, j = 1, #array
    while i < j do
        array[i], array[j] = array[j], array[i]
        i = i + 1
        j = j - 1
    end

    return array
end

--[=[
    Merges multiple arrays into one.

    @param ... Array<V> -- Arrays to be merged
    @return Array<V> -- A new array containing all elements from the input arrays
]=]
function Array.mergei<V>(...: Types.Array<V>): Types.Array <V>
	local Arrays = { ... }
	local NewArray = {}

	for Index, currentArray in ipairs(Arrays) do
		if not Array.isArray(currentArray) then
			error("Array.mergei called on non-array ")
		end

		table.move(currentArray, 1, #currentArray, #NewArray + 1, NewArray)
	end

	return NewArray
end

--[=[
    Maps each element in an array to a new value based on a callback function.

    @param array Array<V> -- The inputted array
    @param predicate mapCallbackFunc<V, R> -- A callback function that maps values to a new type
    @return Array<R> -- A new array with mapped values
]=]
function Array.map<V, R>(array: Types.Array<V>, predicate: Types.mapCallbackFunc<V, R>): Types.Array<R>
	if not Array.isArray(array) then
		error(string.format("Array.map called on non-array"))
	end

	if typeof(predicate) ~= "function" then
		error("Invalid usage: 'predicate' is not a function")
	end
  
	local newTable = {}

	for i, value in array do
		local mappedValue: R = predicate(i, value)
  
		if mappedValue ~= nil then
			table.insert(newTable, mappedValue)
		end
	end
  
	return newTable
end

--[=[
    Reduces an array to a single value based on a callback function and an initial value.

    @param array Array<V> -- The inputted array
    @param predicate reduceCallbackFunc<V, U> -- A callback function to reduce values
    @param initialValue U -- The initial value for the reduction
    @return U -- The final reduced value
]=]
function Array.reduce<V, U>(array: Types.Array<V>, predicate: Types.reduceCallbackFunc<V, U>, initialValue: U): U
    if not Array.isArray(array) then
        error("Array.reduce called on non-array")
    end

    local accumulator = initialValue
    for index, value in ipairs(array) do
        accumulator = predicate(accumulator, value, index)
    end
    return accumulator
end

return Array
end)() end,
    function()local wax,script,require=ImportGlobals(5)local ImportGlobals return (function(...)--!strict
--!native
--!optimize 2
--// Paficent \\

local Table = {}
local Types = require(script.Parent.Parent.types)


-- // Recursive Functions
local recursiveFind, cloneTable
function recursiveFind<K>(tbl: Types.Table<K, any>, value: any, isLocated: Types.predicateFunc<K,any>): Types.Table<K,any> -- For some reason this doesn't work with <K,V> so for now Value can be type any
	local newTable = {}

	for Key, Val in pairs(tbl) do
		newTable[Key] = Val
		if type(Val) == "table" then
			newTable[Key] = recursiveFind(tbl, value, isLocated)
		end
		if isLocated(Key, Val) then
			newTable[Key] = value
		end
	end

	return newTable
end

function cloneTable<K, V>(tbl: Types.NestedTable<K, V>): Types.NestedTable<K, V>
    local newTable: Types.NestedTable<K, V> = {}

    for key, value in pairs(tbl) do
        if typeof(value) == "table" then
            newTable[key] = cloneTable(value :: Types.NestedTable<K, V>)
        else
            newTable[key] = value
        end
    end

    return newTable
end


--// Functions
--[=[
    Gets all keys from a table.

    @param tbl Table<K, V> -- The inputted table
    @return Array<K> -- An array containing all keys from the table
]=]
function Table.keys<K, V>(tbl: Types.Table<K, V>): Types.Array<K>
	local newTable = {}

	for Key, Value in pairs(tbl) do
		newTable[#newTable + 1] = Key
	end

	return newTable
end

--[=[
    Merges multiple tables into one.

    @param ... Table<K, V> -- Tables to be merged
    @return Table<K, V> -- A new table containing all key-value pairs from the input tables
]=]
function Table.merge<K,V>(...: Types.Table<K, V>): Types.Table<K, V>
	local newTable = {}
	local Tables = { ... }

	for _, CurrentTable in ipairs(Tables) do
		for Key, Value in pairs(CurrentTable) do
			newTable[Key] = Value
		end
	end

	return newTable
end

--[=[
    Deeply merges multiple nested tables into one.

    @param ... NestedTable<K, V> -- Nested tables to be merged
    @return NestedTable<K, V> -- A new nested table containing all key-value pairs from the input tables
]=]
function Table.deepMerge<K, V>(...: Types.NestedTable<K, V>): Types.NestedTable<K, V>
    local newTable: Types.NestedTable<K, V> = {}

    local function merge(src: Types.NestedTable<K, V>, dest: Types.NestedTable<K, V>)
        for key, value in pairs(src) do
            if typeof(value) == "table" and typeof(dest[key]) == "table" then
                merge(value :: Types.NestedTable<K, V>, dest[key] :: Types.NestedTable<K, V>)
            elseif typeof(value) == "table" then
                dest[key] = Table.deepMerge(value :: Types.NestedTable<K, V>) :: V | Types.NestedTable<K, V>
            else
                dest[key] = value
            end
        end
    end

    for _, tbl in ipairs({...}) do
        merge(tbl, newTable)
    end

    return newTable
end

--[=[
    Filters elements of a table based on a predicate function.

    @param tbl Table<K, V> -- The inputted table
    @param predicate predicateFunc<K, V> -- A predicate function to determine which elements to include
    @return Array<V> -- An array of values that satisfy the predicate
]=]
function Table.filter<K, V>(tbl: Types.Table<K, V>, predicate: Types.predicateFunc<K, V>): Types.Array<V>
	if typeof(predicate) ~= "function" then
		error("Invalid usage: 'predicate' is not a function")
	end

	local newTable = {}

	for Key, Value in next, tbl do
		if predicate(Key, Value) then
			newTable[#newTable + 1] = Value
		end
	end

	return newTable
end

--[=[
    Recursively finds and replaces values in a table based on a predicate function.

    @param tbl Table<K, any> -- The table to search through
    @param value any -- The value to replace found items with
    @param isLocated predicateFunc<K, any> -- A predicate function to determine if an item should be replaced
    @return Table<K, any> -- A new table with values replaced based on the predicate
]=]
function Table.recursiveFind<K>(tbl: Types.Table<K, any>, value: any, isLocated: Types.predicateFunc<K,any>): Types.Table<K,any>
	return recursiveFind(tbl, value, isLocated)
end

--[=[
    Creates a deep copy of a nested table.

    @param tbl NestedTable<K, V> -- The table to clone
    @return NestedTable<K, V> -- A new table that is a deep copy of the original
]=]
function Table.clone<K, V>(tbl: Types.NestedTable<K, V>): Types.NestedTable<K, V>
	return cloneTable(tbl)
end

--[=[
    Creates a shallow copy of a table.

    @param tbl Table<K, V> -- The table to clone
    @return Table<K, V> -- A new table that is a shallow copy of the original
]=]
function Table.shallowClone<K, V>(tbl: Types.Table<K, V>): Types.Table<K, V>
    local newTable: Types.Table<K, V> = {}
    for key, value in pairs(tbl) do
        newTable[key] = value
    end
    return newTable
end

--[=[
    Finds the first element in a table that matches a given condition.

    @param tbl Table<K, V> -- The inputted table
    @param predicate predicateFunc<K, V> -- A predicate function to determine the matching element
    @return V? -- The first element that matches the predicate, or nil if no match is found
]=]
function Table.find<K, V>(tbl: Types.Table<K, V>, predicate: Types.predicateFunc<K, V>): V?
    if typeof(predicate) ~= "function" then
        error("Invalid usage: 'predicate' is not a function")
    end

    for key, value in pairs(tbl) do
        if predicate(key, value) then
            return value
        end
    end

    return nil
end

--[=[
    Checks if at least one element in a table satisfies a condition.

    @param tbl Table<K, V> -- The inputted table
    @param predicate predicateFunc<K, V> -- A predicate function to check elements
    @return boolean -- Returns true if at least one element satisfies the condition, otherwise false
]=]
function Table.some<K, V>(tbl: Types.Table<K, V>, predicate: Types.predicateFunc<K, V>): boolean
    if typeof(predicate) ~= "function" then
        error("Invalid usage: 'predicate' is not a function")
    end

    for key, value in pairs(tbl) do
        if predicate(key, value) then
            return true
        end
    end

    return false
end

--[=[
    Checks if all elements in a table satisfy a condition.

    @param tbl Table<K, V> -- The inputted table
    @param predicate predicateFunc<K, V> -- A predicate function to check elements
    @return boolean -- Returns true if all elements satisfy the condition, otherwise false
]=]
function Table.every<K, V>(tbl: Types.Table<K, V>, predicate: Types.predicateFunc<K, V>): boolean
    if typeof(predicate) ~= "function" then
        error("Invalid usage: 'predicate' is not a function")
    end

    for key, value in pairs(tbl) do
        if not predicate(key, value) then
            return false
        end
    end

    return true
end

--[=[
    Flattens a nested table into a single-level table.

    @param tbl NestedTable<K, V> -- The inputted nested table
    @return Array<V> -- A single-level array containing all values from the nested table
]=]
function Table.flatten<K, V>(tbl: Types.NestedTable<K, V>): Types.Array<V>
    local result: Types.Array<V> = {}

    local function flattenRecursively(subTable: Types.NestedTable<K, V>)
        for _, value in pairs(subTable) do
            if typeof(value) == "table" then
                flattenRecursively(value :: Types.NestedTable<K, V>)
            else
                table.insert(result, value)
            end
        end
    end

    flattenRecursively(tbl)
    return result
end

--[=[
    Removes duplicate values from an array.

    @param array Array<V> -- The inputted array
    @return Array<V> -- A new array with duplicate values removed
]=]
function Table.unique<V>(array: Types.Array<V>): Types.Array<V>
    local result: Types.Array<V> = {}
    local seen: Types.Table<V, boolean> = {}

    for _, value in ipairs(array) do
        if not seen[value] then
            seen[value] = true
            table.insert(result, value)
        end
    end

    return result
end

--[=[
    Splits an array into chunks of a specified size.

    @param array Array<V> -- The inputted array
    @param size number -- The size of each chunk
    @return Array<Array<V>> -- An array containing chunks of the original array
]=]
function Table.chunk<V>(array: Types.Array<V>, size: number): Types.Array<Types.Array<V>>
    if size <= 0 then
        error("Chunk size must be greater than 0")
    end

    local result: Types.Array<Types.Array<V>> = {}
    local chunk: Types.Array<V> = {}

    for i, value in ipairs(array) do
        if (i - 1) % size == 0 and i > 1 then
            table.insert(result, chunk)
            chunk = {}
        end
        table.insert(chunk, value)
    end

    if #chunk > 0 then
        table.insert(result, chunk)
    end

    return result
end

return Table
end)() end,
    function()local wax,script,require=ImportGlobals(6)local ImportGlobals return (function(...)--!strict
--!native
--!optimize 2
--// Paficent \\

local SharedTypes = {}

--- @type Array<T> = { T }
export type Array<T> = { T }

--- @type Table<K, V> = { [K]: V }
export type Table<K, V> = { [K]: V }

--- @type NestedTable<K, V> = { [K]: V | NestedTable<K, V> }
export type NestedTable<K, V> = { [K]: V | NestedTable<K, V> }

--- @type predicateFunc<K, V> = (key: K, value: V) -> boolean
export type predicateFunc<K, V> = (key: K, value: V) -> boolean

--- @type mapCallbackFunc<T, U> = (index: number, value: T) -> U
export type mapCallbackFunc<T, U> = (index: number, value: T) -> U

--- @type reduceCallbackFunc<T, U> = (accumulator: U, value: T, index: number) -> U
export type reduceCallbackFunc<T, U> = (accumulator: U, value: T, index: number) -> U

return SharedTypes
end)() end
} -- [RefId] = Closure

-- Holds the actual DOM data
local ObjectTree = {
    {
        1,
        2,
        {
            "Table"
        },
        {
            {
                2,
                2,
                {
                    "Dump"
                }
            },
            {
                6,
                2,
                {
                    "types"
                }
            },
            {
                3,
                2,
                {
                    "modules"
                },
                {
                    {
                        4,
                        2,
                        {
                            "Array"
                        }
                    },
                    {
                        5,
                        2,
                        {
                            "Table"
                        }
                    }
                }
            }
        }
    }
}

-- Line offsets for debugging (only included when minifyTables is false)
local LineOffsets = {
    8,
    24,
    26,
    31,
    187,
    490
}

-- Misc AOT variable imports
local WaxVersion = "0.4.1"
local EnvName = "WaxRuntime"

-- ++++++++ RUNTIME IMPL BELOW ++++++++ --

-- Localizing certain libraries and built-ins for runtime efficiency
local string, task, setmetatable, error, next, table, unpack, coroutine, script, type, require, pcall, tostring, tonumber, _VERSION =
      string, task, setmetatable, error, next, table, unpack, coroutine, script, type, require, pcall, tostring, tonumber, _VERSION

local table_insert = table.insert
local table_remove = table.remove
local table_freeze = table.freeze or function(t) return t end -- lol

local coroutine_wrap = coroutine.wrap

local string_sub = string.sub
local string_match = string.match
local string_gmatch = string.gmatch

-- The Lune runtime has its own `task` impl, but it must be imported by its builtin
-- module path, "@lune/task"
if _VERSION and string_sub(_VERSION, 1, 4) == "Lune" then
    local RequireSuccess, LuneTaskLib = pcall(require, "@lune/task")
    if RequireSuccess and LuneTaskLib then
        task = LuneTaskLib
    end
end

local task_defer = task and task.defer

-- If we're not running on the Roblox engine, we won't have a `task` global
local Defer = task_defer or function(f, ...)
    coroutine_wrap(f)(...)
end

-- ClassName "IDs"
local ClassNameIdBindings = {
    [1] = "Folder",
    [2] = "ModuleScript",
    [3] = "Script",
    [4] = "LocalScript",
    [5] = "StringValue",
}

local RefBindings = {} -- [RefId] = RealObject

local ScriptClosures = {}
local ScriptClosureRefIds = {} -- [ScriptClosure] = RefId
local StoredModuleValues = {}
local ScriptsToRun = {}

-- wax.shared __index/__newindex
local SharedEnvironment = {}

-- We're creating 'fake' instance refs soley for traversal of the DOM for require() compatibility
-- It's meant to be as lazy as possible
local RefChildren = {} -- [Ref] = {ChildrenRef, ...}

-- Implemented instance methods
local InstanceMethods = {
    GetFullName = { {}, function(self)
        local Path = self.Name
        local ObjectPointer = self.Parent

        while ObjectPointer do
            Path = ObjectPointer.Name .. "." .. Path

            -- Move up the DOM (parent will be nil at the end, and this while loop will stop)
            ObjectPointer = ObjectPointer.Parent
        end

        return Path
    end},

    GetChildren = { {}, function(self)
        local ReturnArray = {}

        for Child in next, RefChildren[self] do
            table_insert(ReturnArray, Child)
        end

        return ReturnArray
    end},

    GetDescendants = { {}, function(self)
        local ReturnArray = {}

        for Child in next, RefChildren[self] do
            table_insert(ReturnArray, Child)

            for _, Descendant in next, Child:GetDescendants() do
                table_insert(ReturnArray, Descendant)
            end
        end

        return ReturnArray
    end},

    FindFirstChild = { {"string", "boolean?"}, function(self, name, recursive)
        local Children = RefChildren[self]

        for Child in next, Children do
            if Child.Name == name then
                return Child
            end
        end

        if recursive then
            for Child in next, Children do
                -- Yeah, Roblox follows this behavior- instead of searching the entire base of a
                -- ref first, the engine uses a direct recursive call
                return Child:FindFirstChild(name, true)
            end
        end
    end},

    FindFirstAncestor = { {"string"}, function(self, name)
        local RefPointer = self.Parent
        while RefPointer do
            if RefPointer.Name == name then
                return RefPointer
            end

            RefPointer = RefPointer.Parent
        end
    end},

    -- Just to implement for traversal usage
    WaitForChild = { {"string", "number?"}, function(self, name)
        return self:FindFirstChild(name)
    end},
}

-- "Proxies" to instance methods, with err checks etc
local InstanceMethodProxies = {}
for MethodName, MethodObject in next, InstanceMethods do
    local Types = MethodObject[1]
    local Method = MethodObject[2]

    local EvaluatedTypeInfo = {}
    for ArgIndex, TypeInfo in next, Types do
        local ExpectedType, IsOptional = string_match(TypeInfo, "^([^%?]+)(%??)")
        EvaluatedTypeInfo[ArgIndex] = {ExpectedType, IsOptional}
    end

    InstanceMethodProxies[MethodName] = function(self, ...)
        if not RefChildren[self] then
            error("Expected ':' not '.' calling member function " .. MethodName, 2)
        end

        local Args = {...}
        for ArgIndex, TypeInfo in next, EvaluatedTypeInfo do
            local RealArg = Args[ArgIndex]
            local RealArgType = type(RealArg)
            local ExpectedType, IsOptional = TypeInfo[1], TypeInfo[2]

            if RealArg == nil and not IsOptional then
                error("Argument " .. RealArg .. " missing or nil", 3)
            end

            if ExpectedType ~= "any" and RealArgType ~= ExpectedType and not (RealArgType == "nil" and IsOptional) then
                error("Argument " .. ArgIndex .. " expects type \"" .. ExpectedType .. "\", got \"" .. RealArgType .. "\"", 2)
            end
        end

        return Method(self, ...)
    end
end

local function CreateRef(className, name, parent)
    -- `name` and `parent` can also be set later by the init script if they're absent

    -- Extras
    local StringValue_Value

    -- Will be set to RefChildren later aswell
    local Children = setmetatable({}, {__mode = "k"})

    -- Err funcs
    local function InvalidMember(member)
        error(member .. " is not a valid (virtual) member of " .. className .. " \"" .. name .. "\"", 3)
    end
    local function ReadOnlyProperty(property)
        error("Unable to assign (virtual) property " .. property .. ". Property is read only", 3)
    end

    local Ref = {}
    local RefMetatable = {}

    RefMetatable.__metatable = false

    RefMetatable.__index = function(_, index)
        if index == "ClassName" then -- First check "properties"
            return className
        elseif index == "Name" then
            return name
        elseif index == "Parent" then
            return parent
        elseif className == "StringValue" and index == "Value" then
            -- Supporting StringValue.Value for Rojo .txt file conv
            return StringValue_Value
        else -- Lastly, check "methods"
            local InstanceMethod = InstanceMethodProxies[index]

            if InstanceMethod then
                return InstanceMethod
            end
        end

        -- Next we'll look thru child refs
        for Child in next, Children do
            if Child.Name == index then
                return Child
            end
        end

        -- At this point, no member was found; this is the same err format as Roblox
        InvalidMember(index)
    end

    RefMetatable.__newindex = function(_, index, value)
        -- __newindex is only for props fyi
        if index == "ClassName" then
            ReadOnlyProperty(index)
        elseif index == "Name" then
            name = value
        elseif index == "Parent" then
            -- We'll just ignore the process if it's trying to set itself
            if value == Ref then
                return
            end

            if parent ~= nil then
                -- Remove this ref from the CURRENT parent
                RefChildren[parent][Ref] = nil
            end

            parent = value

            if value ~= nil then
                -- And NOW we're setting the new parent
                RefChildren[value][Ref] = true
            end
        elseif className == "StringValue" and index == "Value" then
            -- Supporting StringValue.Value for Rojo .txt file conv
            StringValue_Value = value
        else
            -- Same err as __index when no member is found
            InvalidMember(index)
        end
    end

    RefMetatable.__tostring = function()
        return name
    end

    setmetatable(Ref, RefMetatable)

    RefChildren[Ref] = Children

    if parent ~= nil then
        RefChildren[parent][Ref] = true
    end

    return Ref
end

-- Create real ref DOM from object tree
local function CreateRefFromObject(object, parent)
    local RefId = object[1]
    local ClassNameId = object[2]
    local Properties = object[3] -- Optional
    local Children = object[4] -- Optional

    local ClassName = ClassNameIdBindings[ClassNameId]

    local Name = Properties and table_remove(Properties, 1) or ClassName

    local Ref = CreateRef(ClassName, Name, parent) -- 3rd arg may be nil if this is from root
    RefBindings[RefId] = Ref

    if Properties then
        for PropertyName, PropertyValue in next, Properties do
            Ref[PropertyName] = PropertyValue
        end
    end

    if Children then
        for _, ChildObject in next, Children do
            CreateRefFromObject(ChildObject, Ref)
        end
    end

    return Ref
end

local RealObjectRoot = CreateRef("Folder", "[" .. EnvName .. "]")
for _, Object in next, ObjectTree do
    CreateRefFromObject(Object, RealObjectRoot)
end

-- Now we'll set script closure refs and check if they should be ran as a BaseScript
for RefId, Closure in next, ClosureBindings do
    local Ref = RefBindings[RefId]

    ScriptClosures[Ref] = Closure
    ScriptClosureRefIds[Ref] = RefId

    local ClassName = Ref.ClassName
    if ClassName == "LocalScript" or ClassName == "Script" then
        table_insert(ScriptsToRun, Ref)
    end
end

local function LoadScript(scriptRef)
    local ScriptClassName = scriptRef.ClassName

    -- First we'll check for a cached module value (packed into a tbl)
    local StoredModuleValue = StoredModuleValues[scriptRef]
    if StoredModuleValue and ScriptClassName == "ModuleScript" then
        return unpack(StoredModuleValue)
    end

    local Closure = ScriptClosures[scriptRef]

    local function FormatError(originalErrorMessage)
        originalErrorMessage = tostring(originalErrorMessage)

        local VirtualFullName = scriptRef:GetFullName()

        -- Check for vanilla/Roblox format
        local OriginalErrorLine, BaseErrorMessage = string_match(originalErrorMessage, "[^:]+:(%d+): (.+)")

        if not OriginalErrorLine or not LineOffsets then
            return VirtualFullName .. ":*: " .. (BaseErrorMessage or originalErrorMessage)
        end

        OriginalErrorLine = tonumber(OriginalErrorLine)

        local RefId = ScriptClosureRefIds[scriptRef]
        local LineOffset = LineOffsets[RefId]

        local RealErrorLine = OriginalErrorLine - LineOffset + 1
        if RealErrorLine < 0 then
            RealErrorLine = "?"
        end

        return VirtualFullName .. ":" .. RealErrorLine .. ": " .. BaseErrorMessage
    end

    -- If it's a BaseScript, we'll just run it directly!
    if ScriptClassName == "LocalScript" or ScriptClassName == "Script" then
        local RunSuccess, ErrorMessage = pcall(Closure)
        if not RunSuccess then
            error(FormatError(ErrorMessage), 0)
        end
    else
        local PCallReturn = {pcall(Closure)}

        local RunSuccess = table_remove(PCallReturn, 1)
        if not RunSuccess then
            local ErrorMessage = table_remove(PCallReturn, 1)
            error(FormatError(ErrorMessage), 0)
        end

        StoredModuleValues[scriptRef] = PCallReturn
        return unpack(PCallReturn)
    end
end

-- We'll assign the actual func from the top of this output for flattening user globals at runtime
-- Returns (in a tuple order): wax, script, require
function ImportGlobals(refId)
    local ScriptRef = RefBindings[refId]

    local function RealCall(f, ...)
        local PCallReturn = {pcall(f, ...)}

        local CallSuccess = table_remove(PCallReturn, 1)
        if not CallSuccess then
            error(PCallReturn[1], 3)
        end

        return unpack(PCallReturn)
    end

    -- `wax.shared` index
    local WaxShared = table_freeze(setmetatable({}, {
        __index = SharedEnvironment,
        __newindex = function(_, index, value)
            SharedEnvironment[index] = value
        end,
        __len = function()
            return #SharedEnvironment
        end,
        __iter = function()
            return next, SharedEnvironment
        end,
    }))

    local Global_wax = table_freeze({
        -- From AOT variable imports
        version = WaxVersion,
        envname = EnvName,

        shared = WaxShared,

        -- "Real" globals instead of the env set ones
        script = script,
        require = require,
    })

    local Global_script = ScriptRef

    local function Global_require(module, ...)
        local ModuleArgType = type(module)

        local ErrorNonModuleScript = "Attempted to call require with a non-ModuleScript"
        local ErrorSelfRequire = "Attempted to call require with self"

        if ModuleArgType == "table" and RefChildren[module]  then
            if module.ClassName ~= "ModuleScript" then
                error(ErrorNonModuleScript, 2)
            elseif module == ScriptRef then
                error(ErrorSelfRequire, 2)
            end

            return LoadScript(module)
        elseif ModuleArgType == "string" and string_sub(module, 1, 1) ~= "@" then
            -- The control flow on this SUCKS

            if #module == 0 then
                error("Attempted to call require with empty string", 2)
            end

            local CurrentRefPointer = ScriptRef

            if string_sub(module, 1, 1) == "/" then
                CurrentRefPointer = RealObjectRoot
            elseif string_sub(module, 1, 2) == "./" then
                module = string_sub(module, 3)
            end

            local PreviousPathMatch
            for PathMatch in string_gmatch(module, "([^/]*)/?") do
                local RealIndex = PathMatch
                if PathMatch == ".." then
                    RealIndex = "Parent"
                end

                -- Don't advance dir if it's just another "/" either
                if RealIndex ~= "" then
                    local ResultRef = CurrentRefPointer:FindFirstChild(RealIndex)
                    if not ResultRef then
                        local CurrentRefParent = CurrentRefPointer.Parent
                        if CurrentRefParent then
                            ResultRef = CurrentRefParent:FindFirstChild(RealIndex)
                        end
                    end

                    if ResultRef then
                        CurrentRefPointer = ResultRef
                    elseif PathMatch ~= PreviousPathMatch and PathMatch ~= "init" and PathMatch ~= "init.server" and PathMatch ~= "init.client" then
                        error("Virtual script path \"" .. module .. "\" not found", 2)
                    end
                end

                -- For possible checks next cycle
                PreviousPathMatch = PathMatch
            end

            if CurrentRefPointer.ClassName ~= "ModuleScript" then
                error(ErrorNonModuleScript, 2)
            elseif CurrentRefPointer == ScriptRef then
                error(ErrorSelfRequire, 2)
            end

            return LoadScript(CurrentRefPointer)
        end

        return RealCall(require, module, ...)
    end

    -- Now, return flattened globals ready for direct runtime exec
    return Global_wax, Global_script, Global_require
end

for _, ScriptRef in next, ScriptsToRun do
    Defer(LoadScript, ScriptRef)
end

-- AoT adjustment: Load init module (MainModule behavior)
return LoadScript(RealObjectRoot:GetChildren()[1])