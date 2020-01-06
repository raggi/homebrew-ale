require 'formula'

class OpensslOsxCa < Formula
  homepage 'https://github.com/raggi/openssl-osx-ca#readme'
  head 'https://github.com/raggi/openssl-osx-ca.git'
  url 'https://github.com/raggi/openssl-osx-ca/archive/5.0.1.tar.gz'
  sha256 '1982733624a81c9164e8b15f28550e0f55f26724f48737880285f4b3890a649c'

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
    cafile = "#{Formula["openssl"].etc}/#{Formula["openssl"].full_name}/cert.pem"
    system "ls #{cafile}"
    system <<-SHELL
      echo '' |
      #{openssl} s_client -verify 10 -CAfile #{cafile} -connect github.com:443 -status |
      grep 'Verify return code' | grep '(ok)'
    SHELL
  end
end
