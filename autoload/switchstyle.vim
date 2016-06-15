
fun! switchstyle#load() "{{{
endfunction "}}}

fun! switchstyle#before_position(str, position) "{{{
  let ret = a:str[0:a:position-1]
  return ret
endfunction "}}}



" vim: sw=2 ts=2 et
