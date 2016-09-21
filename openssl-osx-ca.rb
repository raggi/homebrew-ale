require 'formula'

class OpensslOsxCa < Formula
  homepage 'https://github.com/raggi/openssl-osx-ca#readme'
  head 'https://github.com/raggi/openssl-osx-ca.git'
  url 'https://github.com/raggi/openssl-osx-ca/archive/2.0.1.tar.gz'
  sha256 'e2c805b0f0c2013b57b96d0649247ccc3d406c88c30dde92ad0def418f683587'

  option "without-system-keychain", "Do not include System.keychain certificates"
  option "without-login-keychain", "Do not include login.keychain certificates"

  depends_on 'openssl'

  def install
    args = %w[system-keychain login-keychain].map do |opt|
      "--skip-#{opt}" if build.without? opt
    end.join ' '

    system "make", "copy",
      "PREFIX=#{prefix}",
      "BINDIR=#{bin}",
      "ARGS=#{args}",
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
    system "#{bin}/openssl-osx-ca"
    system "ls #{etc}/openssl/cert.pem"
    system <<-SHELL
      echo '' |
      #{openssl} s_client -verify 10 -CApath \? -connect github.com:443 -status |
      grep 'Verify return code' | grep '(ok)'
    SHELL
  end
end
