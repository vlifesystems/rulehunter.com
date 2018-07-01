namespace eval posts {
  namespace export {[a-z]*}
  namespace ensemble create
  source -directory [dir plugins] www.tcl
}

proc posts::makeDate {post} {
  set date ""
  if {[dict exists $post date]} {
    set date [dict get post date]
  }
  if {$date ne ""} {
    return [clock scan $date -format {%Y-%m-%d}]
    # TODO: output warning if can't read format
  } elseif {[dict exists $post filename]} {
    set filename [file tail [dict get $post filename]]
    set ok [regexp {^(\d{4})-(\d{2})-(\d{2})-.*$} \
                   $filename match year month day \
    ]
    if {$ok} {
      return [clock scan "$year-$month-$day" -format {%Y-%m-%d}]
    }
  } else {
    # TODO: output warning if can't read format
    return [clock seconds]
  }
}

proc posts::makeExcerpt {partialContent} {
  return [string range [strip_html $partialContent] 0 300]
}

# url is where the destination should be based off, such as blog
proc posts::makeDestination {url filename} {
  set filename [file tail $filename]
  set ok [regexp {^(\d{4})-(\d{2})-(\d{2})-(.*).md$} \
                 $filename match year month day titleDir \
  ]
  if {$ok} {
    return [www::makeDestination $url $year $month $day $titleDir index.html]
  }
  # TODO: Raise an error
}

# url is where the url should be based off, such as blog
proc posts::makeURL {url filename} {
  set filename [file tail $filename]
  set ok [regexp {^(\d{4})-(\d{2})-(\d{2})-(.*).md$} \
                 $filename match year month day titleDir \
  ]
  if {$ok} {
    return "[www::url $url $year $month $day $titleDir]/"
  }
  return -code error "makeURL: invalid filename: $filename"
}

# Return any posts related to the supplied post. This is done by looking
# at the tags.  The return post is a simplified version containing just
# the title and url.
proc posts::makeRelated {posts post} {
  set postTags [dict get $post tags]
  set relatedPostStats [lmap oPost $posts {
    set numTagsMatch 0
    foreach oTag [dict get $oPost tags] {
      if {[lsearch $postTags $oTag] >= 0 &&
          [dict get $post filename] ne [dict get $oPost filename]} {
        incr numTagsMatch
      }
    }
    if {$numTagsMatch == 0} {
      continue
    }
    list $numTagsMatch $oPost
  }]
  set relatedPostStats [lsort -decreasing -command {apply {{a b} {
    set aNumTags [lindex $a 0]
    set bNumTags [lindex $b 0]
    set numTagsDiff [expr {$aNumTags - $bNumTags}]
    if {$numTagsDiff != 0} {
      return $numTagsDiff
    }
    return [expr {[dict get [lindex $a 1] date] -
                  [dict get [lindex $b 1] date]}]
  }}} $relatedPostStats]
  return [lmap x $relatedPostStats {
    set post [lindex $x 1]
    dict create title [dict get $post title] url [dict get $post url]
  }]
}


# Sort posts in decreasing date order
proc posts::sort {posts} {
  return [lsort -command [namespace which CompareDate] -decreasing $posts]
}

proc posts::CompareDate {a b} {
  return [expr {[dict get $a date] - [dict get $b date]}]
}
