def get_command_line_argument
  # ARGV is an array that Ruby defines for us,
  # which contains all the arguments we passed to it
  # when invoking the script from the command line.
  # https://docs.ruby-lang.org/en/2.4.0/ARGF.html
  if ARGV.empty?
    puts "Usage: ruby lookup.rb <domain>"
    exit
  end
  ARGV.first
end

# `domain` contains the domain name we have to look up.
domain = get_command_line_argument

# File.readlines reads a file and returns an
# array of string, where each element is a line
# https://www.rubydoc.info/stdlib/core/IO:readlines

dns_raw = File.readlines("zone")


def parse_dns(dns_raw)
  dns_rows = Hash.new
  dns_raw.each do |i|
    tokens = i.split(",")
    if tokens.length()==1
      next
    end
    if tokens[0].strip =="A" or tokens[0].strip =="CNAME"
      dns_rows[tokens[1].strip] ={"type"=>tokens[0].strip,"value"=>tokens[2].strip}
    end
  end
  return dns_rows
end

def resolve(dns_records, lookup_chain, domain)
  record = dns_records[domain]
  if record.nil?
    puts "Error: record not found for #{domain}"
    exit
  end
  lookup_chain.append(record["value"])
  if record["type"] == "A"
    return lookup_chain
  else
    resolve(dns_records,lookup_chain,record["value"])
  end
end

# To complete the assignment, implement `parse_dns` and `resolve`.
# Remember to implement them above this line since in Ruby
# you can invoke a function only after it is defined.

dns_records = parse_dns(dns_raw)
lookup_chain = [domain]
lookup_chain = resolve(dns_records, lookup_chain, domain)
puts lookup_chain.join(" => ")