#!/bin/sh

set -e

# bail if we already are up to date
if ! uscan --no-symlink ; then
    echo "Already up-to-date."
    exit 0
fi

upstream_version=$(uscan --report --verbose | sed -n '/Newest version/ {s/.*site is \(.*\),.*/\1/;p}')
upstream_tarball=../v$upstream_version.tar.gz
version="$(uscan --report --verbose | sed -n '/Newest version/ {s/.*site is \(.*\),.*/\1/;p}')~ds1"
repack_dir="../ruby-pygments.rb-$version"

tar zxvf $upstream_tarball -C ..
mv ../pygments.rb-* $repack_dir

## remove vendor libraries
rm -rf $repack_dir/vendor

tar zcvf ../ruby-pygments.rb-$version.tar.gz $repack_dir

echo "Deleting downloaded files.."
rm -rf $repack_dir
rm -f $upstream_tarball

echo "New repackaged orig source tarball is at"
echo "    ../ruby-pygments.rb-$version.tar.gz"
