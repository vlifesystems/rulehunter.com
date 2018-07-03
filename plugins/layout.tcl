namespace eval layout {
  namespace export {[a-z]*}
  namespace ensemble create
}

# TODO: Work out whether should merge other values from
# TODO: config template entry into params
proc layout::render {layoutFilename params args} {
  switch [llength $args] {
    0       { set content "" }
    1       { lassign $args content }
    default { return -code error "wrong # args" }
  }
  set config [getvar plugins layout]
  if {![dict exists $config $layoutFilename]} {
    return -code error "unknown layout: $layoutFilename"
  }
  dict set params content $content
  set content [
    ornament -params $params -directory [dir layouts] -file $layoutFilename
  ]
  if {![dict exists $config $layoutFilename parent]} {
    return $content
  }
  set nextLayoutFilename [dict get $config $layoutFilename parent]
  return [render $nextLayoutFilename $params $content]
}
