!* commandSubst true
! source -directory [dir plugins] include.tcl
<!DOCTYPE html>
<html>
  [include head.html]
  <body>
    [include header.html]
    <div class="container">
      [getparam content]
    </div><!-- /.container -->

    [include footer.html]
  </body>
</html>
