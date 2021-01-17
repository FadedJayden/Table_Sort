# Table_Sort
For all your sorting needs of both arrays and dictionaries.

## What is this?
A Roblox module that has the functionality to sort both arrays and dictionaries.
When sorting dictionaries, it would just return the ordered array for the values in the dictionary since dictionaries are unordered, unlike arrays.
It currently features 2 sorting algorithms, **insertion sort** and **heap sort**.

## API
##### Module.new()
Creates and return a [SorterObj](https://github.com/FadedJayden/Table_Sort/blob/main/README.md#sorterobj).
## SorterObj
A class object that handles [parameters](https://github.com/FadedJayden/Table_Sort#parameters) when sorting.
#### `:Sort(x)`
Sorts array `x`, will exclude non numeric datatypes, use [Deep Sort](https://github.com/FadedJayden/Table_Sort/blob/main/README.md#deepsortx) to include arrays.
Only takes in 1 parameter.

#### `:DeepSort(x)`
Sorts array `x` along with nested arrays.
Uses a recursive function to sort all of the numerical data within all of nested arrays.
Won't sort non numeric datatypes.
Only takes in 1 parameter.

### Parameters
##### Algorithm
Datatype: `number`\
Default: `1`\
Determines the sorting algorithm used.
1 - Heap Sort
2 - Insertion Sort

##### MaxRetries
Datatype: `number`\
Default: `5`\
Determines the amount of times to retries when checking of ordered array fails.

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

## Stats
**Algorithm 1; Heap Sort**
- Avg time: 0.03131ms
**Algorithm 2; Insertion Sort**
- Avg time: 0.03652ms

## Error Codes
For your troubleshooting needs.
