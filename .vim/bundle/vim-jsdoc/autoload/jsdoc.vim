" File: jsdoc.vim
" Author: NAKAMURA, Hisashi <https://github.com/sunvisor>
" Modifyed: Shinya Ohyanagi <sohyanagi@gmail.com>
" Version:  0.2.1
" WebPage:  http://github.com/heavenshell/vim-jsdoc/
" Description: Generate JSDoc to your JavaScript file.
" License: BSD, see LICENSE for more details.

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:jsdoc_input_description')
  let g:jsdoc_input_description = 0
endif
" Prompt user for function description
if !exists('g:jsdoc_additional_descriptions')
  let g:jsdoc_additional_descriptions = 0
endif
" Prompt user for return type
if !exists('g:jsdoc_return')
  let g:jsdoc_return = 1
endif
" Prompt user for return description
if !exists('g:jsdoc_return_description')
  let g:jsdoc_return_description = 1
endif
" Allow prompt to input
if !exists('g:jsdoc_allow_input_prompt')
  let g:jsdoc_allow_input_prompt = 0
endif
" Access tag (default 0)
" http://usejsdoc.org/tags-access.html
if !exists('g:jsdoc_access_descriptions')
  let g:jsdoc_access_descriptions = 0
endif
" Use underscore starting functions as private convention (default 0)
" http://usejsdoc.org/tags-access.html
" used only if g:jsdoc_access_descriptions > 0
if !exists('g:jsdoc_underscore_private')
  let g:jsdoc_underscore_private = 0
endif
" Enable to use ECMAScript6 shorthand method syntax.
" /**
"  * foo
"  *
"  * @param foo
"  */
" foo(data) {
" }
if !exists('g:jsdoc_allow_shorthand')
  let g:jsdoc_allow_shorthand = 0
endif
" Use separator between @param name and description.
if !exists('g:jsdoc_param_description_separator')
    let g:jsdoc_param_description_separator = " "
endif

" Insert defined type and description if arg is matched to defined regex.
if !exists('g:jsdoc_custom_args_hook')
  let g:jsdoc_custom_args_hook = {}
endif

" Return data types for argument type auto completion :)
function! jsdoc#listDataTypes(A,L,P)
  let l:types = ['boolean', 'null', 'undefined', 'number', 'string', 'symbol', 'object']
  return join(l:types, "\n")
endfunction

function! s:hookArgs(lines, space, arg, hook, argType, argDescription)
  " Hook function signature's args for insert as default value.
  if g:jsdoc_custom_args_hook == {}
    call add(a:lines, a:space . ' * @param ' . a:arg)
  else
    let l:matchedArg = matchstr(a:hook, a:arg)
    if l:matchedArg == ''
      let l:type = '{' . a:argType . '} '
      let l:description = ''
      if a:argDescription != ''
        let l:description = g:jsdoc_param_description_separator . a:argDescription
      endif
      call add(a:lines, a:space . ' * @param ' . l:type . a:arg . l:description)
    else
      let l:type = ''
      let l:customArg = g:jsdoc_custom_args_hook[l:matchedArg]
      if a:argType == ''
        if has_key(l:customArg, 'type')
          let l:type = l:customArg['type'] . ' '
        endif
      else
        let l:type = '{' . a:argType . '} '
      endif
      let l:description = ''
      if a:argDescription == ''
        if has_key(l:customArg, 'description')
          let l:description = g:jsdoc_param_description_separator . l:customArg['description']
        endif
      else
        let l:description = g:jsdoc_param_description_separator . a:argDescription
      endif
      call add(a:lines, a:space . ' * @param ' . l:type . a:arg . l:description)
    endif
  endif
  return a:lines
endfunction

function! jsdoc#insert()
  let l:jsDocregex = '^.\{-}\s*\([a-zA-Z_$][a-zA-Z0-9_$]*\)\s*[:=]\s*function\s*\**(\s*\([^)]*\)\s*).*$'
  let l:jsDocregex2 = '^.\{-}\s*function\s\+\([a-zA-Z_$][a-zA-Z0-9_$]*\)\s*\**(\s*\([^)]*\)\s*).*$'
  " ECMAScript6 shorthand syntax.
  let l:jsDocregex3 = '^.\{-}\s*\([a-zA-Z_$][a-zA-Z0-9_$]*\)\s*(\s*\([^)]*\)\s*).*$'

  let l:line = getline('.')
  let l:indentCharSpace = ' '
  let l:indentCharTab = '	'
  let l:autoexpandtab = &l:expandtab

  if l:autoexpandtab == 0 " noexpandtab
    " tabs
    let l:indent = indent('.') / &l:tabstop
    let l:indentChar = l:indentCharTab
  elseif l:autoexpandtab == 1 " expandtab
    " spaces
    let l:indent = indent('.')
    let l:indentChar = l:indentCharSpace
  endif

  let l:space = repeat(l:indentChar, l:indent)

  if l:line =~ l:jsDocregex
    let l:flag = 1
    let l:regex = l:jsDocregex
  elseif l:line =~ l:jsDocregex2
    let l:flag = 1
    let l:regex = l:jsDocregex2
  elseif g:jsdoc_allow_shorthand == 1 && l:line =~ l:jsDocregex3
    let l:flag = 1
    let l:regex = l:jsDocregex3
  else
    let l:flag = 0
  endif

  let l:lines = []
  let l:desc = ''
  if g:jsdoc_input_description == 1
    let l:desc = input('Description: ')
  endif
  call add(l:lines, l:space. '/**')
  call add(l:lines, l:space . ' * ' . l:desc)
  call add(l:lines, l:space . ' *')
  let l:funcName = ''
  if l:flag
    let l:funcName = substitute(l:line, l:regex, '\1', "g")
    let l:arg = substitute(l:line, l:regex, '\2', "g")
    let l:args = split(l:arg, '\s*,\s*')

    if g:jsdoc_additional_descriptions == 1
      call add(l:lines, l:space . ' * @name ' . l:funcName)
      call add(l:lines, l:space . ' * @function')
    endif

    if g:jsdoc_access_descriptions > 0
      let l:access = 'public'

      if g:jsdoc_underscore_private == 1
        let l:funcNameFirstChar = l:funcName[0]

        if l:funcNameFirstChar == '_'
          let l:access = 'private'
        endif
      endif

     if g:jsdoc_access_descriptions == 1
       " use: http://usejsdoc.org/tags-access.html
       let l:access_tag = ' * @access '
     else
       " use other form, e.g.: http://usejsdoc.org/tags-public.html
       let l:access_tag = ' * @'
     endif

      call add(l:lines, l:space . l:access_tag . l:access)

    endif

    let hook = keys(g:jsdoc_custom_args_hook)
    for l:arg in l:args
      if g:jsdoc_allow_input_prompt == 1
        let l:argType = input('Argument "' . l:arg . '" type: ', '', 'custom,jsdoc#listDataTypes')
        let l:argDescription = input('Argument "' . l:arg . '" description: ')

        if g:jsdoc_custom_args_hook == {}
          " Prepend separator to start of description only if it was provided
          if l:argDescription != ''
            let l:argDescription = g:jsdoc_param_description_separator . l:argDescription
          endif
          call add(l:lines, l:space . ' * @param {' . l:argType . '} ' . l:arg . l:argDescription)
        else
          let l:lines = s:hookArgs(l:lines, l:space, l:arg, l:hook, l:argType, l:argDescription)
        endif
      else
        " Hook args.
        let l:lines = s:hookArgs(l:lines, l:space, l:arg, l:hook, '', '')
      endif
    endfor
  endif
  if g:jsdoc_return == 1
    if g:jsdoc_allow_input_prompt == 1
      let l:returnType = input('Return type (blank for no @return): ', '', 'custom,jsdoc#listDataTypes')
      let l:returnDescription = ''
      if l:returnType != ''
        if g:jsdoc_return_description == 1
          let l:returnDescription = input('Return description: ')
        endif
        if l:returnDescription != ''
          let l:returnDescription = ' ' . l:returnDescription
        endif
        call add(l:lines, l:space . ' * @return {' . l:returnType . '}' . l:returnDescription)
      endif
    else
      call add(l:lines, l:space . ' * @return {undefined}')
    endif
  endif
  call add(l:lines, l:space . ' */')

  let l:paste = &g:paste
  let &g:paste = 1

  call append(line('.') - 1, l:lines)

  let l:pos = line('.') - (len(l:lines) - 1)

  silent! execute 'normal! ' . l:pos . 'G$'
  if l:desc == '' && l:funcName != ''
    silent! execute 'normal! a' . l:funcName
  endif

  let &g:paste = paste
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
