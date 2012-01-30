module Custodian
  module Samplers

    class CPU < Custodian::Samplers::Sampler
      describe "CPU usage"

      def self.sample
        top = `top -b -n1`.match /Cpu\(s\): +([0-9.]+)%us, +([0-9.]+)%sy, +([0-9.%]+)ni, +([0-9.]+)%id, +([0-9.]+)%wa, +([0-9.]+)%hi, +([0-9.]+)%si, +([0-9.]+)%st/

        us = top[1].to_f # User CPU time: The time the CPU has spent running users' processes that are not niced.
        sy = top[2].to_f # System CPU time: The time the CPU has spent running the kernel and its processes.
        ni = top[3].to_f # Nice CPU time: The time the CPU has spent running users' proccess that have been niced.
        id = top[4].to_f # Hardware IRQ: The amount of time the CPU has been servicing hardware interrupts.
        wa = top[5].to_f # iowait: Amount of time the CPU has been waiting for I/O to complete.
        hi = top[6].to_f # Hardware IRQ: The amount of time the CPU has been servicing hardware interrupts.
        si = top[7].to_f # Hardware Interrupts: The amount of time the CPU has been servicing software interrupts.
        st = top[8].to_f # Steal Time: The amount of CPU 'stolen' from this virtual machine by the hypervisor for other tasks.

        {
          "User"   => "#{us + ni}%",
          "System" => "#{sy + wa + hi + si + st}%",
          "Idle"   => "#{id}%"
        }
      end
    end

  end
end

