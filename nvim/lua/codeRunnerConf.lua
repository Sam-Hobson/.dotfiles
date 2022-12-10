require('code_runner').setup {
  -- choose default mode (valid term, tab, float, toggle, buf)
  mode = 'term',
  -- Focus on runner window(only works on toggle, term and tab mode)
  focus = false,
  -- startinsert (see ':h inserting-ex')
  startinsert = false,
  term = {
    --  Position to open the terminal, this option is ignored if mode is tab
    -- position = "vertical rightb",
    position = "bot",
    -- window size, this option is ignored if tab is true
    -- size = 65,
    size = 15,
  },
  float = {
    -- Window border (see ':h nvim_open_win')
    border = "none",

    -- Num from `0 - 1` for measurements
    height = 0.8,
    width = 0.8,
    x = 0.5,
    y = 0.5,

    -- Highlight group for floating window/border (see ':h winhl')
    border_hl = "FloatBorder",
    float_hl = "Normal",

    -- Transparency (see ':h winblend')
    blend = 0,
  },
  filetype_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/code_runner.nvim/lua/code_runner/code_runner.json",
	filetype = {
		-- java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
		python = "time python3 -u",
		typescript = "cd $dir && tsc --strict $fileName && node ./$fileNameWithoutExt.js && rm $fileNameWithoutExt.js",
		javascript = "cd $dir && node $fileName",
    c = "cd $dir && gcc -o $fileNameWithoutExt $fileName && ./$fileNameWithoutExt && rm $fileNameWithoutExt",
    cpp = "cd $dir && g++ -o $fileNameWithoutExt $fileName && ./$fileNameWithoutExt && rm $fileNameWithoutExt",
    java = "cd $dir && javac $fileName && java $fileName",
    haskell = "cd $dir && ghc -o $fileNameWithoutExt $fileName && ./$fileNameWithoutExt && rm $fileNameWithoutExt"
	},
  project_path = vim.fn.stdpath("data")
      .. "/site/pack/packer/start/code_runner.nvim/lua/code_runner/project_manager.json",
	project = {
    ["~/OneDrive/Salads/haskell/salad"] = {
      name = "HaskellSalad",
      description = "Salad for Haskell",
      command = "cabal build; clear; cabal run all"
    },
    ["~/OneDrive/Projects/broccoli"] = {
      name = "Broccoli",
      description = "Broccoli",
      command = "cabal run :all \"fizzBuzz.broc\""
    },
    ["~/OneDrive/University_Tasks/Y3S2/assignments/3155/assignment1/q1"] = {
      name = "FIT3155 ass 1",
      description = "FIT3155 ass 1",
			file_name = "special_boyermoore.py",
			command = "python -u $fileName txt.txt pat.txt"
    },
    ["~/OneDrive/University_Tasks/Y3S2/assignments/3155/assignment1/q2"] = {
      name = "FIT3155 ass 1",
      description = "FIT3155 ass 1",
			file_name = "hd1pm2D.py",
			command = "python -u $fileName txt.txt pat.txt"
    },
    ["~/OneDrive/University_Tasks/Y3S2/assignments/3155/assignment2/q2"] = {
      name = "FIT3155 ass 2 q2",
      description = "FIT3155 ass 2 q2",
			file_name = "a2hd1pm2D.py",
			command = "time python -u $fileName txt pat"
    }, ["~/OneDrive/University_Tasks/Y3S2/assignments/3155/assignment3/q1"] = {
      name = "FIT3155 ass 3 q1",
      description = "FIT3155 ass 3 q1",
			file_name = "btree.py",
			command = "time python -u $fileName 3 dict.txt cmds.txt"
    }, ["~/OneDrive/University_Tasks/Y3S2/assignments/3155/assignment3/q2"] = {
      name = "FIT3155 ass 3 q2",
      description = "FIT3155 ass 3 q2",
			file_name = "treecode.py",
			command = "time python -u $fileName 15"
    }



		-- ["~/deno/example"] = {
		-- 	name = "ExapleDeno",
		-- 	description = "Project with deno using other command",
		-- 	file_name = "http/main.ts",
		-- 	command = "deno run --allow-net"
		-- },
		-- ["~/cpp/example"] = {
		-- 	name = "ExapleCpp",
		-- 	description = "Project with make file",
		-- 	command = "make buid & cd buid/ & ./compiled_file"
		-- }
	},
}
