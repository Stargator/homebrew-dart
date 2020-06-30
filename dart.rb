class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"
  conflicts_with "dart-dev", :because => "dart-dev ships the same binaries"

  version "2.8.4"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "0f576e249e22f61301d46a5bde267f08a330a1ad0954be348a10e44e43bdd94c"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "39a6b937fc69e9c00e0ef1d1b3931bb0d63d49acbc3efbcc6114352fb301d5e3"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "7d113061130945cf55aff23081aa44957197178842fc6be1072e12b5f78450e3"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "8cfbecaa5a108a951ce9f3c0c9be045001c1313372f6533d1a8245a32ae9cf20"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.8.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "04e6e315532a27f1e295dfb67176da680baaeccfa41beadf4a013334a9e7d557"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"]
  end

  def caveats
    <<~EOS
      Please note the path to the Dart SDK:
        #{opt_libexec}
    EOS
  end

  test do
    (testpath/"sample.dart").write <<~EOS
      void main() {
        print(r"test message");
      }
    EOS

    assert_equal "test message\n", shell_output("#{bin}/dart sample.dart")
  end
end
