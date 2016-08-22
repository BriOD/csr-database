module IP
  extend ActiveSupport::Concern

  # IP Class Methods
  module ClassMethods
    def ip2long(ip)
      long = 0
      ip.split(/\./).each_with_index do |b, i|
        long += b.to_i << (8 * i)
      end
      long
    end

    def long2ip(long)
      ip = []
      4.times do
        ip.push(long.to_i & 255)
        long = long.to_i >> 8
      end
      ip.join('.')
    end

    def cidr_to_netmask(cidr)
      IPAddr.new('255.255.255.255').mask(cidr).to_s
    end

    def netmask_to_cidr(netmask)
      IPAddr.new(netmask).to_i.to_s(2).count('1')
    end
  end
end
