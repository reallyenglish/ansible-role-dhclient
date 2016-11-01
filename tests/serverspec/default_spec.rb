require 'spec_helper'
require 'serverspec'

package = 'dhclient'
service = 'dhclient'
config  = '/etc/dhclient.conf'

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
  when 'default-freebsd-103-amd64'
    its(:content) { should match(/^supersede\s+domain-name-servers\s+#{ Regexp.escape('8.8.4.4,8.8.8.8') };/) }
  else
    its(:content) { should match(/^supersede\s+domain-name-servers\s+#{ Regexp.escape('8.8.8.8,8.8.4.4') };/) }
  end
end

describe service(service) do
  it { should be_running }
end
