# bgterm

A few simple functions and a Claude Code prompt to help coding agents use Bash interactively.

## Installation

```bash
cat functions.sh >> ~/.bashrc
cat README.md >> ~/.claude/CLAUDE.md
```

## Usage

* Run `mkterm TERMINAL` in background to create interactive terminals, where TERMINAL is a file name prefix. mkterm itself doesn't produce any output, fetch output by additionally running `tail -c +<last offset> TERMINAL.out; wc -c TERMINAL`

* In Bash, append commands to TERMINAL.in directly. Do not use termpaste or command won't run.

* In Python, paste the code using `echo 'code' | termpaste TERMINAL.in` to preserve indent, then `echo '' >> TERMINAL.in` to execute.

* Use `termwait TERMINAL <max idle seconds>` to wait for terminal to idle after long running operations.

## Commands

`mkterm TERMINAL`: creates a bash in the background as well as a pair of files TERMINAL.in and TERMINAL.out. Send keys by appending TERMINAL.in, see terminal state by TERMINAL.out. TERMINAL.in will be deleted when the terminal exits.

`termpaste TERMINAL`: Wraps stdin with control characters to signal to the terminal that text is being pasted and then send to the terminal. Some code editors and REPLs avoid autoindent when pasted text is detected.

`termview TERMINAL`: View terminal state in real time, read-only.

`termattach TERMINAL`: Attach to the terminal. Press `Ctrl+]` to escape. `echo "\x1d" >> TERMINAL.in` to send the escape key manually. Requires socat.

`termwait TERMINAL <max idle seconds>`: Wait until the terminal stops updating. Prefix with `timeout <max seconds>` to specify timeout.