require 'formula'

class OpensslOsxCa < Formula
  homepage 'https://github.com/raggi/openssl-osx-ca#readme'
  head 'https://github.com/raggi/openssl-osx-ca.git'
  url 'https://github.com/raggi/openssl-osx-ca/archive/1.0.2.tar.gz'
  sha1 '433fe02d490bac78898addc9ec332ab0f7b288de'

  depends_on 'openssl'

  def install
    system "make install PREFIX='#{prefix}'"
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
