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

local filter = signup:new({
    email = "cyx@cyx.is",
    fname = "Cyril",
    lname = "David"
})

assert(filter:valid())
```

## license

MIT
