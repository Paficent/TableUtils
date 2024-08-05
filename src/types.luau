--!strict
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