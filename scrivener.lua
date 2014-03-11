-- regex for matching emails in assert_email
local EMAIL =
	"[A-Za-z0-9%.%%%+%-]+" ..
	"@[A-Za-z0-9%.%%%+%-]+%.%w%w%w?%w?"

local new = function(self, attributes)
    local object = {
        attributes = attributes,
        errors = {}
    }

    setmetatable(object, {__index = self})

    return object
end

local valid = function(self)
    self.validate(self)

    return #self.errors == 0, self.errors
end

local assert_email = function(self, att)
    local val = self.attributes[att]

    self:assert(
        val and string.match(val, EMAIL),
        {att, "not_email"}
    )
end

local assert_present = function(self, att)
    local val = self.attributes[att]

    self:assert(val and val ~= '', {att, "not_present"})
end

local assert = function(self, val, tuple)
    if not val then
        table.insert(self.errors, tuple)
    end
end

local methods = {
	new = new,
	valid = valid,
	assert_present = assert_present,
	assert_email = assert_email,
	assert = assert,
}

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
	-- initialize object with `methods` as the concept of `self`.
    local object = new(methods)

    function object.validate(self)
        validator(self)
    end

    return object
end

return wrap
