vim9script

# Tests reused from https://github.com/jonhoo/proximity-sort

import 'libtinytest.vim' as tt
import 'sorter.vim' as s

def Test_PS_File_Reorder()
  assert_equal(
    s.ProxSort("bar/main.txt", [
      "test.txt",
      "bar/test.txt",
      "bar/main.txt",
      "misx/test.txt",
    ])[0 : 1], [
      "bar/main.txt",
      "bar/test.txt",
    ]
  )

  assert_equal(
    s.ProxSort("foobar/controller/admin.rb", [
      "baz/controller/admin.rb",
      "foobar/controller/user.rb",
      "baz/views/admin.rb",
      "foobar/controller/admin.rb",
      "foobar/views/admin.rb",
    ])[0 : 2], [
      "foobar/controller/admin.rb",
      "foobar/controller/user.rb",
      "foobar/views/admin.rb",
    ]
  )
enddef

def Test_PS_Root_Is_Closer()
  assert_equal(
    s.ProxSort("a/null.txt", [
      "a/foo.txt",
      "b/foo.txt",
      "foo.txt",
    ]), [
      "a/foo.txt",
      "foo.txt",
      "b/foo.txt",
    ]
  )
enddef

def Test_PS_Stable()
  assert_equal(
    s.ProxSort("null.txt", [
      "c.txt",
      "b.txt",
      "a.txt",
    ]), [
      "c.txt",
      "b.txt",
      "a.txt",
    ]
  )
enddef

def Test_PS_Skip_Leading_Dot()
  assert_equal(
    s.ProxSort("null.txt", [
      "./first.txt",
      "././second.txt",
      "third.txt",
    ]), [
      "./first.txt",
      "././second.txt",
      "third.txt",
    ]
  )
enddef

def Test_PS_Check_Same_Proximity_Sorted()
  assert_equal(
    s.ProxSort("null.txt", [
      "b/2.txt",
      "b/1.txt",
      "a/x/2.txt",
      "a/x/1.txt",
      "a/2.txt",
      "a/1.txt",
    ]), [
      "b/2.txt",
      "b/1.txt",
      "a/2.txt",
      "a/1.txt",
      "a/x/2.txt",
      "a/x/1.txt",
    ]
  )
enddef

tt.Run('_PS_')
