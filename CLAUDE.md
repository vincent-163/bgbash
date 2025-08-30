# Interactive Bash Terminal

* Run `mkterm <terminal name>` in background to create interactive terminals. mkterm itself doesn't produce any output, fetch output by `tail -c +<last offset> <terminal name>.out; wc -c <terminal name.out>`
In Bash, append commands to <terminal name>.in directly. Do not use paste or command won't run.
In Python, paste the code using echo 'code' | termpaste <terminal name>.in to preserve indent, then echo '' >> <terminal name>.in to execute.
Use termwait <terminal name> <max idle seconds> to wait for terminal to idle (stop updating). Always waits indefinitely. Use for long running commands.