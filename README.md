# vim-jq
1. 格式化 JSON 文件
```
<leader>fj
```
2. 调用 jq 命令处理当前 JSON 文件
```
<leader>jq
```

[怎样使用 jq 命令](https://stedolan.github.io/jq/tutorial/)

## 截图
![screenshot](screenshot/QQ20180412-233330-HD.gif)

## 安装方法
1. Git clone
```shell
> cd ~/.vim/plugged
> git clone https://github.com/Bingbingyan/vim-jq.git
```
2. Plug
在.vimrc 文件添加
```vim
  Plug 'Bingbingyan/vim-jq'
```
然后在 vim 中执行
```
:PlugInstall
```

