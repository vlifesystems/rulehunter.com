!* commandSubst true variableSubst true
! source -directory [dir plugins] posts.tcl
! source -directory [dir plugins] www.tcl
! set title [getparam title]
! set date [getparam date]
<div class="row">
  <div class="col-md-12">
    <article itemscope itemtype="http://schema.org/BlogPosting">
      <header>
        <div class="hero">
          <h1 itemprop="name">
            <a href="[www::url [getparam url]]" title="$title">
              $title
            </a>
          </h1>
          <div class="center-block">
            Published:
              <time datetime="[clock format $date -format {%Y-%m-%d}]">
                [clock format $date -format {%e %B %Y}]
              </time>
            by <a href="[getparam author url]">[getparam author name]</a><br />
            Tags:
!           foreach tag [getparam tags] {
              <a href="[www::url "/news/tag/[posts::tagToDirName $tag]/"]">$tag</a>
              &nbsp; &nbsp;
!           }
          </div>
        </div>
      </header>

      <div itemprop="articleBody">
        [getparam content]
      </div>
    </article>
  </div>
</div>

! if {[llength [getparam relatedPosts]] >= 1} {
  <div class="row">
    <div class="col-md-12">
      <div id="related">
        <h2>Related Articles</h2>
        <ul>
!     set i 0
!     foreach post [getparam relatedPosts] {
!       if {$i < 5} {
          <li>
            <a href="[www::url [dict get $post url]]">
              [dict get $post title]
            </a>
          </li>
!       }
!     }
        </ul>
      </div>
    </div>
  </div>
! }
