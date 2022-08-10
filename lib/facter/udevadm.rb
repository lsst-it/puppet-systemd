# frozen_string_literal: true

# Fact: udevadm
#
# Purpose:
#   Provide information about the udevadm utilty.
#
# Resolution:
#   Check if the kernel is linux.
#
# Caveats:
#
Facter.add(:udevadm) do
  confine kernel: :linux

  setcode do
    path = Facter::Core::Execution.which('udevadm')
    return nil if path.nil?

    {
      path: path,
      version: Facter::Core::Execution.exec('udevadm --version')
    }
  end
end
