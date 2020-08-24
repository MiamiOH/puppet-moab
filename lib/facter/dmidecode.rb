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
  confine :kernel => 'Linux'
  confine :virtual => 'physical'
  setcode do
    physical_memory = {}
    if Facter::Util::Resolution.which('/opt/puppetlabs/puppet/bin/dmidecode')
      physical_memory[:total_size] = Facter::Util::Resolution.exec('echo $(( $(( $(/opt/puppetlabs/puppet/bin/dmidecode -t 17| grep -Po \'(?<=Size: )[[:digit:]]+(?= MB)\' | paste -s -d+ -) ))/1024 + $(( $(/opt/puppetlabs/puppet/bin/dmidecode -t 17| grep -Po \'(?<=Size: )[[:digit:]]+(?= GB)\' | paste -s -d+ -) ))))GB') # rubocop:disable LineLength
    end
    physical_memory unless physical_memory.empty?
  end
end

Facter.add(:torque) do
  confine :kernel => 'Linux'
  confine :virtual => 'physical'
  confine { Facter::Core::Execution.which('pbsnodes') }
  setcode do
    result = {}
    if Facter::Util::Resolution.which('/opt/puppetlabs/puppet/bin/dmidecode')
      result[:cpucores] = Facter::Util::Resolution.exec('echo $(( $(/opt/puppetlabs/puppet/bin/dmidecode -t 4| grep -Po \'(?<=Core Count: )[[:digit:]]+\' | paste -s -d+ -) ))')
    end
    result
  end
end