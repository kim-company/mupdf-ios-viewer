{
  "name": "MuPDF",
  "version": "1.10",
  "summary": "A lightweight PDF and XPS viewer.",
  "cocoapods_version": ">= 0.39",
  "description": "MuPDF is a small, fast, and yet complete PDF viewer. \nIt supports PDF 1.7 with transparency, encryption, \nhyperlinks, annotations, searching and more. It also\nreads XPS and OpenXPS documents. Licensed under the AGPL.\nCommercial licensing is also available, contact\nsales@artifex.com.",
  "homepage": "http://www.mupdf.com/",
  "license": {
    "type": "Affero GNU GPL v3",
    "file": "COPYING"
  },
  "authors": "Artifex",
  "source": {
    "git": "git://git.ghostscript.com/mupdf.git",
    "tag": "1.10a",
    "submodules": true
  },
  "platforms": {
    "ios": "8.0"
  },
  "requires_arc": false,
  "module_name": "mupdf",
  "source_files": [
    "platform/ios/Classes/**/*.[m]",
    "platform/ios/common.m",
    "include/mupdf/**/*"
  ],
  "resources": [
    "platform/ios/*.png",
    "platform/android/res/drawable-ldpi/*.png"
  ],
  "prepare_command": "cd platform/ios\n# release armv7 + arm64\nxcodebuild -scheme MuPDF -configuration Release CODE_SIGN_IDENTITY=\"\" CODE_SIGNING_REQUIRED=NO\n\n# debug 64bit sim\nxcodebuild -scheme MuPDF -configuration Release -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO CODE_SIGN_IDENTITY=\"\" CODE_SIGNING_REQUIRED=NO\ncd ../../build/\nfor i in mupdf mupdfthird; do\n    LIB=lib${i}.a\n    lipo -create -output $LIB release-ios-i386-x86_64/$LIB release-ios-armv7-arm64/$LIB\ndone\n\n# rename to avoid any conflict with the libmupdf.a that the pod generates\nmv libmupdf.a libmupdfcore.a\n\n# copy iOS headers into the general include directory, as\n# cocoapods 1.0 insists that all headers are under the\n# header_mappings_dir location\ncd ..\ncp platform/ios/Classes/*.h platform/ios/common.h include/mupdf/\ncd platform/ios\n# now fix the imports/includes to be mupdf/foo.h instead of foo.h\nfind . -name '*.[mh]' -print0 | xargs -0 perl -pi -e 's,#import \"Mu,#import \"mupdf/Mu,'\nfind . -name '*.[mh]' -print0 | xargs -0 perl -pi -e 's,#include \"common.h\",#include \"mupdf/common.h\",'\nfind . -name '*.[mh]' -print0 | xargs -0 perl -pi -e 's,#import \"common.h\",#import \"mupdf/common.h\",'\n\n# the reference to memory.h in memento.h upsets xcode when\n# building a module (fixed upstream for version after 1.9)\ncd ../..\nfind . -name 'memento.h' -print0 | xargs -0 perl -pi -e 's,#include <memory.h>,#include <stdlib.h>,'",
  "public_header_files": "include/mupdf/**/*",
  "header_mappings_dir": "include",
  "vendored_libraries": "build/*.a",
  "xcconfig": {
    "USE_HEADERMAP": "NO",
    "USER_HEADER_SEARCH_PATHS": "\"${PODS_ROOT}/mupdf/include\""
  }
}