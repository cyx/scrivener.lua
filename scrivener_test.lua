local scrivener = require("scrivener")

-- create a sample filter for the typical signup flow
local signup = scrivener(function (self)
	self:assert_email('email')
	self:assert_present('lname')
	self:assert_present('fname')
end)

-- case 1: valid
local valid, errors = signup({
	email = "cyx@cyx.is",
	fname = "Cyril",
	lname = "David"
})

assert(valid)

-- case 2: all errors present
local valid, errors = signup({})

assert(not valid)
assert(#errors == 3)
assert(errors[1][1] == "email")
assert(errors[1][2] == "not_email")
assert(errors[2][1] == "lname")
assert(errors[2][2] == "not_present")
assert(errors[3][1] == "fname")
assert(errors[3][2] == "not_present")

-- case 3: some errors present
local valid, errors = signup({email = "cyx@cyx.is"})
assert(not valid)
assert(#errors == 2)
assert(errors[1][1] == "lname")
assert(errors[1][2] == "not_present")
assert(errors[2][1] == "fname")
assert(errors[2][2] == "not_present")

-- we've won ;-)
print("All tests passed.")
