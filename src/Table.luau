--!strict
--!native
--!optimize 2
--// Paficent \\

local Table = {}
local Types = require(script.Parent.util.types)


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