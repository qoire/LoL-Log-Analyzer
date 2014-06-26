#League of Legends Log Analyzer
#Written in Ruby 1.9.3
#Written by qoire June 26, 2014

# @Input: League of Legends R3D (Client) Logss
# @Output: Outputfile containing User (you) champion statistics

require 'yaml' # Script uses yaml for saving (for human readability)

$LOG_LIST = []
$CHAMP_HASH = {}
$SUMMONER_NAME = []


def read_file(file_name)
    File.open(file_name, "r") do |f|
        i = 0
        f.each_line do |line|
            #i += 1
            #puts "%d : %s" % [i, line]
            $SUMMONER_NAME.each do |a|
                if line =~ /created for #{a}/
                    hero_name = /Hero\s(\w+)/.match(line)[1]
                    puts hero_name
                    if $CHAMP_HASH[:champs].key?(hero_name.to_sym)
                        $CHAMP_HASH[:champs][hero_name.to_sym] += 1
                    elsif
                        $CHAMP_HASH[:champs][hero_name.to_sym] = 1
                    end
                end
            end
        end
    end
end


# MAIN ************************************************
ARGV.each do |a|
    $SUMMONER_NAME << a
end

# set up hash
$CHAMP_HASH.merge!(summoner: $SUMMONER_NAME.last)
$CHAMP_HASH.merge!(champs: {})

if not $SUMMONER_NAME
    puts "Script Requires your summoner name (IGN)"
    exit
end

Dir.entries("./Game - R3d Logs").each do |item|
    if item =~ /.txt$/
        $LOG_LIST << item
    end
end

# change directory
Dir.chdir("./Game - R3d Logs") do
    $LOG_LIST.each do |x|
        read_file(x)
    end
end

# sort the hash properly
$CHAMP_HASH[:champs] = Hash[$CHAMP_HASH[:champs].sort_by { |k, v| v}.reverse]

# open output to yaml file
File.open("champs.yml", "w") do |f|
    f.write($CHAMP_HASH.to_yaml)
end