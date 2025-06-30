require "user.set"
require "user.remaps"
-- require "user.templates"
if vim.g.code then
else
	require "user.lazy"
end
