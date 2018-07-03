source -directory [dir plugins] layout.tcl
source -directory [dir plugins] posts.tcl
source -directory [dir plugins] www.tcl

posts::generate

set destination [www::makeDestination news index.html]
set posts [posts::sort [collection get news]]
set params [dict create menuOption blog url /news/index.html posts $posts]
set content ""
write $destination [layout::render news-list.tpl $content $params]
