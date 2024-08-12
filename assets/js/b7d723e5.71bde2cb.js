"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[262],{10413:e=>{e.exports=JSON.parse('{"functions":[{"name":"chunk","desc":"Splits an array into chunks of a specified size.\\n\\n\\n```lua\\n-- Define an array\\nlocal myArray = {1, 2, 3, 4, 5}\\n\\n-- Chunk the array\\nlocal chunks = TableUtils.chunk(myArray, 2)\\nfor _, chunk in ipairs(chunks) do\\n    print(table.concat(chunk, \\", \\"))\\nend\\n-- Output:\\n-- 1, 2\\n-- 3, 4\\n-- 5\\n```","params":[{"name":"array","desc":"The inputted array","lua_type":"Array<V>"},{"name":"size","desc":"The size of each chunk","lua_type":"number"}],"returns":[{"desc":"An array containing chunks of the original array","lua_type":"Array<Array<V>>"}],"function_type":"static","source":{"line":76,"path":"src/init.luau"}},{"name":"clone","desc":"Creates a deep copy of a nested dictionary.\\n\\n\\n```lua\\n-- Define a nested dictionary\\nlocal myDict = {a = {b = 1}, c = 2}\\n\\n-- Clone the dictionary\\nlocal clonedDict = TableUtils.clone(myDict)\\nprint(clonedDict.a.b) -- Output: 1\\nprint(clonedDict.c)   -- Output: 2\\n```","params":[{"name":"tbl","desc":"The dictionary to clone","lua_type":"NestedDict<K, V>"}],"returns":[{"desc":"A new dictionary that is a deep copy of the original","lua_type":"NestedDict<K, V>"}],"function_type":"static","source":{"line":119,"path":"src/init.luau"}},{"name":"cloneShallow","desc":"Creates a shallow copy of a dictionary.\\n\\n\\n```lua\\n-- Define a dictionary\\nlocal myDict = {a = 1, b = 2}\\n\\n-- Create a shallow copy\\nlocal shallowCopy = TableUtils.cloneShallow(myDict)\\nprint(shallowCopy.a) -- Output: 1\\nprint(shallowCopy.b) -- Output: 2\\n```","params":[{"name":"tbl","desc":"The dictionary to clone","lua_type":"Dictionary<K, V>"}],"returns":[{"desc":"A new dictionary that is a shallow copy of the original","lua_type":"Dictionary<K, V>"}],"function_type":"static","source":{"line":151,"path":"src/init.luau"}},{"name":"every","desc":"Checks if all elements in a dictionary satisfy a condition.\\n\\n\\n```lua\\n-- Define a dictionary\\nlocal myDict = {a = 2, b = 4, c = 6}\\n\\n-- Check if all values are even\\nlocal allEven = TableUtils.every(myDict, function(key, value)\\n    return value % 2 == 0\\nend)\\nprint(allEven) -- Output: true\\n```","params":[{"name":"tbl","desc":"The input dictionary","lua_type":"Dictionary<K, V>"},{"name":"predicate","desc":"A predicate function to check elements","lua_type":"(key: K, value: V) -> boolean"}],"returns":[{"desc":"Returns true if all elements satisfy the condition, otherwise false","lua_type":"boolean"}],"function_type":"static","source":{"line":178,"path":"src/init.luau"}},{"name":"filter","desc":"Filters elements of a dictionary based on a predicate function.\\n\\n\\n```lua\\n-- Define a dictionary\\nlocal myDict = {a = 1, b = 2, c = 3}\\n\\n-- Filter values greater than 1\\nlocal filteredValues = TableUtils.filter(myDict, function(key, value)\\n    return value > 1\\nend)\\nprint(table.concat(filteredValues, \\", \\")) -- Output: 2, 3\\n```","params":[{"name":"tbl","desc":"The input dictionary","lua_type":"Dictionary<K, V>"},{"name":"predicate","desc":"A predicate function to determine which elements to include","lua_type":"(key: K, value: V) -> boolean"}],"returns":[{"desc":"An array of values that satisfy the predicate","lua_type":"Array<V>"}],"function_type":"static","source":{"line":206,"path":"src/init.luau"}},{"name":"find","desc":"Finds the first element in a dictionary that matches a given condition.\\n\\n\\n```lua\\n-- Define a dictionary\\nlocal myDict = {a = 1, b = 2, c = 3}\\n\\n-- Find the first value greater than 1\\nlocal result = TableUtils.find(myDict, function(key, value)\\n    return value > 1\\nend)\\nprint(result) -- Output: 2\\n```","params":[{"name":"tbl","desc":"The input dictionary","lua_type":"Dictionary<K, V>"},{"name":"predicate","desc":"A predicate function to determine the matching element","lua_type":"(key: K, value: V) -> boolean"}],"returns":[{"desc":"The first element that matches the predicate, or nil if no match is found","lua_type":"V?"}],"function_type":"static","source":{"line":235,"path":"src/init.luau"}},{"name":"findRecursive","desc":"Recursively finds and replaces values in a dictionary based on a predicate function.\\n\\n\\n```lua\\n-- Define a dictionary\\nlocal myDict = {a = 1, b = {c = 2, d = 3}}\\n\\n-- Recursively replace values equal to 2 with 99\\nlocal newDict = TableUtils.findRecursive(myDict, 99, function(key, value)\\n    return value == 2\\nend)\\nprint(newDict.b.c) -- Output: 99\\n```","params":[{"name":"tbl","desc":"The dictionary to search through","lua_type":"Dictionary<K, V>"},{"name":"value","desc":"The value to replace with","lua_type":"any"},{"name":"predicate","desc":"A predicate function to determine if an item should be replaced","lua_type":"(key: K, value: V) -> boolean"}],"returns":[{"desc":"A new dictionary with values replaced based on the predicate","lua_type":"Dictionary<K, V>"}],"function_type":"static","source":{"line":265,"path":"src/init.luau"}},{"name":"flatten","desc":"Flattens a nested dictionary into a single-level array.\\n\\n\\n```lua\\n-- Define a nested dictionary\\nlocal myDict = {a = 1, b = {c = 2, d = 3}}\\n\\n-- Flatten the dictionary\\nlocal flattened = TableUtils.flatten(myDict)\\nprint(table.concat(flattened, \\", \\")) -- Output: 1, 2, 3\\n```","params":[{"name":"tbl","desc":"The input nested dictionary","lua_type":"NestedDict<K, V>"}],"returns":[{"desc":"A single-level array containing all values from the nested dictionary","lua_type":"Array<V>"}],"function_type":"static","source":{"line":299,"path":"src/init.luau"}},{"name":"indexOf","desc":"Finds the index of a value within the inputted array.\\n\\n\\n```lua\\n-- Define an array\\nlocal myArray = {1, 2, 3, 4, 5}\\n\\n-- Find the index of a value\\nprint(TableUtils.indexOf(myArray, 3)) -- Output: 3\\n\\n-- Find the index of a non-existent value\\nprint(TableUtils.indexOf(myArray, 6)) -- Output: -1\\n```","params":[{"name":"array","desc":"The inputted array","lua_type":"Array<V>"},{"name":"value","desc":"The value to search for in the array","lua_type":"V"}],"returns":[{"desc":"Returns the index of value, if not found returns -1","lua_type":"number"}],"function_type":"static","source":{"line":334,"path":"src/init.luau"}},{"name":"isArray","desc":"Checks if the inputted table is an array.\\n\\n\\n```lua\\n-- Define an array\\nlocal myArray = {1, 2, 3, 4, 5}\\n\\n-- Check if it is an array\\nprint(TableUtils.isArray(myArray)) -- Output: true\\n\\n-- Define a non-array table\\nlocal myTable = {a = 1, b = 2}\\n\\n-- Check if it is an array\\nprint(TableUtils.isArray(myTable)) -- Output: false\\n```","params":[{"name":"tbl","desc":"The inputted array or table","lua_type":"Array<V> | Table<any, V>"}],"returns":[{"desc":"Returns whether or not the input table is an array","lua_type":"boolean"}],"function_type":"static","source":{"line":368,"path":"src/init.luau"}},{"name":"keys","desc":"Gets all keys from a dictionary.\\n\\n\\n```lua\\n-- Define a dictionary\\nlocal myDict = {a = 1, b = 2, c = 3}\\n\\n-- Get all keys\\nlocal keys = TableUtils.keys(myDict)\\nprint(table.concat(keys, \\", \\")) -- Output: a, b, c\\n```","params":[{"name":"tbl","desc":"The input dictionary","lua_type":"Dictionary<K, V>"}],"returns":[{"desc":"An array containing all keys from the dictionary","lua_type":"Array<K>"}],"function_type":"static","source":{"line":387,"path":"src/init.luau"}},{"name":"length","desc":"Counts the number of items in an array.\\n\\n\\n```lua\\n-- Define an array\\nlocal myArray = {1, 2, 3, 4, 5}\\n\\n-- Find the length of the array\\nprint(TableUtils.length(myArray)) -- Output: 5\\n```","params":[{"name":"array","desc":"The inputted array","lua_type":"Array<V>"}],"returns":[{"desc":"Returns the total number of objects within an array","lua_type":"number"}],"function_type":"static","source":{"line":409,"path":"src/init.luau"}},{"name":"map","desc":"Maps each element in an array to a new value based on a callback function.\\n\\n\\n```lua\\n-- Define an array\\nlocal myArray = {1, 2, 3, 4, 5}\\n\\n-- Map array elements\\nlocal mappedArray = TableUtils.map(myArray, function(index, value)\\n    return value * 2\\nend)\\nprint(table.concat(mappedArray, \\", \\")) -- Output: 2, 4, 6, 8, 10\\n```","params":[{"name":"array","desc":"The inputted array","lua_type":"Array<V>"},{"name":"callback","desc":"A callback function that maps values to a new type","lua_type":"(index: number, value: V) -> R"}],"returns":[{"desc":"A new array with mapped values","lua_type":"Array<R>"}],"function_type":"static","source":{"line":435,"path":"src/init.luau"}},{"name":"merge","desc":"Merges multiple arrays or dictionaries into one. \\n\\nFor arrays, the function concatenates all input arrays into a single array.\\nFor dictionaries, the function combines all input dictionaries into a single dictionary.\\n\\n\\n\\n```lua\\n-- Define arrays to merge\\nlocal array1 = {1, 2}\\nlocal array2 = {3, 4}\\nlocal array3 = {5, 6}\\n\\n-- Merge arrays\\nlocal mergedArray = TableUtils.merge(array1, array2, array3)\\nprint(table.concat(mergedArray, \\", \\")) -- Output: 1, 2, 3, 4, 5, 6\\n\\n-- Define dictionaries to merge\\nlocal dict1 = {a = 1, b = 2}\\nlocal dict2 = {c = 3, d = 4}\\n\\n-- Merge dictionaries\\nlocal mergedDict = TableUtils.merge(dict1, dict2)\\nfor k, v in pairs(mergedDict) do\\n    print(k, v)\\nend\\n-- Output:\\n-- a 1\\n-- b 2\\n-- c 3\\n-- d 4\\n```","params":[{"name":"...","desc":"Arrays or dictionaries to be merged","lua_type":"(Array<V> | Dictionary<K, V>)"}],"returns":[{"desc":"A new array or dictionary containing all elements from the input tables","lua_type":"(Array<V> | Dictionary<K, V>)"}],"function_type":"static","source":{"line":492,"path":"src/init.luau"}},{"name":"mergeDeep","desc":"Deeply merges multiple nested dictionaries into one.\\n\\n\\n```lua\\n-- Define nested dictionaries to merge\\nlocal dict1 = {a = {x = 1}, b = 2}\\nlocal dict2 = {a = {y = 2}, c = 3}\\n\\n-- Deeply merge dictionaries\\nlocal mergedDict = TableUtils.mergeDeep(dict1, dict2)\\nprint(mergedDict.a.x) -- Output: 1\\nprint(mergedDict.a.y) -- Output: 2\\nprint(mergedDict.b)   -- Output: 2\\nprint(mergedDict.c)   -- Output: 3\\n```","params":[{"name":"...","desc":"Nested dictionaries to be merged","lua_type":"NestedDict<K, V>"}],"returns":[{"desc":"A new nested dictionary containing all key-value pairs from the input dictionaries","lua_type":"NestedDict<K, V>"}],"function_type":"static","source":{"line":551,"path":"src/init.luau"}},{"name":"reduce","desc":"Reduces an array to a single value based on a callback function and an initial value.\\n\\n\\n```lua\\n-- Define an array\\nlocal myArray = {1, 2, 3, 4, 5}\\n\\n-- Reduce the array elements to a single value (sum)\\nlocal sum = TableUtils.reduce(myArray, function(accumulator, value, index)\\n    return accumulator + value\\nend, 0)\\nprint(sum) -- Output: 15\\n```","params":[{"name":"array","desc":"The inputted array","lua_type":"Array<V>"},{"name":"callback","desc":"A callback function to reduce values","lua_type":"(accumulator: V, index: number, value: U) -> U"},{"name":"initialValue","desc":"The initial value for the reduction","lua_type":"U"}],"returns":[{"desc":"The final reduced value","lua_type":"U"}],"function_type":"static","source":{"line":593,"path":"src/init.luau"}},{"name":"reverse","desc":"Reverses the elements of an array in place.\\n\\n\\n```lua\\n-- Define an array\\nlocal myArray = {1, 2, 3, 4, 5}\\n\\n-- Reverse the array\\nlocal reversedArray = TableUtils.reverse(myArray)\\nprint(table.concat(reversedArray, \\", \\")) -- Output: 5, 4, 3, 2, 1\\n```","params":[{"name":"array","desc":"The inputted array","lua_type":"Array<V>"}],"returns":[{"desc":"The reversed array","lua_type":"Array<V>"}],"function_type":"static","source":{"line":621,"path":"src/init.luau"}},{"name":"some","desc":"Checks if at least one element in a dictionary satisfies a condition.\\n\\n\\n```lua\\n-- Define a dictionary\\nlocal myDict = {a = 1, b = 2, c = 3}\\n\\n-- Check if any value is greater than 2\\nlocal hasGreaterThan2 = TableUtils.some(myDict, function(key, value)\\n    return value > 2\\nend)\\nprint(hasGreaterThan2) -- Output: true\\n```","params":[{"name":"tbl","desc":"The input dictionary","lua_type":"Dictionary<K, V>"},{"name":"predicate","desc":"A predicate function to check elements","lua_type":"(key: K, value: V) -> boolean"}],"returns":[{"desc":"Returns true if at least one element satisfies the condition, otherwise false","lua_type":"boolean"}],"function_type":"static","source":{"line":654,"path":"src/init.luau"}},{"name":"unique","desc":"Removes duplicate values from an array.\\n\\n\\n```lua\\n-- Define an array with duplicates\\nlocal myArray = {1, 2, 2, 3, 4, 4, 5}\\n\\n-- Remove duplicates\\nlocal uniqueArray = TableUtils.unique(myArray)\\nprint(table.concat(uniqueArray, \\", \\")) -- Output: 1, 2, 3, 4, 5\\n```","params":[{"name":"array","desc":"The inputted array","lua_type":"Array<V>"}],"returns":[{"desc":"A new array with duplicate values removed","lua_type":"Array<V>"}],"function_type":"static","source":{"line":679,"path":"src/init.luau"}}],"properties":[],"types":[{"name":"Array<V>","desc":"A table composed strictly of values with the type of \'V\'","lua_type":"{ V }","source":{"line":17,"path":"src/init.luau"}},{"name":"Dictionary<K,V>","desc":"A table composed strictly of keys with the type of \'K\', and values with the type of \'V\'","lua_type":"{ [K]: V }","source":{"line":24,"path":"src/init.luau"}},{"name":"NestedDic<K,V>","desc":"A table composed strictly of keys with the type of \'K\', and values with the type of \'V\', this table can also be nested.","lua_type":"{ [K]: V | NestedDict }","source":{"line":31,"path":"src/init.luau"}}],"name":"TableUtils","desc":"This is my first class.","source":{"line":10,"path":"src/init.luau"}}')}}]);