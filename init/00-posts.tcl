source -directory plugins posts.tcl
source -directory plugins layout.tcl
source -directory plugins tags.tcl

proc makePartialContent {dir file filename} {
  set content [ornament -params $file -directory $dir -file $filename]
  return [markdown $content]
}

proc process {collectionName srcDir url} {
  # TODO: sort in date order
  set files [read -directory $srcDir details.list]

  set files [lmap file $files {
    dict set file destination [
      posts::makeDestination $url [dict get $file filename]
    ]
    dict set file tags [lsort [dict get $file tags]]
    dict set file url  [
      posts::makeURL $url [dict get $file filename]\
    ]
    dict set file date [posts::makeDate $file]
    dict set file menuOption article
    set file
  }]

  foreach file $files {
    dict set file relatedPosts [posts::makeRelated $files $file]
    set partialContent [
      makePartialContent $srcDir $file [dict get $file filename]
    ]
    dict set file summary [posts::makeExcerpt $partialContent]
    collection add $collectionName $file
    write [dict get $file destination] \
          [layout::render post.tpl $partialContent $file]
  }
}

# TODO: Put most of this code in post.tcl plugin and get src and url
# TODO: from tekyll.cfg
process news [dir content news] news
