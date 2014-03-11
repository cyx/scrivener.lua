-- @class Scrivener
local Scrivener = {}

function Scrivener.new(self, attributes)
    local object = {
        attributes = attributes,
        errors = {}
    }

    setmetatable(object, {__index = self})

    return object
end

function Scrivener.valid(self)
    self.validate(self)

    return #self.errors == 0, self.errors
end

function Scrivener.assert_email(self, att)
    local regex =
        "[A-Za-z0-9%.%%%+%-]+" .. 
        "@[A-Za-z0-9%.%%%+%-]+%.%w%w%w?%w?"

    local val = self.attributes[att]

    self:assert(
        val and string.match(val, regex),
        {att, "not_email"}
    )
end

function Scrivener.assert_present(self, att)
    local val = self.attributes[att]

    self:assert(val and val ~= '', {att, "not_present"})
end

function Scrivener.assert(self, val, tuple)
    if not val then
        table.insert(self.errors, tuple)
    end
end

-- @module interface
--
-- @example
--
--     local scrivener = require("scrivener")
--
--     local signup = scrivener(function (self)
--         self:assert_email('email')
--         self:assert_present('password')
--     end)
--
local function wrap(validator)
    local object = Scrivener:new()

    function object.validate(self)
        validator(self)
    end

    return object
end

return wrap
