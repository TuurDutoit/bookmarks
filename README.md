bookmarks
=========

A simple bookmarks manager for Bash.

## Installation
0. If you're on Mac, install `greadlink` from [Homebrew](http://brew.sh), i.e. `brew install greadlink`.
1. Clone this repo or copy the `bookmarks.sh` file to wherever you like (e.g. `~/.bookmarks.sh`), just don't put it in `~/.bookmarks`; that's where the bookmarks will be stored. You can also copy the contents to your `~/.bash_profile` or `~/.bashrc`; in this case, skip the next step.
2. Reference the file from `~/.bash_profile` by adding the following line: `source /path/to/bookmarks.sh` (replacing `/path/to/bookmarks.sh` by the actual path, of course).
3. Create the empty file `~/.bookmarks`.
3. The `bm` command will now be available from any new terminal you open. If you want to use it in a terminal that was already open before installing bm, use the `source` command as follows: `source ~/.bash_profile` or `source /path/to/bookmarks.sh` to just load bm, instead of the whole `.bash_profile`.

## Usage
bm add <name> <path>           Create a bookmark for path.
bm add <name>                  Create a bookmark for the current directory.
bm edit <name> <new path>      Edit a bookmark to point to a new path.
bm edit <name>                 Edit a bookmark to point to the current directory.
bm update                      Source the bookmark file.
bm remove <name>               Remove a bookmark.
bm list                        List all bookmarks.
bm ls                          Alias for list.

> Run `bm` without any arguments (or invalid ones) to print this help text

## How does it work?
Consider the following commands:

```shell
$ bm add mydir /users/me/mydir
$ bm add myfile /users/me/documents/myfile.doc
```

bm stored these directories in regular Bash variables, so you can use `cd $mydir`, for example, or: `cat $myfile`.  
All your bookmarks are stored in a file (`~/.bookmarks`), which bm reads out (or better: feeds to Bash) every time a new Bash terminal is opened, or `bm update` is run.

## License
The MIT License (MIT)
Copyright (c) 2016 Tuur Dutoit

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
