source -directory plugins layout.tcl
source -directory plugins www.tcl


proc makeContent {dir file} {
  return [markdown -directory $dir -file [dict get $file filename]]
}

# dir is where the destination should be based off, such as docs
proc makeDestination {dir filename} {
  set filename [file tail $filename]
  set ok [regexp {^(.*).md$} $filename match titleDir]
  if {$ok} {
    return [www::makeDestination $dir $titleDir index.html]
  }
  return -code error "invalid filename: $filename"
}

# url is where the destination should be based off, such as docs
proc makeURL {url filename} {
  set filename [file tail $filename]
  set ok [regexp {^(.*).md$} $filename match titleDir]
  if {$ok} {
    return [www::url $url $titleDir]
  }
  return -code error "invalid filename: $filename"
}

proc processDir {place args} {
  set files [read -directory [dir content {*}$args] details.list]
  set files [lmap file $files {
    if {[dict exists $file subdir]} {
      dict set file url [www::url {*}$args [dict get $file subdir]]
    } elseif {[dict exists $file isIndex] && [dict get $file isIndex]} {
      dict set file url [www::url {*}$args]
      dict set file destination [www::makeDestination {*}$args index.html]
    } else {
      dict set file url [makeURL [www::url {*}$args] [dict get $file filename]]
      dict set file destination [
        makeDestination [file join {*}$args] [dict get $file filename]
      ]
    }
    set file
  }]

  foreach file $files {
    if {[dict exists $file subdir]} {
      processDir [dict get $file subdir] docs [dict get $file subdir]
    } else {
      set content [makeContent [dir content {*}$args] $file]
      set params [dict merge [dict create files $files place $place] $file]
      write [dict get $file destination] [layout::render doc.tpl $params $content]
    }
  }
}

processDir docs docs
