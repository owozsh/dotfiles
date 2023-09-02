vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- essentials
	use 'wbthomason/packer.nvim'
	use {
		'nvim-treesitter/nvim-treesitter',
		{ run = ':TSUpdate' }
	}
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.2',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	-- themes
	use "ellisonleao/gruvbox.nvim"
	use 'Mofiqul/dracula.nvim'
end)
