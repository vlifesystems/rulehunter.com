source -directory [dir plugins] layout.tcl
source -directory [dir plugins] posts.tcl
source -directory [dir plugins] www.tcl

posts::generate

set destination [www::makeDestination news index.html]
set posts [posts::sort [collection get news-posts]]
set params [dict create url [www::url news index.html] posts $posts]
write $destination [layout::render news-list.tpl $params]
