
fun! switchstyle#load() "{{{
endfunction "}}}

fun! switchstyle#before_position(str, position) "{{{
  return a:str[0:a:position-1]
endfunction "}}}

fun! switchstyle#after_position(str, position) "{{{
  return a:str[a:position+1 :]
endfunction "}}}

fun! switchstyle#start_iw_index(str, index) "{{{
  let prev_str = switchstyle#before_position(a:str, a:index)
  let str_from_iw=matchstr(prev_str, '\c\v^.*[a-z0-9_$]@<!\zs[a-z0-9_$]+$')
  return len(prev_str) - len(str_from_iw)
endfunction "}}}

fun! switchstyle#end_iw_index(str, index) "{{{
  let after_str = switchstyle#after_position(a:str, a:index)
  let str_after = matchstr(after_str, '\c\v.*([^a-z0-9_$])@=\ze.*$')
  return a:index + len(str_after) + 1
endfunction "}}}

" vim: sw=2 ts=2 et
