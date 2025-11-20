local json = require("libs/json")
local logger = require("libs/logger")

local isOverlayVisible = false

registerForEvent('onOverlayOpen', function()
    isOverlayVisible = true
end)

registerForEvent('onOverlayClose', function()
    isOverlayVisible = false
end)

registerForEvent('onDraw', function()
    if not isOverlayVisible then return end
    if not ImGui.Begin("Test CET Libs") then return end

    if ImGui.Button("Test Parse Json") then
        local jsonString = [[
        {
            "name": "John Doe",
            "age": 30,
            "isEmployed": true,
            "skills": ["Lua", "CET", "ImGui"],
            "address": {
                "street": "123 Main St",
                "city": "Anytown"
            }
        }
        ]]
        local parsedData = json.parse(jsonString)
        logger.info("Name: " .. parsedData.name)
        logger.info("Age: " .. parsedData.age)
        logger.info("Employed: " .. tostring(parsedData.isEmployed))
        logger.info("First Skill: " .. parsedData.skills[1])
        logger.info("City: " .. parsedData.address.city)
    end

    if ImGui.Button("Test Serialize Json") then
        local data = {
            name = "Jane Smith",
            age = 25,
            isEmployed = false,
            skills = {"Python", "CET", "Lua"},
            address = {
                street = "456 Elm St",
                city = "Othertown"
            }
        }
        local jsonString = json.stringify(data)
        logger.info("Serialized JSON: " .. jsonString)

        local jsonPretty = json.stringify(data, true)
        logger.info("Pretty Printed JSON:\n" .. jsonPretty)
    end

    if ImGui.Button("Test Invalid Json") then
        local invalid_json = {
            -- Missing closing brace
            "{\"name\": \"Alice\", \"age\": 30",

            -- Missing opening brace
            "\"name\": \"Alice\", \"age\": 30}",

            -- Unquoted key
            "{name: \"Bob\"}",

            -- Single quotes instead of double quotes
            "{'x': 10}",

            -- Undefined literal
            "{\"value\": undefined}",

            -- NaN literal
            "{\"number\": NaN}",

            -- Function literal
            "{\"callback\": function() {}}",

            -- Unterminated string
            "{\"msg\": \"hello}",

            -- Array missing commas
            "[1 2 3]",

            -- Colon instead of comma
            "{\"a\": 1: \"b\": 2}",

            -- Comma instead of colon
            "{\"a\", 1}"
        }
        
        for i, js in ipairs(invalid_json) do
            logger.info("Testing invalid JSON #" .. i)
            local result = json.parse(js)
            if result == nil then
                logger.info("Parsing failed as expected.")
            else
                logger.info("Unexpectedly parsed JSON: " .. json.stringify(result))
            end
        end
    end

    if ImGui.Button("Test Logger") then
        logger.info("string")
        logger.info(true)
        logger.info(1)
        logger.info({1, 2, 3})
        logger.info(Vector4.new(10, 1, 0, 1))
        logger.info(EulerAngles.new(14, 151, 167))
        logger.info(CName.new("test"))

        logger.info(nil)
        logger.info({key1 = "value1", key2 = 42, nested = {a = 1, b = 2}}, true)

        logger.warn("This is a warning message.")
        logger.error("This is an error message.")
    end

    ImGui.End()
end)