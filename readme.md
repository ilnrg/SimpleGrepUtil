### Simple Grep Utility
Simple implementation of the basic Bash utility

## Build
- Go to the `src` folder
- Call the `make` command

### Usage
`./simple_grep [OPTION] template [FILE]...` \
Possible options:
- `-e pattern`
- `-i `- Ignore uppercase vs. lowercase
- `-v` - Invert match
- `-c` - Output count of matching lines onl
- `-l` - Output matching files only
- `-n` - Precede each matching line with a line number
- `-h` - Output matching lines without preceding them by file names
- `-s` - Suppress error messages about nonexistent or unreadable files
- `-f file` - Take regexes from a file
- `-o` - Output the matched parts of a matching line