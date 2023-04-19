PACKAGE_NAME = "td-agent"
PACKAGE_VERSION = "4.4.2"

FLUENTD_REVISION = 'e89092ce1132a933c12bb23fe8c9323c07ca81f5' # v1.15.3
FLUENTD_LOCAL_GEM_REPO = "file://" + File.expand_path(File.join(__dir__, "local_gem_repo"))

# https://github.com/jemalloc/jemalloc/releases
# Use jemalloc 3.x to reduce memory usage
# See https://github.com/fluent-plugins-nursery/fluent-package-builder/issues/305
JEMALLOC_VERSION = "3.6.0"
#JEMALLOC_VERSION = "5.2.1"

# https://www.openssl.org/source/
OPENSSL_VERSION = "1.1.1t"

# To fix memory leak issue: https://github.com/fluent/fluent-package-builder/issues/374
MINGW_OPENSSL_VERSION = "1.1.1.s-1"
MINGW_OPENSSL_SHA256SUM = "bd8d5cc247e1f75f09e60e9ae6f73d6410349fcd9ed5dd9fc0729262adce922f"

BUNDLER_VERSION= "2.3.18"

# https://www.ruby-lang.org/en/downloads/ (tar.gz)
BUNDLED_RUBY_VERSION = "2.7.8"
BUNDLED_RUBY_SOURCE_SHA256SUM = "c2dab63cbc8f2a05526108ad419efa63a67ed4074dbbcf9fc2b1ca664cb45ba0"
#BUNDLED_RUBY_VERSION = "3.0.6"
#BUNDLED_RUBY_SOURCE_SHA256SUM = "6e6cbd490030d7910c0ff20edefab4294dfcd1046f0f8f47f78b597987ac683e"
#BUNDLED_RUBY_VERSION = "3.1.4"
#BUNDLED_RUBY_SOURCE_SHA256SUM = "a3d55879a0dfab1d7141fdf10d22a07dbf8e5cdc4415da1bde06127d5cc3c7b6"

BUNDLED_RUBY3_VERSION = "3.1.4"
BUNDLED_RUBY3_SOURCE_SHA256SUM = "a3d55879a0dfab1d7141fdf10d22a07dbf8e5cdc4415da1bde06127d5cc3c7b6"

BUNDLED_RUBY_PATCHES = [
  ["ruby-2.7/0001-Removed-the-old-executables-of-racc.patch",            ["~> 2.7.0"]],
  ["ruby-2.7/0002-Fixup-a6864f6d2f39bcd1ff04516591cc18d4027ab186.patch", ["~> 2.7.0"]],
  ["ruby-3.0/0001-ruby-resolv-Fix-confusion-of-received-response-messa.patch",   ["= 2.7.3"]],
  ["ruby-3.0/0001-ruby-resolv-Fix-confusion-of-received-response-messa.patch",   ["= 3.0.1"]],
]

# https://rubyinstaller.org/downloads/ (7-ZIP ARCHIVES)
BUNDLED_RUBY_INSTALLER_X64_VERSION = "2.7.8-1"
BUNDLED_RUBY_INSTALLER_X64_SHA256SUM = "6958f62524da23d5956851a4e4488a5184c605e96aab3c8f9526cd2fae7cb8c1"
#BUNDLED_RUBY_INSTALLER_X64_VERSION = "3.0.6-1"
#BUNDLED_RUBY_INSTALLER_X64_SHA256SUM = "b60d5a6596e099d86b7844be3254355e12d7b9190c28a580c5352e0574930b28"
#BUNDLED_RUBY_INSTALLER_X64_VERSION = "3.1.4-1"
#BUNDLED_RUBY_INSTALLER_X64_SHA256SUM = "6701088607ea4b587a31af76d75cb3fe9f7bcd75fc175cffcca22369ebb6331d"

# Patch files are assumed to be for Ruby's source tree, then applied to
# lib/ruby/x.y.0 in RubyInstaller. So that "-p2" options will be passed
# to patch command.
BUNDLED_RUBY_INSTALLER_PATCHES = [
  ["ruby-3.0/0001-ruby-resolv-Fix-confusion-of-received-response-messa.patch", ["= 2.7.3"]],
  ["ruby-3.0/0001-ruby-resolv-Fix-confusion-of-received-response-messa.patch", ["= 3.0.1"]],
]
