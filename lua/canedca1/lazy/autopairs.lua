return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local npairs = require("nvim-autopairs")
    local rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")

    npairs.setup({})

    npairs.add_rule(rule('<', '>', {
      -- if you use nvim-ts-autotag, you may want to exclude these filetypes from this rule
      -- so that it doesn't conflict with nvim-ts-autotag
      '-html',
      '-javascriptreact',
      '-typescriptreact',
    }):with_pair(
        -- regex will make it so that it will auto-pair on
        -- `a<` but not `a <`
        -- The `:?:?` part makes it also
        -- work on Rust generics like `some_func::<T>()`
        cond.before_regex('%a+:?:?$', 3)
      ):with_move(function(opts)
        return opts.char == '>'
      end)
    )

    npairs.add_rule(rule("<", ">", { }):with_pair(cond.before_regex("template $", 9)))
  end
}
