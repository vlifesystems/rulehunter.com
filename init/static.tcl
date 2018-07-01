source -directory [dir plugins] www.tcl
set cssDir [dir content static css]
file copy [file join $cssDir *.css] \
          [file join $cssDir *.map] \
          [www::makeDestination css]

set imagesDir [dir content static img]
file copy [file join $imagesDir *.png] \
          [www::makeDestination img]

set fontsDir [dir content static fonts]
file copy [file join $fontsDir *.eot] \
          [file join $fontsDir *.woff] \
          [file join $fontsDir *.svg] \
          [file join $fontsDir *.woff2] \
          [file join $fontsDir *.ttf] \
          [www::makeDestination fonts]

set jsDir [dir content static js]
file copy [file join $jsDir *.js] [www::makeDestination js]

set staticDir [dir content static]
file copy [file join $staticDir CNAME] \
          [file join $staticDir .nojekyll] \
          [www::makeDestination]
