local sharedTypes = {}

export type Array<T> = { T }
export type Table<K, V> = { [K]: V }
export type NestedTable<K, V> = { [K]: V | NestedTable<K, V> }
export type predicateFunc<K, V> = (key: K, value: V) -> boolean
export type mapCallbackFunc<T, U> = (index: number, value: T) -> U
export type reduceCallbackFunc<T, U> = (accumulator: U, value: T, index: number) -> U

return sharedTypes