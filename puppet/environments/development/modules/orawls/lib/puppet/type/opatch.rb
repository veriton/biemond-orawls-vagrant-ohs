module Puppet
  Type.newtype(:opatch) do
    desc 'This is the Oracle Patch process called OPatch'

    newproperty(:ensure) do
      desc 'Whether a patch should be applied.'

      newvalue(:present, :event => :opatch_installed) do
        provider.present
      end

      newvalue(:absent, :event => :opatch_absent) do
        provider.absent
      end

      aliasvalue(:installed, :present)
      aliasvalue(:purged, :absent)

      def retrieve
        provider.status
      end

      def sync
        event = super()
        # rubocop:disable all
        if property = @resource.property(:enable)
          val = property.retrieve
          property.sync unless property.safe_insync?(val)
        end
        # rubocop:enable all
        event
      end

    end

    newparam(:name) do
      desc <<-EOT
        The name of the OPatch.
      EOT
      isnamevar
    end
    
    newparam(:patch_id) do
      desc <<-EOT
        The patchId of the OPatch.
      EOT
    end
    
    newparam(:os_user) do
      desc <<-EOT
        The weblogic operating system user.
      EOT
    end

    newparam(:oracle_product_home_dir) do
      desc <<-EOT
        The oracle product home folder.
      EOT
    end

    newparam(:jdk_home_dir) do
      desc <<-EOT
        The JDK home folder.
      EOT
    end

    newparam(:orainst_dir) do
      desc <<-EOT
        The orainst folder.
      EOT
    end

    newparam(:extracted_patch_dir) do
      desc <<-EOT
        The extracted patch folder.
      EOT
    end

  end
end
