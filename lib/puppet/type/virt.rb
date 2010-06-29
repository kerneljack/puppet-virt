module Puppet
	newtype(:virt) do
		@doc = "Create a new xen or kvm guest"
	
		newparam(:desc) do
			desc "The VM description."
		end
	
		newparam(:name, :namevar => true) do
			desc "The virtual machine name."
		end


		ensurable do
			desc "One of \"running\", \"installed\", \"stopped\" or \"absent\".
			     - running:
			         Creates config file, and makes sure the domU is running.
			     - installed:
			         Creates config file, but doesn't touch the state of the domU.
			     - stopped:
			         Creates config file, and makes sure the domU is not running.
			     - absent:
			         Removes config file, and makes sure the domU is not running."
		
			defaultvalues

			newvalue(:installed) do # == :present
				provider.create
			end
	
			newvalue(:stopped) do
			end
	
			newvalue(:running) do
			end
	
			aliasvalue(:false, :stopped)
			aliasvalue(:true, :installed)
			aliasvalue(:running, :installed)
			aliasvalue(:installed, :running)
			aliasvalue(:stopped, :installed)

			defaultto(:stopped)
			
			def retrieve
				provider.status
			end
	
		end
	
		newparam(:memory) do
			desc "The amount of memory reserved for the virtual machine.
			      Specified in MB and is changeable."
		end
	
		newparam(:cpus) do
			desc "Changeable"
		end
	
		newparam(:arch) do
			desc "Not Changeable"
		end
	
		newparam(:clocksync) do
			desc ""
		end
	
		newparam(:boot_kernel) do
			desc ""
		end
	
		newparam(:boot_initrd) do
			desc ""
		end
	
		newparam(:boot_options) do
			desc ""
		end
	
		newparam(:virt_path) do
			desc "Path to .img file"
		end
	
		newparam(:disk_size) do
			desc "Not changeable."
		end
	
		newparam(:os_type) do
			desc "Not changable."
	
			newvalues(:linux, :windows, :unix, :solaris, :other)
		end
	
		newparam(:os_variant) do
			desc ""
		end

		newparam(:virt_type) do
			desc "Mandatory field"
			newvalues(:kvm, :xen_fullyvirt, :xen_paravirt) 
#			defaultto(:xen_paravirt)
		end
		
		newparam(:interfaces) do
			desc "Network interface(s)  bridge"
		end
	
		newparam(:on_poweroff) do
			desc ""
			newvalues(:destroy, :restart, :preserv, :renamerestart)
			defaultto(:destroy)
		end
	
		newparam(:on_reboot) do
			desc ""
			newvalues(:destroy, :restart, :preserv, :renamerestart)
			defaultto(:preserv)
		end
	
		newparam(:on_crash) do
			desc ""
			newvalues(:destroy, :restart, :preserv, :renamerestart)
			defaultto(:restart)
		end
		
		newparam(:autoboot) do
			desc ""
			newvalues(:true, :false)
			defaultto(:true)
		end
	end
end
