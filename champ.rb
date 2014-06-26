#League of Legends Log Analyzer
#Written in Ruby 1.9.3
#Written by qoire June 26, 2014

# @Input: League of Legends R3D (Client) Logss
# @Output: Outputfile containing User (you) champion statistics

require 'yaml' # Script uses yaml for saving (for human readability)

$LOG_LIST = []

def read_file(file_name)
	File.open(file_name, "r") do |f|
		i = 0
		f.each_line do |line|
			i += 1
			puts "%d : %s" % [i, line]
		end
	end
end


# main
Dir.entries("./Game - R3d Logs").each do |item|
	if item =~ /.txt$/
		$LOG_LIST << item
	end
end

# change directory
Dir.chdir("./Game - R3d Logs") do
	$LOG_LIST.each do |x|
		puts x
		read_file(x)
	end
end
