source -directory plugins layout.tcl
source -directory plugins www.tcl
set destination [www::makeDestination index.html]
set params [dict create menuOption home url /index.html]
set content [ornament -params $params -directory content -file index.html]
write $destination [layout::render default.tpl $params $content]
