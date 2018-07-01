namespace eval tags {
  namespace export {[a-z]*}
  namespace ensemble create
}

proc tags::toDirName {tag} {
 return [string tolower [regsub -all {[^[:alnum:]_-]} $tag {}]]
}

proc tags::generatePages {files writeCommand {tags {}}} {
  foreach tag $tags {
    set tagFiles [list]
    set tagFileIndices [list]
    foreach file $files {
      if {![dict exists $file tags]} {
        continue
      }
      if {[lsearch [dict get $file tags] $tag] >= 0} {
        lappend tagFiles $file
      }
    }
    $writeCommand $tag $tagFiles
  }
}

proc tags::collect {collectionName files} {
  set allTags [list]
  foreach file $files {
    foreach tag [dict get $file tags] {
      if {[lsearch $allTags $tag] == -1} {
        lappend allTags $tag
        ::collection add $collectionName $tag
      }
    }
  }
  return $allTags
}
