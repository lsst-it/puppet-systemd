# frozen_string_literal: true

require 'spec_helper'

describe 'udev fact', type: :fact do
  subject(:fact) { Facter.fact(:udev) }

  before { Facter.clear }

  context 'when kernel is linux and udevadm is present' do
    before do
      allow(Facter.fact(:kernel)).to receive(:value).and_return(:linux)
      allow(Facter.fact(:udevadm)).to receive(:value).and_return('path' => '/foo')
      allow(Facter::Core::Execution).to receive(:exec).with('/foo info -e').and_return(
        File.read(fixtures('udevdb', udevdb_fixture))
      )
    end

    context 'centos8-supermicro-1114S-WN10RT' do
      let(:udevdb_fixture) { 'centos8-supermicro-1114S-WN10RT.txt' }

      it do
        expect(fact.value).to include(
          'nvme0n1' => include(
            'name'     => 'nvme0n1',
            'path'     => '/devices/pci0000:c0/0000:c0:01.1/0000:c1:00.0/nvme/nvme0/nvme0n1',
            'symlink'  => include(
              'disk/by-id/nvme-SAMSUNG_MZQLB1T9HAJR-00007_S439NC0R803379'
            ),
            'property' => include(
              'DEVLINKS'  => %w[/dev/disk/by-id/nvme-eui.34333930528033790025384300000001 /dev/disk/by-id/nvme-SAMSUNG_MZQLB1T9HAJR-00007_S439NC0R803379 /dev/disk/by-path/pci-0000:c1:00.0-nvme-1],
              'DEVNAME'   => '/dev/nvme0n1',
              'ID_SERIAL' => 'SAMSUNG MZQLB1T9HAJR-00007_S439NC0R803379'
            )
          )
        )
      end

      it do
        expect(fact.value).to include(
          'nvme1n1' => include(
            'name'     => 'nvme1n1',
            'path'     => '/devices/pci0000:c0/0000:c0:01.2/0000:c2:00.0/nvme/nvme1/nvme1n1',
            'symlink'  => include(
              'disk/by-id/nvme-SAMSUNG_MZQLB1T9HAJR-00007_S439NC0R803393'
            ),
            'property' => include(
              'DEVLINKS'  => %w[/dev/disk/by-id/nvme-eui.34333930528033930025384300000001 /dev/disk/by-path/pci-0000:c2:00.0-nvme-1 /dev/disk/by-id/nvme-SAMSUNG_MZQLB1T9HAJR-00007_S439NC0R803393],
              'DEVNAME'   => '/dev/nvme1n1',
              'ID_SERIAL' => 'SAMSUNG MZQLB1T9HAJR-00007_S439NC0R803393'
            )
          )
        )
      end

      it do
        expect(fact.value).to include(
          'nvme2n1' => include(
            'name'     => 'nvme2n1',
            'path'     => '/devices/pci0000:40/0000:40:03.6/0000:49:00.0/nvme/nvme2/nvme2n1',
            'symlink'  => include(
              'disk/by-id/nvme-SAMSUNG_MZ1LB960HAJQ-00007_S435NC0T201885'
            ),
            'property' => include(
              'DEVLINKS'  => %w[/dev/disk/by-id/nvme-eui.34333530542018850025384300000001 /dev/disk/by-id/nvme-SAMSUNG_MZ1LB960HAJQ-00007_S435NC0T201885 /dev/disk/by-path/pci-0000:49:00.0-nvme-1],
              'DEVNAME'   => '/dev/nvme2n1',
              'ID_SERIAL' => 'SAMSUNG MZ1LB960HAJQ-00007_S435NC0T201885'
            )
          )
        )
      end
    end

    context 'centos7-supermicro-1114S-WN10RT' do
      let(:udevdb_fixture) { 'centos7-supermicro-1114S-WN10RT.txt' }

      it do
        expect(fact.value).to include(
          'nvme0n1' => include(
            'name'     => 'nvme0n1',
            'path'     => '/devices/pci0000:c0/0000:c0:01.1/0000:c1:00.0/nvme/nvme0/nvme0n1',
            'symlink'  => include(
              'disk/by-id/nvme-Samsung_SSD_983_DCT_1.92TB_S48BNG0MB01692Z'
            ),
            'property' => include(
              'DEVLINKS' => %w[/dev/disk/by-id/nvme-Samsung_SSD_983_DCT_1.92TB_S48BNG0MB01692Z /dev/disk/by-id/nvme-eui.343842304db016920025384700000001 /dev/disk/by-path/pci-0000:c1:00.0-nvme-1],
              'DEVNAME' => '/dev/nvme0n1',
              'ID_SERIAL' => 'Samsung SSD 983 DCT 1.92TB_S48BNG0MB01692Z'
            )
          )
        )
      end

      it do
        expect(fact.value).to include(
          'nvme1n1' => include(
            'name'     => 'nvme1n1',
            'path'     => '/devices/pci0000:c0/0000:c0:01.2/0000:c2:00.0/nvme/nvme1/nvme1n1',
            'symlink'  => include(
              'disk/by-id/nvme-Samsung_SSD_983_DCT_1.92TB_S48BNG0MB01685F'
            ),
            'property' => include(
              'DEVLINKS'  => %w[/dev/disk/by-id/lvm-pv-uuid-9xd8Cv-b2ix-Po6i-beCm-dJ73-W9Tc-kRWDht /dev/disk/by-id/nvme-Samsung_SSD_983_DCT_1.92TB_S48BNG0MB01685F /dev/disk/by-id/nvme-eui.343842304db016850025384700000001 /dev/disk/by-path/pci-0000:c2:00.0-nvme-1],
              'DEVNAME'   => '/dev/nvme1n1',
              'ID_SERIAL' => 'Samsung SSD 983 DCT 1.92TB_S48BNG0MB01685F'
            )
          )
        )
      end

      it do
        expect(fact.value).to include(
          'nvme2n1' => include(
            'name'     => 'nvme2n1',
            'path'     => '/devices/pci0000:c0/0000:c0:01.3/0000:c3:00.0/nvme/nvme2/nvme2n1',
            'symlink'  => include(
              'disk/by-id/nvme-SAMSUNG_MZQLB1T9HAJR-00007_S439NC0RA01816'
            ),
            'property' => include(
              'DEVLINKS'  => %w[/dev/disk/by-id/lvm-pv-uuid-BURjmT-eLdd-RzoT-xJQm-z4lJ-zkkk-otZ7MT /dev/disk/by-id/nvme-SAMSUNG_MZQLB1T9HAJR-00007_S439NC0RA01816 /dev/disk/by-id/nvme-eui.3433393052a018160025384300000001 /dev/disk/by-path/pci-0000:c3:00.0-nvme-1],
              'DEVNAME'   => '/dev/nvme2n1',
              'ID_SERIAL' => 'SAMSUNG MZQLB1T9HAJR-00007_S439NC0RA01816'
            )
          )
        )
      end

      it do
        expect(fact.value).to include(
          'nvme3n1' => include(
            'name'     => 'nvme3n1',
            'path'     => '/devices/pci0000:40/0000:40:03.6/0000:49:00.0/nvme/nvme3/nvme3n1',
            'symlink'  => include(
              'disk/by-id/nvme-Samsung_SSD_980_PRO_500GB_S5NYNG0NA00569R'
            ),
            'property' => include(
              'DEVLINKS'  => %w[/dev/disk/by-id/nvme-Samsung_SSD_980_PRO_500GB_S5NYNG0NA00569R /dev/disk/by-id/nvme-eui.002538ba01501163 /dev/disk/by-path/pci-0000:49:00.0-nvme-1],
              'DEVNAME'   => '/dev/nvme3n1',
              'ID_SERIAL' => 'Samsung SSD 980 PRO 500GB_S5NYNG0NA00569R'
            )
          )
        )
      end
    end
  end

  context 'when udevadm is not present' do
    before do
      allow(Facter.fact(:kernel)).to receive(:value).and_return(:linux)
      allow(Facter.fact(:udevadm)).to receive(:value).and_return(false)
    end

    it { expect(fact.value).to be_nil }
  end

  context 'when kernel is not linux' do
    before do
      allow(Facter.fact(:kernel)).to receive(:value).and_return(:windows)
    end

    it { expect(fact.value).to be_nil }
  end
end
