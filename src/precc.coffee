condvar = require 'condvar'
fs = require 'fs'
path = require 'path'

target = process.stdout

print = (line, encoding = 'utf8') -> target.write line, encoding
say = (str) -> print "#{str}\n"

String::repeat = (n) ->
  str = ''
  str += @ for i in [1..n]
  str

readall = (stream) ->
  buf = ''
  cv = new condvar
  stream.on 'end', ->
    cv.send buf
  stream.on 'readable', ->
    chunk = stream.read()
    buf += chunk if chunk?
  cv.recv()

_include = (file, indent) ->
  file += '.coffee'
  n = 80 - indent.length - 2
  say "#{indent}##{'-'.repeat(n)}#"
  say "#{indent}# from <#{file}>"
  _process file, indent
  say "#{indent}##{'-'.repeat(n)}#"

_process = (file, indent) ->
  if !file
    base = process.cwd()
    content = readall process.stdin
  else
    base = path.dirname file
    content = fs.readFileSync file
  content = "#{content}"
  for line in content.split /\n/
    if line.match /^(\s*)#_include\s+(.+)\s*$/
      _include "#{base}/#{RegExp.$2}", "#{indent}#{RegExp.$1}"
    else
      say indent + line

[base, proc, files...] = process.argv
files = [null] if !files.length
_process file, '' for file in files
