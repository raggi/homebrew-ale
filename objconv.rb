# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Objconv < Formula
  desc "object file converter"
  homepage "http://www.agner.org/optimize/"
  url "http://www.agner.org/optimize/objconv.zip"
  version "2016-11-27"
  sha256 "5442e7bf53e8ed261424e4271262807b7ca9eb2468be7577e4197c8ed1be96b6"

  def install
    system "unzip source.zip"
    system "g++ -o objconv -O2 *.cpp"
    mkdir "#{prefix}/bin"
    system "cp", "objconv", "#{prefix}/bin/objconv"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test objconv`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
