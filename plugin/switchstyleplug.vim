nnoremap <silent> <Plug>YZMAP :call switchstyle#zwap_innerword(getline(line('.')), col('.')-1)<cr>
nmap yz <Plug>YZMAP
