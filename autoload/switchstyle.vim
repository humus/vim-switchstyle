
fun! switchstyle#load() "{{{
endfunction "}}}

fun! switchstyle#before_position(str, position) "{{{
  return a:str[0:a:position-1]
endfunction "}}}

fun! switchstyle#after_position(str, position) "{{{
  return a:str[a:position+1 :]
endfunction "}}}



" vim: sw=2 ts=2 et
