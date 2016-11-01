require 'spec_helper'
require 'serverspec'

package = 'isc-dhcp-client'
service = 'dhclient'
config  = '/etc/dhclient.conf'

case os[:family]
when 'redhat'
  package = 'dhclient'
  config = '/etc/dhcp/dhclient.conf'
when 'ubuntu'
  config = '/etc/dhcp/dhclient.conf'
end

case os[:family]
when 'freebsd', 'openbsd'
else
  describe package(package) do
    it { should be_installed }
  end 
end

describe file(config) do
  it { should be_file }
  case host_inventory['fqdn']
  when 'default-freebsd-103-amd64', 'default-ubuntu-1404-amd64', 'default-centos-72-x86-64'
    its(:content) { should match(/^supersede\s+domain-name-servers\s+#{ Regexp.escape('8.8.4.4,8.8.8.8') };/) }
  else
    its(:content) { should match(/^supersede\s+domain-name-servers\s+#{ Regexp.escape('8.8.8.8,8.8.4.4') };/) }
  end
end

case os[:family]
when 'freebsd'
  describe service(service) do
    it { should be_running }
  end
when 'openbsd'
  describe process('dhclient') do
    it { pending "serverspec does not support OpenBSD's ps"; should be_running }
  end
when 'ubuntu'
  describe process('dhclient') do
    it { should be_running }
  end
end

describe file('/etc/resolv.conf') do
  case host_inventory['fqdn']
  when 'default-freebsd-103-amd64', 'default-ubuntu-1404-amd64', 'default-centos-72-x86-64'
    its(:content) { should match(/nameserver\s+#{ Regexp.escape('8.8.4.4') }\nnameserver\s+#{ Regexp.escape('8.8.8.8') }/) }
  else
    its(:content) { should match(/nameserver\s+#{ Regexp.escape('8.8.8.8') }\nnameserver\s+#{ Regexp.escape('8.8.4.4') }/) }
  end
end
