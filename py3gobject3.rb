require 'formula'

class Py3gobject3 < Formula
  homepage 'http://live.gnome.org/PyGObject'
  url 'http://ftp.gnome.org/pub/GNOME/sources/pygobject/3.8/pygobject-3.8.1.tar.xz'
  sha256 'e85c8ec64238ce88ec1e905497f5a2eaa947a7f4050e338d21ec510d8a50eacb'

  depends_on 'xz' => :build
  depends_on 'pkg-config' => :build
  depends_on 'gobject-introspection'
  depends_on 'glib'
  depends_on 'cairo'
  depends_on 'py2cairo'

  option :universal

  def install
    ENV.universal_binary if build.universal?

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-python=/usr/local/bin/python3"

    system "make install"
  end
end
