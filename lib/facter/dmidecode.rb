# Fact: dmidecode
#
# Purpose: Obtain actual physical memory installed
#
# Resolution:
#   uses dmidecode
#
# Caveats:
#   none
#
# Notes:
#   none

Facter.add(:physical_memory) do
  confine osfamily: 'RedHat'
  confine virtual: 'physical'
  setcode do
    physical_memory = {}
    if Facter::Util::Resolution.which('/opt/puppetlabs/puppet/bin/dmidecode')
      physical_memory[:total_size] = Facter::Util::Resolution.exec('echo $(( $(( $(/opt/puppetlabs/puppet/bin/dmidecode -t 17| grep -Po \'(?<=Size: )[[:digit:]]+(?= MB)\' | paste -s -d+ -) ))/1024 + $(( $(/opt/puppetlabs/puppet/bin/dmidecode -t 17| grep -Po \'(?<=Size: )[[:digit:]]+(?= GB)\' | paste -s -d+ -) ))))GB') # rubocop:disable LineLength
    end
    physical_memory unless physical_memory.empty?
  end
end

Facter.add(:processors) do
  confine osfamily: 'RedHat'
  confine virtual: 'physical'
  setcode do
    processors = {}
    if Facter::Util::Resolution.which('/opt/puppetlabs/puppet/bin/dmidecode')
      processors[:cores] = Facter::Util::Resolution.exec('echo $(( $(/opt/puppetlabs/puppet/bin/dmidecode -t 4| grep -Po \'(?<=Core Count: )[[:digit:]]+\' | paste -s -d+ -) ))')
    end
    processors unless processors.empty?
  end
end
