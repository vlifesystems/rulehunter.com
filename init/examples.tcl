return
source -directory plugins layout.tcl
source -directory plugins www.tcl

set files [read -directory [dir content docs examples] details.list]

proc makeContent {file} {
  return [markdown \
      -directory [dir content docs examples] \
      -file [dict get $file filename]
  ]
}

# url is where the destination should be based off, such as docs
proc makeDestination {url filename} {
  set filename [file tail $filename]
  set ok [regexp {^(.*).md$} $filename match titleDir]
  if {$ok} {
    return [www::makeDestination $url $titleDir index.html]
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

set files [lmap file $files {
  dict set file url [makeURL "docs/examples" [dict get $file filename]]
  set file
}]

foreach file $files {
  set content [makeContent $file]
  set params [dict merge [dict create files $files place examples] $file]
  write [makeDestination [file join docs examples] [dict get $file filename]] \
        [layout::render doc.tpl $content $params]
}

