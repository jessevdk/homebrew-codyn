require 'formula'

class JsonGlib < Formula
  homepage 'http://live.gnome.org/JSonGLib'
  url 'ftp://ftp.gnome.org/pub/GNOME/sources/json-glib/0.16/json-glib-0.16.0.tar.xz'
  sha256 'e4a3fd2f399e4c148aad608e6ed0a94095f2ddde9dd12f5aa2f072ecae5c1d37'

  option :universal

  depends_on 'pkg-config' => :build
  depends_on 'xz' => :build
  depends_on 'glib'

  def install
    ENV.universal_binary if build.universal?

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
