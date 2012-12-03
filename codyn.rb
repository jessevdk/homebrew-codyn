require 'formula'

class Codyn < Formula
  homepage 'http://www.codyn.net'
  head 'git://git.codyn.net/codyn/codyn.git'
  url 'git://git.codyn.net/codyn/codyn.git' , :using => :git, :revision => "c7b7e07f2c084e4770a524effbed4428710182bd"
  version '3.3'
  option :universal

  option 'with-python', 'Enable python support'

  depends_on 'autoconf' => :build
  depends_on 'automake' => :build
  depends_on 'pkg-config' => :build
  depends_on 'libxml2'
  depends_on 'glib'
  depends_on 'libtool' => :build

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
