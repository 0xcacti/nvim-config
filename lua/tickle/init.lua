require("tickle.remap")
require("tickle.set")

P = function(v)
    print(vim.inspect(v))
    return v
end

RELOAD = function(...)
    return require("plenary.reload").reload_module(...)
end

R = function(name)
    RELOAD(name)
    return require(name)
end

function CheckSum()
    -- Get the visual selection
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local lines = vim.fn.getline(start_pos[2], end_pos[2])
    local address = table.concat(lines, "\n")
    address = address:gsub("^%s*(.-)%s*$", "%1") -- Trim whitespace

    -- Debug output
    print("Selected address: '" .. address .. "'")

    -- Ensure the address is valid (more lenient check)
    if not address:match("^0x[a-fA-F0-9]+$") then
        print("Invalid Ethereum address: doesn't match pattern")
        return
    end

    -- Check length
    if #address ~= 42 then
        print("Invalid Ethereum address: incorrect length (" .. #address .. " characters)")
        return
    end

    -- Remove '0x' prefix for processing
    local addr = address:sub(3)

    -- Compute Keccak-256 hash of the address
    local hash = vim.fn.system('echo -n "' .. addr:lower() .. '" | openssl dgst -sha3-256 -binary | xxd -p -c 32')
    hash = hash:gsub("%s+", "") -- Remove any whitespace

    -- Debug output
    print("Computed hash: " .. hash)

    -- Apply checksum rules
    local checksummed = "0x"
    for i = 1, 40 do
        local c = addr:sub(i, i)
        local h = tonumber(hash:sub(i, i), 16)
        if h > 7 then
            checksummed = checksummed .. c:upper()
        else
            checksummed = checksummed .. c:lower()
        end
    end

    -- Debug output
    print("Checksummed address: " .. checksummed)

    -- Replace the selection with the checksummed address
    vim.api.nvim_buf_set_text(0, start_pos[2] - 1, start_pos[3], end_pos[2] - 1, end_pos[3], { checksummed })
end

vim.api.nvim_create_user_command('CheckSum', CheckSum, {})
