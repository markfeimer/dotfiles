echom "Mark's Markdown syntax file loaded"

syntax match mmdHeader "^#.*$"
highlight link mmdHeader Identifier 

syntax match mmdComment "&.*$"
highlight link mmdComment Comment

syntax match mmdPreformatted "^> .*$"
highlight link mmdPreformatted Statement

syntax match mmdTypefaceMod "\v_.+_"
syntax match mmdTypefaceMod "\v\*.+\*"
highlight link mmdTypefaceMod Function


