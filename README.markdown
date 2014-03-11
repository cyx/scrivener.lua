# scrivener

Inspired from the ruby version from @soveran/scrivener

## usage

```lua
local scrivener = require("scrivener")

-- create a sample filter for the typical signup flow
local signup = scrivener(function (self)
    self:assert_email('email')
    self:assert_present('lname')
    self:assert_present('fname')
end)

-- scenario 1: valid
local valid, errors = signup({
    email = "cyx@cyx.is",
    fname = "Cyril",
    lname = "David"
})

assert(valid)

-- scenario 2: invalid
local valid, errors = signup({
    email = "cyx@cyx.is",
})

assert(not valid)
assert(errors[1][1] == 'lname')
assert(errors[1][2] == 'not_present')

assert(errors[2][1] == 'fname')
assert(errors[2][2] == 'not_present')
```

## license

MIT
