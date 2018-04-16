import json
import re

from_cmdline = False
try:
    __file__
    from_cmdline = True
except NameError:
    pass

if not from_cmdline:
    import vim


def formatjson_from_buffer():
    win = vim.current.window
    try:
        block = vim.current.buffer
        block = ''.join([l + '\n' for l in block])
        block = json.loads(block)
        res = formatjson(block)
        win.buffer[:] = res.split('\n')
    except Exception as e:
        m = re.findall(r'line\s\d*\scolumn\s\d*', str(e))
        if m and len(m) > 0:
            location = m[0].split(' ')
            vim.command('cal cursor(%s,%s)' % (location[1], location[3]))
        print(e)
    vim.command('set ft=json')


def formatjson(block):
    return json.dumps(block, indent=4, ensure_ascii=False)
