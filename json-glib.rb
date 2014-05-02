require 'formula'

class JsonGlib < Formula
  homepage 'http://live.gnome.org/JsonGlib'
  url 'http://ftp.gnome.org/pub/GNOME/sources/json-glib/0.16/json-glib-0.16.2.tar.xz'
  sha256 'a95475364ec27ab1d2a69303cf579018558bfb6981e3498b3aaf1e6401f7422c'

  option :universal

  depends_on 'pkg-config' => :build
  depends_on 'glib'
  depends_on 'xz' => :build

  def install
    ENV.universal_binary if build.universal?

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
