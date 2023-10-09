#!/bin/bash

# Install plugins
nvim +'PlugInstall --sync' +qall
nvim +'CocInstall -sync coc-json coc-tsserver coc-styled-components coc-sh coc-css coc-eslint coc-tailwindcss' +qall
