# Table_Sort
For all your sorting needs of both arrays and dictionaries.
Orientated for use within Roblox

## What is this?
A module meant for Roblox. No idea how it would work with vanilla lua.
Has the functionality to sort both arrays and dictionaries.
When sorting dictionaries, it would just return the ordered array for the values in the dictionary since dictionaries are unordered, unlike arrays.
It currently features 2 sorting algorithms, **insertion sort** and **heap sort**.

## Caveats
- Unable to work with `nil` values.

## API
#### Module.new()
Creates and return a [SorterObj](https://github.com/FadedJayden/Table_Sort/blob/main/README.md#sorterobj).

## SorterObj
A class object that handles [parameters](https://github.com/FadedJayden/Table_Sort#properties) when sorting.
#### `:Sort(x)`
Sorts array `x`, will exclude non numeric datatypes, use [Deep Sort](https://github.com/FadedJayden/Table_Sort/blob/main/README.md#deepsortx) to include arrays.\
Only takes in 1 parameter.\
No changes will be made to `x` within the module.\
Skips `nil`, won't be added into returned list regardless of `IncludeNonSorted`.

#### `:DeepSort(x)`
Sorts array `x` along with nested arrays.\
Uses a recursive function to sort all of the numerical data within all of nested arrays.\
All nested arrays would be pushed to the very back.\
Won't sort non numeric datatypes.\
Only takes in 1 parameter.\
No changes will be made to `x` within the module.\
Skips `nil`, won't be added into returned list regardless of `IncludeNonSorted`.

### Properties
##### Algorithm
Datatype: `number`\
Default: `1`\
Determines the sorting algorithm used.\
1 - Heap Sort; Without the Heap Property\
2 - Insertion Sort\
3 - Bubble Sort

##### MaxRetries
Datatype: `number`\
Default: `5`\
Determines the amount of times to try when checking of ordered array fails.

##### Checks
Datatype: `boolean`\
Default: `true`\
Determine whether to check the sorted array.\
Uses [MaxRetries](https://github.com/FadedJayden/Table_Sort/blob/main/README.md#maxretries)

##### Ascending
Datatype: `boolean`\
Default: `true`\
Whether to sort the given array in ascending order.

##### Type
Datatype: `number`\
Default: `1`\
Type of table, 1 -- array; 2 -- dictionary.

##### SortKeys
Datatype: `boolean`\
Default: `false`\
Only applicable when sorting a dictionary,\
Instead of sorting the values of the dictionary, it sorts the keys.

##### IncludeNonSorted
Datatype: `boolean`\
Default: `false`\
When set to true, it will pack all of the non numerical datatypes from the given list at the very end of the returned list.

## Sorting Stats
Took average time sorted from 100 samples.\
Each list contained arbitrary numbers from `-100` to `100`.\
Small List: 10 Items.\
Medium List: 100 Items.\
Big List: 1000 Items.

**Algorithm 1; Heap Sort**
- Small List: 0.02533ms\
- Medium List: 0.67227ms\
- Big List: 57.64493ms

**Algorithm 2; Insertion Sort**
- Small List: 0.01868ms\
- Medium List: 0.43559ms\
- Big List: 35.33016ms

**Algorithm 3; Bubble Sort**
- Small List: 0.01749ms\
- Medium List: 0.62045ms\
- Big List: 59.63287ms

## Code samples
```lua
local sorter = require(script.Parent:WaitForChild("ModuleScript"))

SorterObj = sorter.new() -- get the sorter object
-- customise properties
SorterObj.Ascending = true
SorterObj.Algorithm = 1
SorterObj.Type = 1

local array = {3, 1, 19, 15}
local sortedArray = SorterObj:Sort(array)
print(sortedArray) -- {1, 3, 15, 19}

SorterObj.Ascending = false
sortedArray = SorterObj:Sort(array)
print(sortedArray) -- {19, 15, 3, 1}
```

`IncludeNonSorted`
```lua
local sorter = require(script.Parent:WaitForChild("ModuleScript"))

SorterObj = sorter.new() -- get the sorter object
-- customise properties
SorterObj.Ascending = true
SorterObj.Algorithm = 1
SorterObj.Type = 1
SorterObj.IncludeNonSorted = true

local array = {1, "test", 3, "B", 1, 3, 0} 
sortedArray = SorterObj:Sort(array)
print(sortedArray) -- {0, 1, 1, 3, 3, "test", "B"}
```

`:DeepSort()`
```lua
local sorter = require(script.Parent:WaitForChild("ModuleScript"))

SorterObj = sorter.new() -- get the sorter object
-- customise properties
SorterObj.Ascending = true
SorterObj.Algorithm = 1
SorterObj.Type = 1

local array = {1, 30, 41, 3, {3, 34, 1, 0, {5, 64, 10}}, {10, 31, 05, 10, 11}}
sortedDeepArray = SorterObj:DeepSort(array)
print(sortedDeepArray) -- {1, 3, 30, 41, {0, 1, 3, 34, {5, 10, 64}}, {5, 10, 10, 11, 31}}
-- all nested arrays would be pushed to the very end.
```

## Error Codes
For your troubleshooting needs.\
**`108`** - Invalid [SorterObj](https://github.com/FadedJayden/Table_Sort/blob/main/README.md#sorterobj)'s parameters.\
**`350`** - Not a fatal error, provided [type](https://github.com/FadedJayden/Table_Sort/blob/main/README.md#type) property of SorterObj does not match the given table.\
**`349`** - [SorterObj.Type](https://github.com/FadedJayden/Table_Sort/blob/main/README.md#type) is not a valid option.\
**`801`** - Amount of checks reached [MaxRetries](https://github.com/FadedJayden/Table_Sort/blob/main/README.md#maxretries). Contact me if this happens.