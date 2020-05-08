Name:		sftpd
Version:	8.1
Release:	1
Summary:	sftpd daemon

Group:		mysoft
License:	GPL
URL:		http://redflag-os.com/
Source0:	sftpd_config
Source1:	sftpd
BuildRoot:	%(mktemp -ud %{_tmppath}/%{name}-%{version}-%{release}-XXXXXX)	

%define		debug_package %{nil}
#BuildRequires:	
#Requires:	
#Packager:	
%description
	sftpd daemon

%prep
#%setup -q 

%build

%install
mkdir -p %{buildroot}/{/etc/ssh/,/etc/rc.d/init.d/,/usr/sbin/,/etc/pam.d/}
cp %{SOURCE0} %{buildroot}/etc/ssh/
cp %{SOURCE1} %{buildroot}/etc/rc.d/init.d/
cp /usr/sbin/sshd  %{buildroot}/usr/sbin/sftpd
cp /etc/pam.d/sshd  %{buildroot}/etc/pam.d/sftpd

%clean
rm -rf %{buildroot} %{_builddir}

%files
%defattr(-,root,root,-)
/etc/ssh/sftpd_config
/etc/rc.d/init.d/sftpd
/usr/sbin/sftpd
/etc/pam.d/sftpd

%pre

%post

%preun

%postun

%changelog

