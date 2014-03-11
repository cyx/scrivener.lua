local scrivener = require("scrivener")

-- create a sample filter for the typical signup flow
local signup = scrivener(function (self)
    self:assert_email('email')
    self:assert_present('lname')
    self:assert_present('fname')
end)

-- case 1: valid
local filter = signup:new({
    email = "cyx@cyx.is",
    fname = "Cyril",
    lname = "David"
})

assert(filter:valid())

-- case 2: all errors present
local filter = signup:new({})

assert(not filter:valid())
assert(#filter.errors == 3)
assert(filter.errors[1][1] == "email")
assert(filter.errors[1][2] == "not_email")
assert(filter.errors[2][1] == "lname")
assert(filter.errors[2][2] == "not_present")
assert(filter.errors[3][1] == "fname")
assert(filter.errors[3][2] == "not_present")

-- case 3: some errors present
local filter = signup:new({email = "cyx@cyx.is"})
assert(not filter:valid())
assert(#filter.errors == 2)
assert(filter.errors[1][1] == "lname")
assert(filter.errors[1][2] == "not_present")
assert(filter.errors[2][1] == "fname")
assert(filter.errors[2][2] == "not_present")

-- we've won ;-)
print("All tests passed.")
