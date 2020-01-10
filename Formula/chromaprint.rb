class Chromaprint < Formula
  desc "Core component of the AcoustID project (Audio fingerprinting)"
  homepage "https://acoustid.org/chromaprint"
  head "https://github.com/acoustid/chromaprint.git"
  version 1.4.3

  stable do
    url "https://github.com/acoustid/chromaprint/releases/download/v1.4.3/chromaprint-1.4.3.tar.gz"
    sha256 "ea18608b76fb88e0203b7d3e1833fb125ce9bb61efe22c6e169a50c52c457f82"
    revision 1
  end

  depends_on "cmake" => :build
  depends_on "fftw" => :optional

  def install
    args = %W[
      -DCMAKE_BUILD_TYPE=Release
      -DBUILD_TOOLS=ON
    ]

    if build.with?("fftw")
      args << "-DFFT_LIB=fftw3"
    elsif OS.mac?
      args << "-DFFT_LIB=vdsp"
    else
      args << "-DFFT_LIB=kissfft"
    end

    system "cmake", *args, ".", *std_cmake_args
    system "make", "install"
  end

  test do
    out = shell_output("#{bin}/fpcalc -json -format s16le -rate 44100 -channels 2 -length 10 /dev/zero")
    assert_equal "AQAAO0mUaEkSRZEGAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", JSON.parse(out)["fingerprint"]
  end
end