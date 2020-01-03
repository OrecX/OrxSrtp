#
# spec file for package liborksrtp
#
# Copyright (c) 2019 SUSE LINUX GmbH, Nuernberg, Germany.
#
# All modifications and additions to the file contributed by third parties
# remain the property of their copyright owners, unless otherwise agreed
# upon. The license for this file, and modifications and additions to the
# file, is the same license as for the pristine package itself (unless the
# license for the pristine package is not an Open Source License, in which
# case the license is the MIT License). An "Open Source License" is a
# license that conforms to the Open Source Definition (Version 1.9)
# published by the Open Source Initiative.

# Please submit bugfixes or comments via http://bugs.opensuse.org/
#


Name:           liborxsrtp
Version:        0.2
Release:        1%{?dist}
Summary:        SRTP support library
Source:        liborxsrtp-%{version}.tar.gz
License:        LGPLv2+

Requires:       libgcrypt
BuildRoot:      %{_tmppath}/%{name}-%{version}-build
Provides: liborxsrtp.so()(64bit)



%description
liborxsrtp provides a library version of the SRTP support as originally
part of  VLC 


%package        devel
Summary:        Development files for %{name}
#Group:          Development/Libraries/
Requires:       %{name} = %{version}

%description    devel
The %{name}-devel package contains libraries and header files for
developing applications that use %{name}.

%prep
%setup -q

%build
make %{?_smp_mflags}

%install
%make_install
find %{buildroot} -type f -name "*.la" -delete -print
# Overwrite development symlinks.
pushd $RPM_BUILD_ROOT/%{_libdir}
for shlib in lib*.so.* ; do
	 shlib=`echo "$shlib" | sed -e 's,//,/,g'`
 	target=`basename "$shlib" | sed -e 's,\.so.*,,g'`.so
	ln -sf $shlib $target
done
popd

%post -p /sbin/ldconfig
%postun -p /sbin/ldconfig

%files
%defattr(-,root,root)
%doc
%{_libdir}/liborxsrtp.so.%{version}
%{_libdir}/liborxsrtp.so
 /usr/share/liborxsrtp/COPYING


%files devel
%defattr(-,root,root)
#%doc
#%{_includedir}/*
#%{_libdir}/*.so
/usr/include/srtp/srtp.h

%changelog
