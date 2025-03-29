#!/usr/bin/env python

from __future__ import print_function
import argparse
from itertools import product
import os
from os import path
import re
import shutil


GRAPHICS_EXT = ["", ".pdf", ".ps", ".svg", ".png", ".jpg"]


def read_tex_file(filepath):
    """Read tex file and remove comments."""
    def is_comment(line, i):
        """Just check whether % is escaped. \% is escaped but \\% is not.
        Ideally we would be searching for many backslashes cause \\\% is
        actually escaped but let's leave it for later."""
        return (
            (i > 1 and (line[i-1] != '\\' or line[i-2] == '\\')) or
            (i == 1 and line[i-1] != '\\')
        )

    lines = []
    with open(filepath) as f:
        for line in f:
            i = line.find("%")
            if i == 0:
                continue
            elif is_comment(line, i):
                lines.append(line[:i])
            else:
                lines.append(line)
    return "".join(lines)


def process_bibliography(texfile, texcontent, output):
    match = re.search(r'\\bibliography\{([a-zA-Z_\-0-9,]+)\}', texcontent)
    if match:
        bbl = texfile[:-4] + ".bbl"
        if not path.exists(bbl):
            raise RuntimeError("The latex file uses an external bibliography "
                               "file but we did not find a .bbl file. Did you "
                               "forget to compile before packaging for arxiv?")
        shutil.copy(bbl, output)


def substitute_graphicspath(main):
    path = ["."]
    def keep_path(match):
        path[0] = match.group(1)
        return ""
    main = re.sub(r'\\graphicspath\{+([a-zA-Z_\-0-9/\.]+)\}+', keep_path, main)

    return main, path[0]


def substitute_input(main):
    inputregex = r'\\input\{([a-zA-Z_\-0-9/]+)(\.tex)?\}'
    def read_input_file(match):
        return read_tex_file(match.group(1) + ".tex")
    main, nsubs = re.subn(inputregex, read_input_file, main)

    if nsubs > 0:
        return substitute_input(main)
    else:
        return main


def substitute_graphics(main):
    graphicsregex = r'\\includegraphics(\[[^\]]+\])?\{([{}a-zA-Z_\-0-9/.]+)\}'
    paths = map(
        lambda m: m.group(2),
        re.finditer(graphicsregex, main)
    )
    paths = {
        p: p.replace("/", "_")
        for p in paths
    }
    for old, new in paths.items():
        main = main.replace(old, new)

    return main, paths


def main(argv):
    parser = argparse.ArgumentParser(
        description="Create an uploadable folder for arxiv"
    )

    parser.add_argument(
        "main",
        help="The main tex file"
    )
    parser.add_argument(
        "--output",
        default="arxiv_upload",
        help="The folder to create (default: arxiv_upload)"
    )
    parser.add_argument(
        "--extra", "-e",
        default=[],
        action="append",
        help="Copy extra files to the destination folder"
    )

    args = parser.parse_args(argv)

    # if the folder exists empty it
    if path.exists(args.output):
        shutil.rmtree(args.output)
    os.mkdir(args.output)

    # Copy the extra files
    for f in args.extra:
        shutil.copy(f, args.output)

    # Read the tex file in memory
    main = read_tex_file(args.main)

    # Process the bibliography (useful comment)
    process_bibliography(args.main, main, args.output)

    # Process the file
    main, graphicspath = substitute_graphicspath(main)
    main = substitute_input(main)
    main, graphics = substitute_graphics(main)
    with open(path.join(args.output, args.main), "w") as f:
        print(main, file=f)

    # Copy the graphics
    for (graph_old, graph_new), ext in product(graphics.items(), GRAPHICS_EXT):
        source = path.join(graphicspath, graph_old + ext).replace("{", "").replace("}", "")
        dest = path.join(args.output, graph_new + ext).replace("{", "").replace("}", "")
        if path.exists(source):
            shutil.copy(source, dest)


if __name__ == "__main__":
    import sys
    main(sys.argv[1:])