--!strict
--!native
--!optimize 2
--// Paficent \\

local TableUtil = {}

TableUtil.Array = require(script.Array)
TableUtil.Table = require(script.Table)

export type Array<T> = { T }
export type Table<K, V> = { [K]: V }
export type NestedTable<K, V> = { [K]: V | NestedTable<K, V> }

return TableUtil
