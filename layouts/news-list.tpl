!* commandSubst true
! source -directory [dir plugins] www.tcl
<div class="row">
  <div class="col-md-12">
    <div class="hero">
      <h1>Rulehunter News</h1>
      <h2>News, Ideas and Examples</h2>
    </div>
  </div>
</div>

<div class="row">
  <div class="col-md-12">
    <ul class="posts">
!     set numPosts 0
!     foreach post [getparam posts] {
!       incr numPosts
!       if {$numPosts >= 15} {
!         break
!       }
        <li>
          [ornament -params $post -directory [dir includes] -file post_summary.html]
        </li>
!     }
    </ul>
  </div>
</div>

<div class="row">
  <div class="col-md-12">
    <p id="rss-subscribe">
      Subscribe <a href="[www::url "/feed.xml"]">via Atom</a>
    </p>
  </div>
</div>
