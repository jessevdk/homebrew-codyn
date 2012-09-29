require 'formula'

class Codyn < Formula
  homepage 'http://www.codyn.net'
  head 'git://git.codyn.net/codyn/codyn.git'

  option :universal

  option 'with-python', 'Enable python support'

  depends_on 'pkg-config' => :build
  depends_on 'libxml2'
  depends_on 'glib'

  if build.include? 'with-python'
    depends_on 'gobject-introspection'
    depends_on 'pygobject3'
  end

  def install
    ENV.universal_binary if build.universal?

    args = %W[
      --disable-maintainer-mode
      --disable-dependency-tracking
    ]

    if build.include? 'with-python'
      args << '--enable-python'
    end

    system "./autogen.sh", "--prefix=#{prefix}"
    system "make install" # if this fails, try separate make/make install steps
  end
end
