--!strict
--!native
--!optimize 2
--// Paficent \\

local Array = {}
local Types = require(script.Parent.util.types)

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