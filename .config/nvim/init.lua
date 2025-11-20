require("user.set")
require("user.remaps")
-- require "user.templates"
if vim.g.code then
else
    require("user.custom.floating")
    require("user.lazy")
end
