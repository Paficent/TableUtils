--!strict
--!native
--// Made By Paficent \\

--[=[
    @class TableUtils

    A robust and strictly typed Luau library with functions specifically designed for manipulating tables.
]=]

--[=[
    @type Array<V> { V }
    @within TableUtils

    A table composed strictly of values with the type of 'V'
]=]

--[=[
    @type Dictionary<K,V> { [K]: V }
    @within TableUtils

    A table composed strictly of keys with the type of 'K', and values with the type of 'V'
]=]

--[=[
    @type NestedDict<K,V> { [K]: V | NestedDict }
    @within TableUtils

    A table composed strictly of keys with the type of 'K', and values with the type of 'V', this table can also be nested.
]=]

local TableUtils = {}

export type Array<V> = { V }
export type Dictionary<K, V> = { [K]: V }
export type NestedDict<K, V> = { [K]: V | NestedDict<K, V> }

type PredicateFunc<K, V> = (key: K, value: V) -> boolean

local function isArray<V>(tbl: Array<V> | Dictionary<any, V>): boolean
	if typeof(tbl) ~= "table" then
		return false
	end

	for key in pairs(tbl) do
		if typeof(key) ~= "number" then
			return false
		end
	end

	return true
end

--[=[
    Splits an array into chunks of a specified size.

    @param array Array<V> -- The inputted array
    @param size number -- The size of each chunk
    @return Array<Array<V>> -- An array containing chunks of the original array

    ```lua
    -- Define an array
    local myArray = {1, 2, 3, 4, 5}

    -- Chunk the array
    local chunks = TableUtils.chunk(myArray, 2)
    for _, chunk in ipairs(chunks) do
        print(table.concat(chunk, ", "))
    end
    -- Output:
    -- 1, 2
    -- 3, 4
    -- 5
    ```
]=]
function TableUtils.chunk<V>(array: Array<V>, size: number): Array<Array<V>>
	if not isArray(array) then
		error("TableUtils.chunk called on non-array")
	end

	if size <= 0 then
		error("Chunk size must be greater than 0")
	end

	local result: Array<Array<V>> = {}
	local chunk: Array<V> = {}

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

--[=[
    Creates a deep copy of a nested dictionary.

    @param tbl NestedDict<K, V> -- The dictionary to clone
    @return NestedDict<K, V> -- A new dictionary that is a deep copy of the original

    ```lua
    -- Define a nested dictionary
    local myDict = {a = {b = 1}, c = 2}

    -- Clone the dictionary
    local clonedDict = TableUtils.clone(myDict)
    print(clonedDict.a.b) -- Output: 1
    print(clonedDict.c)   -- Output: 2
    ```
]=]
function TableUtils.clone<K, V>(tbl: NestedDict<K, V>): NestedDict<K, V>
	local function cloneTable(tbl: NestedDict<K, V>): NestedDict<K, V>
		local newTable: NestedDict<K, V> = {}
		for key, value in pairs(tbl) do
			if typeof(value) == "table" then
				newTable[key] = cloneTable(value :: NestedDict<K, V>)
			else
				newTable[key] = value
			end
		end
		return newTable
	end

	return cloneTable(tbl)
end

--[=[
    Creates a shallow copy of a dictionary.

    @param tbl Dictionary<K, V> -- The dictionary to clone
    @return Dictionary<K, V> -- A new dictionary that is a shallow copy of the original

    ```lua
    -- Define a dictionary
    local myDict = {a = 1, b = 2}

    -- Create a shallow copy
    local shallowCopy = TableUtils.cloneShallow(myDict)
    print(shallowCopy.a) -- Output: 1
    print(shallowCopy.b) -- Output: 2
    ```
]=]
function TableUtils.cloneShallow<K, V>(tbl: Dictionary<K, V>): Dictionary<K, V>
	local clone = {}
	for key, value in pairs(tbl) do
		clone[key] = value
	end
	return clone
end

--[=[
    Checks if all elements in a dictionary satisfy a condition.

    @param tbl Dictionary<K, V> -- The input dictionary
    @param predicate (key: K, value: V) -> boolean -- A predicate function to check elements
    @return boolean -- Returns true if all elements satisfy the condition, otherwise false

    ```lua
    -- Define a dictionary
    local myDict = {a = 2, b = 4, c = 6}

    -- Check if all values are even
    local allEven = TableUtils.every(myDict, function(key, value)
        return value % 2 == 0
    end)
    print(allEven) -- Output: true
    ```
]=]
function TableUtils.every<K, V>(tbl: Dictionary<K, V>, predicate: PredicateFunc<K, V>): boolean
	assert(type(predicate) == "function", "Predicate must be a function")
	for key, value in pairs(tbl) do
		if not predicate(key, value) then
			return false
		end
	end
	return true
end

--[=[
    Filters elements of a dictionary based on a predicate function.

    @param tbl Dictionary<K, V> -- The input dictionary
    @param predicate (key: K, value: V) -> boolean -- A predicate function to determine which elements to include
    @return Array<V> -- An array of values that satisfy the predicate

    ```lua
    -- Define a dictionary
    local myDict = {a = 1, b = 2, c = 3}

    -- Filter values greater than 1
    local filteredValues = TableUtils.filter(myDict, function(key, value)
        return value > 1
    end)
    print(table.concat(filteredValues, ", ")) -- Output: 2, 3
    ```
]=]
function TableUtils.filter<K, V>(tbl: Dictionary<K, V>, predicate: PredicateFunc<K, V>): Array<V>
	assert(type(predicate) == "function", "Predicate must be a function")
	local results = {}
	for key, value in pairs(tbl) do
		if predicate(key, value) then
			table.insert(results, value)
		end
	end
	return results
end

--[=[
    Finds the first element in a dictionary that matches a given condition.

    @param tbl Dictionary<K, V> -- The input dictionary
    @param predicate (key: K, value: V) -> boolean -- A predicate function to determine the matching element
    @return V? -- The first element that matches the predicate, or nil if no match is found

    ```lua
    -- Define a dictionary
    local myDict = {a = 1, b = 2, c = 3}

    -- Find the first value greater than 1
    local result = TableUtils.find(myDict, function(key, value)
        return value > 1
    end)
    print(result) -- Output: 2
    ```
]=]
function TableUtils.find<K, V>(tbl: Dictionary<K, V>, predicate: PredicateFunc<K, V>): V?
	assert(type(predicate) == "function", "Predicate must be a function")
	for key, value in pairs(tbl) do
		if predicate(key, value) then
			return value
		end
	end
	return nil
end

--[=[
    Recursively finds and replaces values in a dictionary based on a predicate function.

    @param tbl Dictionary<K, V> -- The dictionary to search through
    @param value any -- The value to replace with
    @param predicate (key: K, value: V) -> boolean -- A predicate function to determine if an item should be replaced
    @return Dictionary<K, V> -- A new dictionary with values replaced based on the predicate

    ```lua
    -- Define a dictionary
    local myDict = {a = 1, b = {c = 2, d = 3}}

    -- Recursively replace values equal to 2 with 99
    local newDict = TableUtils.findRecursive(myDict, 99, function(key, value)
        return value == 2
    end)
    print(newDict.b.c) -- Output: 99
    ```
]=]
function TableUtils.findRecursive<K>(
	tbl: Dictionary<K, any>,
	value: any,
	predicate: PredicateFunc<K, any>
): Dictionary<K, any>
	local function findRecursiveHelper(currentTbl: Dictionary<K, any>): Dictionary<K, any>
		local newTable: Dictionary<K, any> = {}
		for key, val in pairs(currentTbl) do
			if typeof(val) == "table" then
				newTable[key] = findRecursiveHelper(val :: Dictionary<K, any>)
			else
				newTable[key] = val
			end
			if predicate(key, val) then
				newTable[key] = value
			end
		end
		return newTable
	end

	return findRecursiveHelper(tbl)
end

--[=[
    Flattens a nested dictionary into a single-level array.

    @param tbl NestedDict<K, V> -- The input nested dictionary
    @return Array<V> -- A single-level array containing all values from the nested dictionary

    ```lua
    -- Define a nested dictionary
    local myDict = {a = 1, b = {c = 2, d = 3}}

    -- Flatten the dictionary
    local flattened = TableUtils.flatten(myDict)
    print(table.concat(flattened, ", ")) -- Output: 1, 2, 3
    ```
]=]
function TableUtils.flatten<K, V>(tbl: NestedDict<K, V>): Array<V>
	local result = {}

	local function flattenRecursively(subTable: NestedDict<K, V>)
		for _, value in pairs(subTable) do
			if typeof(value) == "table" then
				flattenRecursively(value :: NestedDict<K, V>)
			else
				table.insert(result, value)
			end
		end
	end

	flattenRecursively(tbl)
	return result
end

--[=[
    Finds the index of a value within the inputted array.

    @param array Array<V> -- The inputted array
    @param value V -- The value to search for in the array
    @return number -- Returns the index of value, if not found returns -1

    ```lua
    -- Define an array
    local myArray = {1, 2, 3, 4, 5}

    -- Find the index of a value
    print(TableUtils.indexOf(myArray, 3)) -- Output: 3

    -- Find the index of a non-existent value
    print(TableUtils.indexOf(myArray, 6)) -- Output: -1
    ```
]=]
function TableUtils.indexOf<V>(array: Array<V>, value: V): number
	if not isArray(array) then
		error("TableUtils.indexOf called on non-array")
	end

	for index, val in ipairs(array) do
		if val == value then
			return index
		end
	end

	return -1
end

--[=[
    Checks if the inputted table is an array.

    @param tbl Array<V> | Table<any, V> -- The inputted array or table
    @return boolean -- Returns whether or not the input table is an array

    ```lua
    -- Define an array
    local myArray = {1, 2, 3, 4, 5}

    -- Check if it is an array
    print(TableUtils.isArray(myArray)) -- Output: true

    -- Define a non-array table
    local myTable = {a = 1, b = 2}

    -- Check if it is an array
    print(TableUtils.isArray(myTable)) -- Output: false
    ```
]=]
function TableUtils.isArray<V>(tbl: Array<V> | Dictionary<any, V>): boolean
	return isArray(tbl)
end

--[=[
    Gets all keys from a dictionary.

    @param tbl Dictionary<K, V> -- The input dictionary
    @return Array<K> -- An array containing all keys from the dictionary

    ```lua
    -- Define a dictionary
    local myDict = {a = 1, b = 2, c = 3}

    -- Get all keys
    local keys = TableUtils.keys(myDict)
    print(table.concat(keys, ", ")) -- Output: a, b, c
    ```
]=]
function TableUtils.keys<K, V>(tbl: Dictionary<K, V>): Array<K>
	local keys = {}
	for key in pairs(tbl) do
		table.insert(keys, key)
	end
	return keys
end

--[=[
    Counts the number of items in an array.

    @param array Array<V> -- The inputted array
    @return number -- Returns the total number of objects within an array

    ```lua
    -- Define an array
    local myArray = {1, 2, 3, 4, 5}

    -- Find the length of the array
    print(TableUtils.length(myArray)) -- Output: 5
    ```
]=]
function TableUtils.length<V>(array: Array<V>): number
	if not isArray(array) then
		error("TableUtils.length called on non-array")
	end

	return #array
end

--[=[
    Maps each element in an array to a new value based on a callback function.

    @param array Array<V> -- The inputted array
    @param callback (index: number, value: V) -> R -- A callback function that maps values to a new type
    @return Array<R> -- A new array with mapped values

    ```lua
    -- Define an array
    local myArray = {1, 2, 3, 4, 5}

    -- Map array elements
    local mappedArray = TableUtils.map(myArray, function(index, value)
        return value * 2
    end)
    print(table.concat(mappedArray, ", ")) -- Output: 2, 4, 6, 8, 10
    ```
]=]
function TableUtils.map<V, R>(array: Array<V>, callback: (index: number, value: V) -> R): Array<R>
	if not isArray(array) then
		error("TableUtils.map called on non-array")
	end

	if typeof(callback) ~= "function" then
		error("Invalid usage: 'callback' is not a function")
	end

	local newArray: Array<R> = {}

	for i, value in ipairs(array) do
		local mappedValue: R = callback(i, value)
		if mappedValue ~= nil then
			table.insert(newArray, mappedValue)
		end
	end

	return newArray
end

--[=[
    Merges multiple arrays or dictionaries into one. 

    For arrays, the function concatenates all input arrays into a single array.
    For dictionaries, the function combines all input dictionaries into a single dictionary.
    

    @param ... (Array<V> | Dictionary<K, V>) -- Arrays or dictionaries to be merged
    @return (Array<V> | Dictionary<K, V>) -- A new array or dictionary containing all elements from the input tables

    ```lua
    -- Define arrays to merge
    local array1 = {1, 2}
    local array2 = {3, 4}
    local array3 = {5, 6}

    -- Merge arrays
    local mergedArray = TableUtils.merge(array1, array2, array3)
    print(table.concat(mergedArray, ", ")) -- Output: 1, 2, 3, 4, 5, 6

    -- Define dictionaries to merge
    local dict1 = {a = 1, b = 2}
    local dict2 = {c = 3, d = 4}

    -- Merge dictionaries
    local mergedDict = TableUtils.merge(dict1, dict2)
    for k, v in pairs(mergedDict) do
        print(k, v)
    end
    -- Output:
    -- a 1
    -- b 2
    -- c 3
    -- d 4
    ```
]=]
function TableUtils.merge(...: any): any
	local tables = { ... }

	-- Check if all tables are arrays or dictionaries
	local isAllArrays = true
	local isAllDictionaries = true

	for _, tbl in ipairs(tables) do
		if isArray(tbl) then
			isAllDictionaries = false
		elseif typeof(tbl) == "table" then
			isAllArrays = false
		else
			error("TableUtils.merge called with non-table argument")
		end
	end

	-- Handle arrays
	if isAllArrays then
		local newArray = {}
		for _, array in ipairs(tables) do
			table.move(array, 1, #array, #newArray + 1, newArray)
		end
		return newArray
	end

	-- Handle dictionaries
	if isAllDictionaries then
		local result = {}
		for _, tbl in ipairs(tables) do
			for key, value in pairs(tbl) do
				result[key] = value
			end
		end
		return result
	end

	error("TableUtils.merge called with mixed or incompatible table types")
end

--[=[
    Deeply merges multiple nested dictionaries into one.

    @param ... NestedDict<K, V> -- Nested dictionaries to be merged
    @return NestedDict<K, V> -- A new nested dictionary containing all key-value pairs from the input dictionaries

    ```lua
    -- Define nested dictionaries to merge
    local dict1 = {a = {x = 1}, b = 2}
    local dict2 = {a = {y = 2}, c = 3}

    -- Deeply merge dictionaries
    local mergedDict = TableUtils.mergeDeep(dict1, dict2)
    print(mergedDict.a.x) -- Output: 1
    print(mergedDict.a.y) -- Output: 2
    print(mergedDict.b)   -- Output: 2
    print(mergedDict.c)   -- Output: 3
    ```
]=]
function TableUtils.mergeDeep<K, V>(...: NestedDict<K, V>): NestedDict<K, V>
	local result: NestedDict<K, V> = {}

	local function merge(src: NestedDict<K, V>, dest: NestedDict<K, V>)
		for key, value in pairs(src) do
			if typeof(value) == "table" and typeof(dest[key]) == "table" then
				merge(value :: NestedDict<K, V>, dest[key] :: NestedDict<K, V>)
			elseif typeof(value) == "table" then
				dest[key] = TableUtils.mergeDeep(value :: NestedDict<K, V>) :: V | NestedDict<K, V>
			else
				dest[key] = value
			end
		end
	end

	for _, tbl in ipairs({ ... }) do
		merge(tbl, result)
	end

	return result
end

--[=[
    Reduces an array to a single value based on a callback function and an initial value.

    @param array Array<V> -- The inputted array
    @param callback (accumulator: V, index: number, value: U) -> U -- A callback function to reduce values
    @param initialValue U -- The initial value for the reduction
    @return U -- The final reduced value

    ```lua
    -- Define an array
    local myArray = {1, 2, 3, 4, 5}

    -- Reduce the array elements to a single value (sum)
    local sum = TableUtils.reduce(myArray, function(accumulator, value, index)
        return accumulator + value
    end, 0)
    print(sum) -- Output: 15
    ```
]=]
function TableUtils.reduce<V, U>(
	array: Array<V>,
	callback: (accumulator: U, index: number, value: V) -> U,
	initialValue: U
): U
	if not isArray(array) then
		error("TableUtils.reduce called on non-array")
	end

	local accumulator = initialValue
	for index, value in ipairs(array) do
		accumulator = callback(accumulator, index, value)
	end

	return accumulator
end

--[=[
    Reverses the elements of an array in place.

    @param array Array<V> -- The inputted array
    @return Array<V> -- The reversed array

    ```lua
    -- Define an array
    local myArray = {1, 2, 3, 4, 5}

    -- Reverse the array
    local reversedArray = TableUtils.reverse(myArray)
    print(table.concat(reversedArray, ", ")) -- Output: 5, 4, 3, 2, 1
    ```
]=]
function TableUtils.reverse<V>(array: Array<V>): Array<V>
	if not isArray(array) then
		error("TableUtils.reverse called on non-array")
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
    Checks if at least one element in a dictionary satisfies a condition.

    @param tbl Dictionary<K, V> -- The input dictionary
    @param predicate (key: K, value: V) -> boolean -- A predicate function to check elements
    @return boolean -- Returns true if at least one element satisfies the condition, otherwise false

    ```lua
    -- Define a dictionary
    local myDict = {a = 1, b = 2, c = 3}

    -- Check if any value is greater than 2
    local hasGreaterThan2 = TableUtils.some(myDict, function(key, value)
        return value > 2
    end)
    print(hasGreaterThan2) -- Output: true
    ```
]=]
function TableUtils.some<K, V>(tbl: Dictionary<K, V>, predicate: PredicateFunc<K, V>): boolean
	assert(type(predicate) == "function", "Predicate must be a function")
	for key, value in pairs(tbl) do
		if predicate(key, value) then
			return true
		end
	end
	return false
end

--[=[
    Removes duplicate values from an array.

    @param array Array<V> -- The inputted array
    @return Array<V> -- A new array with duplicate values removed

    ```lua
    -- Define an array with duplicates
    local myArray = {1, 2, 2, 3, 4, 4, 5}

    -- Remove duplicates
    local uniqueArray = TableUtils.unique(myArray)
    print(table.concat(uniqueArray, ", ")) -- Output: 1, 2, 3, 4, 5
    ```
]=]
function TableUtils.unique<V>(array: Array<V>): Array<V>
	if not isArray(array) then
		error("TableUtils.unique called on non-array")
	end

	local result: Array<V> = {}
	local seen: Dictionary<V, boolean> = {}

	for _, value in ipairs(array) do
		if not seen[value] then
			seen[value] = true
			table.insert(result, value)
		end
	end

	return result
end

-- --[=[
--     Merges multiple dictionaries into one.

--     @param ... Dictionary<K, V> -- Dictionaries to be merged
--     @return Dictionary<K, V> -- A new dictionary containing all key-value pairs from the input dictionaries

--     ```lua
--     -- Define dictionaries to merge
--     local dict1 = {a = 1, b = 2}
--     local dict2 = {c = 3, d = 4}

--     -- Merge dictionaries
--     local mergedDict = TableUtils.merge(dict1, dict2)
--     for key, value in pairs(mergedDict) do
--         print(key, value)
--     end
--     -- Output:
--     -- a 1
--     -- b 2
--     -- c 3
--     -- d 4
--     ```
-- ]=]
-- function TableUtils.mergeDeep<K, V>(...: NestedDict<K, V>): NestedDict<K, V>
--     local result: NestedDict<K, V> = {}

--     local function merge(src: NestedDict<K, V>, dest: NestedDict<K, V>)
--         for key, value in pairs(src) do
--             if type(value) == "table" then
--                 if type(dest[key]) == "table" then
--                     merge(value, dest[key] :: NestedDict<K, V>)
--                 else
--                     dest[key] = value
--                 end
--             else
--                 dest[key] = value
--             end
--         end
--     end

--     for _, tbl in ipairs({...}) do
--         if isArray(tbl) then
--             error("TableUtils.mergeDeep called with non-dictionary argument")
--         end
--         merge(tbl, result)
--     end

--     return result
-- end

return TableUtils
