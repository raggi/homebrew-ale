class Grub < Formula
  desc "GRand Unified Bootloader"
  homepage "https://www.gnu.org/software/grub/"

  # Note: 2.00 doesn't build with apple clang, head does.
  # url "ftp://ftp.gnu.org/gnu/grub/grub-2.00.tar.xz"
  # sha256 "784ec38e7edc32239ad75b8e66df04dc8bfb26d88681bc9f627133a6eb85c458"
  head "git://git.savannah.gnu.org/grub.git"

  depends_on "autoconf" => :build
  depends_on "autogen" => :build
  depends_on "automake" => :build
  depends_on "binutils" => :build
  depends_on "flex" => :build

  depends_on "objconv" => :build

  depends_on "qemu" => :test
  depends_on "xorriso" => :test

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}", "--target=x86_64-pc-elf"
    system "make", "install"
  end

  test do
    system "make check"
  end
end
