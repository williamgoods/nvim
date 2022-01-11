-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function()
    use {
	    'neoclide/coc.nvim', branch = 'release'
    }

    use {
        'dense-analysis/ale', branch = 'master'
    }

    use {"akinsho/toggleterm.nvim"}

    use {
        'neovim/nvim-lspconfig',
        'williamboman/nvim-lsp-installer'
    }

    use {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/nvim-cmp'
    }

    use {
        'windwp/nvim-autopairs'
    }

    use { 'junegunn/fzf', run = './install --bin', }

    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    use {
        'romgrk/barbar.nvim',
        requires = {'kyazdani42/nvim-web-devicons'}
    }

    use {
        'AckslD/nvim-whichkey-setup.lua',
        requires = {'liuchengxu/vim-which-key'},
    }

    use {
        'rmagatti/auto-session',
        config = function()
            require('auto-session').setup {
                log_level = 'info',
                auto_session_suppress_dirs = {'~/', '~/Projects'}
            }
        end
    }

    use "projekt0n/github-nvim-theme"

    use 'Asheq/close-buffers.vim'

    use 'preservim/nerdcommenter'

    use 'haishanh/night-owl.vim'

    use 'SirVer/ultisnips'

    use 'honza/vim-snippets'

    if packer_bootstrap then
        require('packer').sync()
    end
end)

