let s:script_path = fnamemodify(resolve(expand('<sfile>:p')), ':h')
" 格式 Json 字符串
function! FormatJSON()
  if has('python3')
    command! -nargs=1 Python python3 <args>
    command! -nargs=1 Pyfile py3file <args>
  elseif has('python')
    command! -nargs=1 Python python <args>
    command! -nargs=1 Pyfile pyfile <args>
  else
    echo 'Error: this plugin requires vim compiled with python support.'
    finish
  endif

  execute 'Pyfile ' . s:script_path . '/vim-jq.py'

  Python formatjson_from_buffer()
endfunction
nnoremap <Leader>fj :call FormatJSON()<CR>

" 调用 jq 筛选 Json
function! JQFilter(name)
  echom "Example: .data.list|map({\"projectName\":.projectName,\"organizationCode\":.organizationCode})"
  " 筛选条件不为空则执行筛选
  if strlen(a:name)>0
    " 保存临时文件
    silent execute 'w! ~/.jqtmp.json'
    " 清除控制台输出
    silent execute '!clear'
    " 判断 JQ buffer 是否存在，存在则切换到 buffer，否则 new 一个
    if bufwinnr("~/.JQFilterResult") > 0
      silent execute bufwinnr("~/.JQFilterResult")'wincmd w'
    else
      silent execute 'vsplit ~/.JQFilterResult'
    endif
    " 清除筛选结果buffer
    silent execute '. normal ggVGd'
    " 复制筛选结果到剪贴板
    silent execute "!cat ~/.jqtmp.json|jq '" a:name "'|pbcopy"
    " 打印出筛选结果
    "execute '!cat ~/.jqtmp.json|jq ' a:name
    "silent execute 'tabnew'
    silent execute 'set ft=json'
    silent execute 'r !pbpaste'
      "echom "Output copy to clipboard"
  endif
endfunction
" 调用 jq 筛选 Json 内容
" !cat % | jq '.data[].areaname'
nnoremap <Leader>jq :call JQFilter(input("jq/"))<CR>

