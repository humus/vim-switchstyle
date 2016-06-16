
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
  if !switchstyle#validate_bounds(a:str, a:index)
    return -1
  endif
  let after_str = switchstyle#after_position(a:str, a:index)
  let str_after = matchstr(after_str, '\c\v.*([^a-z0-9_$])@=\ze.*$')
  return a:index + len(str_after) + 1
endfunction "}}}

fun! switchstyle#validate_bounds(str, index) "{{{
  return a:str[a:index] !~ '\v[[:space:]]' &&
        \ a:index < len(a:str)
endfunction "}}}

fun! switchstyle#get_boundary_list(str, index) "{{{
  let lower_bound = switchstyle#start_iw_index(a:str, a:index)
  let upper_bound = switchstyle#end_iw_index(a:str, a:index)

  if lower_bound == -1 || upper_bound == -1
    echohl WARNINGMSG | echo 'Not a word' | echohl NORMAL
    return []
  endif

  return [a:str[0:lower_bound-1], a:str[lower_bound : upper_bound-1], a:str[upper_bound : ]]
endfunction "}}}

fun! switchstyle#dettect_style(str) "{{{
  if a:str =~ '\C\v^[^A-Z_]+[A-Z].*'
    return 'X'
  endif
  if a:str =~ '\c\v^[a-z0-9]+_'
    return '_'
  endif
endfunction "}}}

fun! switchstyle#switch(str) "{{{
  let result = switchstyle#apply_replacement(a:str, switchstyle#dettect_style(a:str))
  return result
endfunction "}}}

fun! switchstyle#apply_replacement(str, key) "{{{
  let Sfunction=s:dict_switches[a:key]
  return Sfunction(a:str)
endfunction "}}}

fun! switchstyle#cammel_to_snake(cammel_str) "{{{
  return substitute(substitute(a:cammel_str, '\v\C([[:lower:]])@<=\zs\ze[[:upper:]]', '_', 'g'), '\v.+', '\L&', '')
endfunction "}}}

fun! switchstyle#snake_to_cammel(snake_str) "{{{
  return substitute(a:snake_str, '\v\C[[:alpha:]$]\zs_([[:alpha:]])', '\u\1', 'g')
endfunction "}}}

let s:dict_switches = {'X': function('switchstyle#cammel_to_snake'), '_': function('switchstyle#snake_to_cammel')}

" vim: sw=2 ts=2 et
