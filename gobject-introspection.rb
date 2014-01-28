require 'formula'

class GobjectIntrospection < Formula
  homepage 'http://live.gnome.org/GObjectIntrospection'
  url 'http://ftp.acc.umu.se/pub/GNOME/sources/gobject-introspection/1.38/gobject-introspection-1.38.0.tar.xz'
  sha256 '3575e5d353c17a567fdf7ffaaa7aebe9347b5b0eee8e69d612ba56a9def67d73'

  option :universal

  depends_on 'pkg-config' => :build
  depends_on 'xz' => :build
  depends_on 'glib'
  depends_on 'libffi'
  depends_on :python

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
