!* commandSubst true
<div class="row">
  <div class="col-md-10 col-md-offset-2">
    <div class="hero">
      <h1>[getparam title]</h1>
      <h2>[getparam subtitle]</h2>
    </div>
  </div>
</div>

<div class="row">
  <div class="col-md-2">
  <ol class="doc-breadcrumb breadcrumb">
!   if {[getparam place] eq "docs"} {
      <li class="active">Docs</li>
!   } else {
    <li><a href="/docs/">Docs</a></li>
    <li class="active">Examples</li>
!   }
  </ol>
    <nav class="navbar">
      <ul class="nav">
!       foreach file [getparam files] {
          <li>
            <a href="[dict get $file url]" title="[dict get $file summary]">
              [dict get $file title]
            </a>
          </li>
!       }
      </ul>
    </nav>
  </div>
  <div class="col-md-10">
    [getparam content]
  </div>
</div>
