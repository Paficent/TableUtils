--!strict
local Table = {}

export type Array<T> = { T }
export type Table<K, V> = { [K]: V }
type callbackFunc<K, V> = ( key: K, value: V) -> boolean
type mapCallbackFunc<T, U> = (index: number, value: T) -> U

local recursiveFind
function recursiveFind<K>(tbl: Table<K, any>, value: any, isLocated: callbackFunc<K,any>): Table<K,any> -- For some reason this doesn't work with <K,V> so for now Value can be type any
	local NewTable = {}

	for Key, Val in pairs(tbl) do
		NewTable[Key] = Val
		if type(Val) == "table" then
			NewTable[Key] = recursiveFind(tbl, value, isLocated)
		end
		if isLocated(Key, Val) then
			NewTable[Key] = value
		end
	end

	return NewTable
end

--/ Array Functions
function Table.isArray<V>(tbl: Array<V>): boolean
	if typeof(tbl) ~= "table" then
		return false
	end

	for key in tbl :: any do
		if typeof(key) ~= "number" then
			return false
		end
	end

	return true
end

function Table.length<V>(array: Array<V>): number
	if not Table.isArray(array) then
		error("Table.reverse called on non-array")
	end

	return #array
end

function Table.reverse<V>(array: Array<V>): Array<V>
	if not Table.isArray(array) then
		error("Table.reverse called on non-array")
	end

	local Num = Table.length(array)
	local i = 1

	while i < Num do
		array[i], array[Num] = array[Num],array[i]
		i = i + 1
		Num = Num - 1
	end

	return array
end

function Table.indexOf<V>(array: Array<V>, value: V): number
	if not Table.isArray(array) then
		error("Table.reverse called on non-array")
	end
	
	for Index, Val in ipairs(array) do
		if Val == value then
			return Index
		end
	end

	return -1
end

function Table.map<V, R>(array: Array<V>, callback: mapCallbackFunc<V, R>): Array<R>
	if not Table.isArray(array) then
		error(string.format("Table.map called on non-array"))
	end

	if typeof(callback) ~= "function" then
		error("Invalid usage: 'callback' is not a function")
	end
  
	local newTable = {}

	for i, value in array do
		local mappedValue: R = callback(i, value)
  
		if mappedValue ~= nil then
			table.insert(newTable, mappedValue)
		end
	end
  
	return newTable
end

function Table.mergei<V>(...: Array<V>): Array <V>
	local Arrays = { ... }
	local NewArray = {}

	for Index, currentArray in ipairs(Arrays) do
		if not Table.isArray(currentArray) then
			error("Table.mergei called on non-array ")
		end

		table.move(currentArray, 1, #currentArray, #NewArray + 1, NewArray)
	end

	return NewArray
end



--// Table Functions
function Table.keys<K, V>(tbl: Table<K, V>): Array<K>
	local NewTable = {}

	for Key, Value in pairs(tbl) do
		NewTable[#NewTable + 1] = Key
	end

	return NewTable
end

function Table.merge<K,V>(...: Table<K, V>): Table<K, V>
	local NewTable = {}
	local Tables = { ... }

	for _, CurrentTable in ipairs(Tables) do
		for Key, Value in pairs(CurrentTable) do
			NewTable[Key] = Value
		end
	end

	return NewTable
end

function Table.filter<K, V>(tbl: Table<K, V>, callback: callbackFunc<K, V>): Array<V>
	if typeof(callback) ~= "function" then
		error("Invalid usage: 'callback' is not a function")
	end

	local NewTable = {}

	for Key, Value in next, tbl do
		if callback(Key, Value) then
			NewTable[#NewTable + 1] = Value
		end
	end

	return NewTable
end

Table.recursiveFind = recursiveFind
Table.dump = require("src/Dump")

return Table