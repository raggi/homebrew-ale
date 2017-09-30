require 'formula'

class OpensslOsxCa < Formula
  homepage 'https://github.com/raggi/openssl-osx-ca#readme'
  head 'https://github.com/raggi/openssl-osx-ca.git'
  url 'https://github.com/raggi/openssl-osx-ca/archive/4.0.0.tar.gz'
  sha256 'ba243e105b782c103b2d8a43be23d9c94e5c4d4f5c3b590b6878007bacaff8b3'

  def install
    system "make", "copy",
      "PREFIX=#{prefix}",
      "BINDIR=#{bin}",
      "BREW=#{HOMEBREW_PREFIX}/bin/brew"
  end

  def caveats
    if `crontab -l | grep -v openssl-osx-ca` !~ /^\s*$/
      <<-EOS.undent
    To uninstall older versions of openssl-osx-ca from your crontab. e.g.

        (crontab -l | grep -v openssl-osx-ca) | crontab -
      EOS
    end
  end

  def plist
    File.read "#{prefix}/Library/LaunchAgents/org.ra66i.openssl-osx-ca.plist"
  end

  def test
    openssl = File.join(Formula["openssl"].opt_prefix, "bin", "openssl")
    system "#{bin}/openssl-osx-ca", "-path", "#{bin}/osx-ca-certs"
    system "ls #{etc}/openssl/cert.pem"
    system <<-SHELL
      echo '' |
      #{openssl} s_client -verify 10 -CApath \? -connect github.com:443 -status |
      grep 'Verify return code' | grep '(ok)'
    SHELL
  end
end
