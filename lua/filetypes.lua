local utils = require('utils')

utils.create_augroup({
  {'FileType', '*', 'setlocal', 'shiftwidth=2'},
  {'FileType', 'c,cpp', 'setlocal', 'shiftwidth=8'},
  {'FileType', 'python', 'setlocal', 'shiftwidth=4'}
}, 'Tab2')


