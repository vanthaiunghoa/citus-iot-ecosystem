Summary: The do it all script. (Enterprise quality)
Name: citus-iot-ecosystem
Version: 0.1
Release: 1
URL:     http://support.citus.io
License: GPL
Group: Applications/Internet
BuildRoot: %{_tmppath}/%{name}-root
Requires: bash
Source0: citus-iot-ecosystem-%{version}.tar.gz
BuildArch: noarch

%description
A citus-iot-ecosystem (prototype) bundle.

%prep
%setup

%build

%install
rm -rf ${RPM_BUILD_ROOT}
mkdir -p ${RPM_BUILD_ROOT}/usr/bin
install -m 755 setup.sh ${RPM_BUILD_ROOT}%{_bindir}

%clean
rm -rf ${RPM_BUILD_ROOT}

%files
%defattr(-,root,root)
%attr(755,root,root) %{_bindir}/setup.sh

%changelog
* Thu Dec 22 2016 DUONG Dinh Cuong <cuong3ihut@gmail.com>
- shell provisioning script!