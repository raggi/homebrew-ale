require 'formula'

class OpensslOsxCa < Formula
  homepage 'https://github.com/raggi/openssl-osx-ca#readme'
  head 'https://github.com/raggi/openssl-osx-ca.git'
  url 'https://github.com/raggi/openssl-osx-ca/archive/1.0.3.tar.gz'
  sha1 '8d6607c66b2fb454d1d79ef509fab7737f6eaaec'

  depends_on 'openssl'

  def install
    system "make install PREFIX='#{prefix}' BREW='#{HOMEBREW_PREFIX}/bin/brew'"
  end

  def caveats; <<-EOS.undent
    To get instant-on, please run:

        openssl-osx-ca

    To uninstall remove the openssl-osx-ca line from your crontab. e.g.

        (crontab -l | grep -v openssl-osx-ca) | crontab -
    EOS
  end

  def test
    system "#{bin}/openssl-osx-ca"
    system "ls #{etc}/openssl/cert.pem"
  end
end
