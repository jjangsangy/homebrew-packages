class Bashdb < Formula
  desc "Bash shell debugger"
  homepage "https://bashdb.sourceforge.io"
  url "https://downloads.sourceforge.net/project/bashdb/bashdb/5.0-1.1.2/bashdb-5.0-1.1.2.tar.bz2"
  version "5.0-1.1.2"
  sha256 "30176d2ad28c5b00b2e2d21c5ea1aef8fbaf40a8f9d9f723c67c60531f3b7330"
  license "GPL-2.0"

  # We check the "bashdb" directory page because the bashdb project contains
  # various software and bashdb releases may be pushed out of the SourceForge
  # RSS feed.
  livecheck do
    url "https://sourceforge.net/projects/bashdb/files/bashdb/"
    strategy :page_match
    regex(%r{href=(?:["']|.*?bashdb/)?v?(\d+(?:[.-]\d+)+)/?["' >]}i)
  end

  head do
    url "https://git.code.sf.net/p/bashdb/code.git",
      :using => :git,
      :branch => "bash-5.1",
      :revision => "abac8ee0db03a62d9dc360640e9e5b9648a8fc12"
    version "5.1.4"
  end

  bottle do
    sha256 cellar: :any_skip_relocation, big_sur:     "e49b34af9e621c91f6a101bfe327182f956f7b25b48d9fc7804e5d8ea0277263"
    sha256 cellar: :any_skip_relocation, catalina:    "0ab6de48ce871bc7b6abc582154b425350a70b7f2ecadd3b303c7a91dafc3c41"
    sha256 cellar: :any_skip_relocation, mojave:      "0ab6de48ce871bc7b6abc582154b425350a70b7f2ecadd3b303c7a91dafc3c41"
    sha256 cellar: :any_skip_relocation, high_sierra: "0ab6de48ce871bc7b6abc582154b425350a70b7f2ecadd3b303c7a91dafc3c41"
  end

  depends_on "autoconf" => :build
  depends_on "bash"

  def install
    system "autoreconf", "-fiv"
    system "./configure", "--with-bash=#{HOMEBREW_PREFIX}/bin/bash",
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"

    system "make", "install"
  end

  test do
    assert_match version.to_s, pipe_output("#{bin}/bashdb --version 2>&1")
  end
end
