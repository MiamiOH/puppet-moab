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
    tsm_nodes = {}
    if Facter::Util::Resolution.which('/opt/puppetlabs/puppet/bin/dmidecode')
      tsm_nodes[:total_size] = Facter::Util::Resolution.exec('echo $(( $(( $(/opt/puppetlabs/puppet/bin/dmidecode -t 17| grep -Po \'(?<=Size: )[[:digit:]]+(?= MB)\' | paste -s -d+ -) ))/1024 + $(( $(/opt/puppetlabs/puppet/bin/dmidecode -t 17| grep -Po \'(?<=Size: )[[:digit:]]+(?= GB)\' | paste -s -d+ -) ))))GB') # rubocop:disable LineLength
    end
    tsm_nodes unless tsm_nodes.empty?
  end
end
