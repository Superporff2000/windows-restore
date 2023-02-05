" ###################
" ##    Vim Plug   ##
" ###################

" Src: C:/Users/super/AppData/Local/nvim/configs
source C:/Users/super/AppData/Local/nvim/configs/tokyo-night.vim

" ########################
" ##    Theme Configs   ##
" ########################

set termguicolors

let g:tokyonight_style = "night"
let g:tokyonight_italic_functions = 1
let g:tokyonight_sidebars = [ "qf", "vista_kind", "terminal", "packer" ]
colorscheme tokyonight

" #####################
" ##     General     ##
" #####################

" Expand 1 Tab into 4 Spaces
set tabstop=4 shiftwidth=4 expandtab

" Show line numbers
set number

" Enable mouse
set mouse+=a

" ####################################
" ##    Plugin specific configs     ##
" ####################################

" ----- Airline -----

    " Set Airline Theme
    let g:airline_theme = "tomorrow"

    " Enable powerline fonts
    let g:airline_powerline_fonts = 1

" ----- Barbar -----

    " Enable barbar bufferline configs
    let bufferline = get(g:, 'bufferline', {})

    " Enable tab animations
    let bufferline.animation = v:true

    " Enable total tabpages number
    let bufferline.tabpages = v:true
