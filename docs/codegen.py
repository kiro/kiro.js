import glob

def write_example(title, lines):
    print("$(\":contains('" + title + "')\").last().siblings('pre').append(\"" + lines + "\")")

lines = ""
title = ""
isExample = False
for filename in glob.glob("*/*.coffee"):
    with open(filename, 'r') as f:
        lines = ""
        title = ""
        for line in f.readlines():
            if line.strip().startswith('example'):
                if isExample: write_example(title, lines)
                lines = ""
                title = line.split("(")[1].strip().split("\"")[1]
                isExample = True
            else:
                lines += line[4:][:-1].replace("\"", "\\\"") + "\\n\\\n"

write_example(title, lines)