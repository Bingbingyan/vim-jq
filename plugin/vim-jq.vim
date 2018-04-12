
  " 格式 Json 字符串
  function! FormatJSON(...)
    let code = "\"import json, sys;
          \ print(json.dumps(json.load(sys.stdin),
          \               indent = 2,
          \               ensure_ascii = False,
          \               sort_keys = False))\""
    execute "%! python3 -c " code
    silent execute 'set ft=json'
  endfunction
  nnoremap! <Leader>fj :call FormatJSON(v:count)<CR>

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
  nnoremap! <Leader>jq :call JQFilter(input("jq/"))<CR>

