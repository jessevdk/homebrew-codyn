require 'formula'

class GobjectIntrospection < Formula
  homepage 'http://live.gnome.org/GObjectIntrospection'
  url 'http://ftp.acc.umu.se/pub/GNOME/sources/gobject-introspection/1.36/gobject-introspection-1.36.0.tar.xz'
  sha256 'e3e76d9d428e7534761bf8cdf75338865a4b0872e8052bef51792744608b6383'

  option :universal

  depends_on 'pkg-config' => :build
  depends_on 'xz' => :build
  depends_on 'glib'
  depends_on 'libffi'

  def install
    ENV.universal_binary if build.universal?
    inreplace 'giscanner/transformer.py', '/usr/share', HOMEBREW_PREFIX/'share'
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          # Tests require (at least) cairo, disable them.
                          "--disable-tests"
    system "make install"
  end
end
