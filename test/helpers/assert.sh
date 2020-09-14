assert_fail() {
  lineno="$1"
  msg="$2"
  if test "$msg" = ""; then
    msg="Assertion failed!"
  fi
  echo "Line $lineno: $msg" 1>&2
}

assert_equal() {
  lineno="$1"
  val_expected="
  if test "$val_expected" != "$val_actual"
}
