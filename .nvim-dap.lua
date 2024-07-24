local dap = require("dap")
local rr_dap = require("nvim-dap-rr")

local build_cpp_program = function()
    local out = vim.fn.system({"cmake", "--build", "."})
    if vim.v.shell_error ~= 0 then
        vim.notify("Build failed:\n" .. out, vim.log.levels.ERROR)
        return nil
    end
    return vim.fn.getcwd() .. "/bin/TestGame"
end
dap.configurations.cpp = {
    {
        name = "TestGame",
        type = "lldb",
        request = "launch",
        program = build_cpp_program,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        runInTerminal = true,
    },
}
table.insert(dap.configurations.cpp, rr_dap.get_config(
    {
        name = "TestGame_rr",
        program = build_cpp_program,
        stopOnEntry = false,
        runInTerminal = true,
    }
))
