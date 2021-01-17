local module = {}
module.__index = module

local function flipArray(array)
	local newArray = {}
	for _, n in pairs(array) do
		table.insert(newArray, 1, n)
	end
	
	return newArray
end
local function heapsort(array, ascend)
	for index, item in pairs(array) do
		local highest = {item, index}
		for indexB, itemB in pairs(array) do
			if indexB > index then
				if ascend then
					highest = itemB < highest[1] and {itemB, indexB} or highest
				else
					highest =  itemB > highest[1] and {itemB, indexB} or highest
				end
			end
		end
		if highest[2] ~= index then
			table.remove(array, highest[2])
			table.insert(array, highest[2], item)
			table.remove(array, index)
			table.insert(array, index, highest[1])
		end
	end
	
	return array
end

local function insertionsort(array, ascend)
	local solidified = {}
	for i, v in pairs(array) do
		local found = false
		if #solidified ~= 0 then
			for index, x in pairs(solidified) do
				if v <= x then
					found = true
					table.insert(solidified, index, v)
					break
				end
			end
		end
		if not found then
			table.insert(solidified, v)
		end
	end
	if not ascend then
		solidified = flipArray(solidified)
	end

	return solidified
end

local function sortChannel(array, ascending, sortChoice)
	local newArray = {}
	if sortChoice == 1 then
		newArray = heapsort(array, ascending)
	elseif sortChoice == 2 then
		newArray = insertionsort(array, ascending)
	else
		newArray = heapsort(array, ascending)
	end
	return newArray
end
local function check(array, ascend)
	local prevEntry = array[1]
	local err = false
	for _, val in pairs(array) do
		if ascend then
			if val >= prevEntry then
				prevEntry = val
			else
				err = true
				break
			end
		else
			if val <= prevEntry then
				prevEntry = val
			else
				err = true
				break
			end
		end
	end
	return err
end

local function checkSorterObj(obj)
	if type(obj.Type) ~= "number" or not(obj.Type == 1 or obj.Type == 2) then
		error("SorterObj.Type can only be 1 or 2. 108-1")
	elseif type(obj.Algorithm) ~= "number" or obj.Algorithm <= 0 or obj.Algorithm >= 3 then
		error("SorterObj.Algorithm value inproper. 108-2")
	elseif type(obj.Ascending) ~= "boolean" then
		error("SorterObj.Ascending can only be a boolean. 108-3")
	elseif type(obj.MaxRetries) ~= "number" or obj.MaxRetries > 50 then
		error("SorterObj.MaxRetries can only be a number and smaller than 50. 108-4")
	elseif type(obj.Checks) ~= "boolean" then
		error("SorterObj.Checks can only be a boolean. 108-5")
	elseif type(obj.SortKeys) ~= "boolean" then
		error("SorterObj.SortKeys can only be a boolean. 108-6")
	elseif type(obj.IncludeNonSorted) ~= "boolean" then
		error("SorterObj.IncludeNonSorted can only be a boolean. 108-7")
	end
end

function module.new()
	local Sorter = {}
	setmetatable(Sorter, module)
	
	Sorter.Algorithm = 1 -- 1, Heapsort; 2, -
	Sorter.MaxRetries = 5 -- max amount of tries if check is returning errors
	Sorter.Ascending = true -- order to be sorted
	Sorter.Checks = true -- checks returned results
	Sorter.Type = 1 -- 1, arrays, 2; dictionary
	Sorter.SortKeys = false -- only used when .Type=2, if true, sorts keys instead of values
	Sorter.IncludeNonSorted = false -- include non numerals
	
	return Sorter
end

local function determineTable(t)
	if next(t) == nil then
		return 0
	end

	local t_length = 0
	for _, _ in pairs(t) do
		t_length += 1
	end
	local array = true
	local dict = true
	for index, _ in pairs(t) do
		if type(index) == "string" then
			array = false
		elseif type(index) == "number" and index%1 == 0 and index <= t_length and index > 1 then
			dict = false
		elseif type(index) == "number" and index > t_length then
			array = false		
		end
	end

	if not(array) and not(dict) then
		return 3
	elseif array then
		return 1
	elseif dict then
		return 2
	end
end

local function deepCopy(a)
	local newTable = {}
	for k, v in pairs(a) do
		if type(v) == "table" then
			v = deepCopy(v)
			table.insert(newTable, v)
		else
			table.insert(newTable, v)
		end
	end
	return newTable
end

function module:Sort(t)
	checkSorterObj(self)
	
	local table_code = determineTable(t)
	if self.Type ~= table_code then
		warn("Passed table doesn't match Type properties. 350")
	end
	
	local newArray = {}
	local miscArray = {}
	if self.Type == 2 then
		if self.SortKeys then
			for k, _ in pairs(t) do
				if type(k) == "number" then
					table.insert(newArray, k)
				else
					if type(k) ~= "table" then
						table.insert(miscArray, k)
					else
						table.insert(miscArray, deepCopy(k))
					end
				end
			end
		else
			for _, v in pairs(t) do
				if type(v) == "number" then
					table.insert(newArray, v)
				else
					if type(v) ~= "table" then
						table.insert(miscArray, v)
					else
						table.insert(miscArray, deepCopy(v))
					end
				end
			end
		end
	elseif self.Type == 1 then
		for _, v in pairs(t) do
			if type(v) == "number" then
				table.insert(newArray, v)
			else
				if type(v) ~= "table" then
					table.insert(miscArray, v)
				else
					table.insert(miscArray, deepCopy(v))
				end
			end
		end
	else
		error("SorterObj.Type is neither 1 or 2. 349")
	end
	local sortedArray = {}
	if self.Checks then
		for i = 1, self.MaxRetries do
			sortedArray = sortChannel(newArray, self.Ascending, self.Type)
			local err = check(sortedArray, self.Ascending)
			if not err then
				break
			elseif i == self.MaxRetries then
				warn("Check failed and hit max retry limit. 801")
			end
		end
	else
		sortedArray = sortChannel(newArray, self.Ascending, self.Type)
	end
	
	if #miscArray ~= 0 and self.IncludeNonSorted then
		for _, v in pairs(miscArray) do
			table.insert(sortedArray, v)
		end
	end
	
	return sortedArray
end

function module:DeepSort(t)
	checkSorterObj(self)
	
	local function recursive(array)
		local currentArray = {}
		local sub_flags = {}
		for _, value in pairs(array) do
			if type(value) == "table" then
				local x = recursive(value)
				table.insert(sub_flags, x)
			elseif type(value) == "number" then
				table.insert(currentArray, value)
			end
		end
		currentArray = sortChannel(currentArray, self.Ascending, self.Type)
		for _, x in pairs(sub_flags) do
			table.insert(currentArray, x)
		end
		
		return currentArray
	end
	
	local sortedDeepArray = recursive(t)
	return sortedDeepArray
end

return module
