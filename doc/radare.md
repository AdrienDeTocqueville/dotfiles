# Radare 2

[Book](https://radare.gitbooks.io/radare2book/content/)

# General commands
`ood` : (re)open in debug mode
`g` : goto
`s` : seek
`u` / `U` : undo / redo seek or goto
`fs` : show flagspaces
`x/16xw` : Print 16 words as hex
`` : 
`` : 
`` : 
`` : 

# Debugger

[Book section](https://radare.gitbooks.io/radare2book/content/debugger/intro.html)

# Visual

[Book section](https://radare.gitbooks.io/radare2book/content/visual_mode/intro.html)

`!` : open panel mode

# Graph
Most of visual commands work here too
`+` / `-` : zoom / unzoom

# Panel

[Book section](https://radare.gitbooks.io/radare2book/content/visual_mode/visual_panels.html)

`space` : toggle graph mode
`w` : enter window mode (change and resize view)
`tab` : change view
`z` : swap with first panel
`x` : xref (don't know how it works)

`-` / `|` : split
`m` : Open menu
`Enter` : zoom
`b` : browser
`c` : cursor

`s` / `S` : step in / over
`.` : goto pc / entrypoint
`D` : show disas

In `dr=` view for registers (change view with i/I)
`c` : show cursor
`i` : enter insert mode (change values)
