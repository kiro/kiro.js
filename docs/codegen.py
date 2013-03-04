import glob
from pygments import highlight
from pygments.lexers import get_lexer_by_name
from pygments.formatters import HtmlFormatter

lexer = get_lexer_by_name("coffeescript", stripall=True)
formatter = HtmlFormatter(linenos='inline', cssclass="highlight", cssfile="./code.css", lineseparator="<br>")

def write_example(title, lines, name):
    code = highlight(lines, lexer, formatter).replace("\n", "\\\n").replace('<pre', '<div').replace('</pre>', '</div>')
    print("context.find('h2').filter(function() { return $(this).text() === \"" + title + "\"}).last().siblings('pre').append('" + code + "')")

lines = ""
title = ""
isExample = False
inExample = False

print("docs = window.BC.namespace('docs')")
print("docs.code = {}")
name = ""
for filename in glob.glob("*/*/*.coffee"):
    name = filename.split('.')[0].split('/')[-1]

    print("docs.code." + name + " = function() {")
    print("  return { html: function() {}, init: function(context) { ")

    with open(filename, 'r') as f:
        lines = ""
        title = ""
        for line in f.readlines():
            if line.strip().startswith('example'):
                inExample = False
                if isExample: write_example(title, lines, name)
                lines = ""
                title = line.split("(")[1].strip().split("\"")[1]
                isExample = True

            if inExample:
                lines += line[4:][:-1] + "\n"

            if ("->" in line) and (('example' in line) or ('"""' in line)):
                inExample = True

    write_example(title, lines, name)

    print(" } } } ")
