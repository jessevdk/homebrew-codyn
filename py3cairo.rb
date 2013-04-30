require 'formula'

class Py3cairo < Formula
  homepage 'http://cairographics.org/pycairo/'
  url 'http://cairographics.org/releases/pycairo-1.10.0.tar.bz2'
  sha1 'b4283aa1cc9aafd12fd72ad371303a486da1d014'

  depends_on 'pkg-config' => :build
  depends_on 'cairo'
  depends_on :x11

  option :universal

  fails_with :llvm do
    build 2336
    cause "The build script will set -march=native which llvm can't accept"
  end

  def install
    # Python extensions default to universal but cairo may not be universal
    ENV.universal_binary if build.universal?
#    unless build.universal?
#      ENV['ARCHFLAGS'] = if MacOS.prefer_64_bit?
#        "-arch x86_64"
#      else
#        "-arch i386"
#      end
#    end

    # waf miscompiles py2cairo on >= lion with HB python, linking the wrong
    # Python Library.  So add a LINKFLAG that sets the path.
    # https://github.com/mxcl/homebrew/issues/12893
    # https://github.com/mxcl/homebrew/issues/14781
    # https://bugs.freedesktop.org/show_bug.cgi?id=51544
    ENV['PATH'] = ENV['PATH'] + ':/usr/local/bin'
    ENV['LINKFLAGS'] = "-L#{%x(/usr/local/bin/python3-config --prefix).chomp}/lib"
    ENV['PYTHON'] = 'python3'
    system "./waf", "configure", "--prefix=#{prefix}", "--nopyc", "--nopyo"
    system "./waf", "install"
  end

  def caveats; <<-EOS.undent
    For non-homebrew Python, you need to amend your PYTHONPATH like so:
      export PYTHONPATH=#{HOMEBREW_PREFIX}/lib/#{which_python}/site-packages:$PYTHONPATH
    EOS
  end

  def which_python
    "python3" + `/usr/local/bin/python3 -c 'import sys;print(sys.version[:3])'`.strip
  end
end
