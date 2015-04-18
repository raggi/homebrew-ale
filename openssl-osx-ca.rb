require 'formula'

class OpensslOsxCa < Formula
  homepage 'https://github.com/raggi/openssl-osx-ca#readme'
  head 'https://github.com/raggi/openssl-osx-ca.git'
  url 'https://github.com/raggi/openssl-osx-ca/archive/1.0.5.tar.gz'
  sha1 '244b7f336c31bda68b351451f5611d9b91e43dda'

  depends_on 'openssl'

  def install
    system "make install PREFIX='#{prefix}' BREW='#{HOMEBREW_PREFIX}/bin/brew'"
  end

  def caveats; <<-EOS.undent
    To uninstall remove the openssl-osx-ca line from your crontab. e.g.

        (crontab -l | grep -v openssl-osx-ca) | crontab -
    EOS
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
