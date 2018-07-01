source -directory [dir plugins] layout.tcl
source -directory [dir plugins] posts.tcl
source -directory [dir plugins] www.tcl

set destination [www::makeDestination news index.html]
set posts [posts::sort [collection get news]]
set params [dict create menuOption blog url /news/index.html posts $posts]
set content [ornament \
    -params $params \
    -directory [dir content news] \
    -file index.html
]
write $destination [layout::render default.tpl $content $params]
