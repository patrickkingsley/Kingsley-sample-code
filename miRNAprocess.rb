# This file is a ruby script designed to open an input file and extract all the miRNA gene names
# according to which targeting tool they matched. For example, if a gene was only find by the 
# targeting tool miranda, that gene will be included in the output file "miranda-only"
# miRNAprocess.rb Version 0.50
# Patrick M. Kingsley 2009
$miranda_count = 0
$pictar_count = 0
$targetscan_count = 0
$miranda_and_pictar_count = 0
$miranda_and_targetscan_count = 0
$pictar_and_targetscan_count = 0
$all_count = 0
$mirna_title = ""
$line_count = 0

# Create the output files
$miranda_only = Array.new
$pictar_only = Array.new
$targetscan_only = Array.new
$miranda_pictar = Array.new
$miranda_targetscan = Array.new
$pictar_targetscan = Array.new
$all = Array.new


File.open(ARGV[0],"r") do |file|
	# Process each line in the file
    while line = file.gets
      $line_count += 1
      next if line =~ /^$/ or line =~ /^#/ # Don't process if it's empty or comments
      fields = line.chomp.split(/\t/)
      next if fields[0] =~ /^miRNA/ # Skip if it's not data
      if $line_count == 3 then $mirna_title = fields[0] end
      # Miranda match
      if fields[7] == "1"
        $miranda_count += 1
        $miranda_only.push("#{fields[3]}\t#{fields[2]}\t#{fields[4]}")
      end
      # Pictar match
      if fields[11] == "1"
        $pictar_count += 1
        $pictar_only.push("#{fields[3]}\t#{fields[2]}\t#{fields[4]}")
      end
      # TargetScan match
      if fields[15] == "1"
        $targetscan_count += 1
        $targetscan_only.push("#{fields[3]}\t#{fields[2]}\t#{fields[4]}")
      end
      # Miranda/Pictar match
      if fields[7] == "1" and fields[11] == "1"
        $miranda_and_pictar_count += 1
        $miranda_pictar.push("#{fields[3]}\t#{fields[2]}\t#{fields[4]}")
      end
      # Miranda/TargetScan match
      if fields[7] == "1" and fields[15] == "1"
        $miranda_and_targetscan_count += 1
        $miranda_targetscan.push("#{fields[3]}\t#{fields[2]}\t#{fields[4]}")
      end
      # Pictar/TargetScan match
      if fields[11] == "1" and fields[15] == "1"
        $pictar_and_targetscan_count += 1
        $pictar_targetscan.push("#{fields[3]}\t#{fields[2]}\t#{fields[4]}")
      end
      # Miranda/Pictar/TargetScan match
      if fields[7] == "1" and fields[11] == "1" and fields[15] == "1"
        $all_count += 1
        $all.push("#{fields[3]}\t#{fields[2]}\t#{fields[4]}")
      end
    end
  end
  
  # Miranda Only Output
  if not $miranda_only.empty?
    miranda_only_file = File.new("miranda-only.txt","w")
    $miranda_only.each do |line|
      miranda_only_file.puts line
    end
    puts "New file created: miranda-only.txt"
  end
  
  # Pictar Only Output
  if not $pictar_only.empty?
    pictar_only_file = File.new("pictar-only.txt","w")
    $pictar_only.each do |line|
      pictar_only_file.puts line
    end
    puts "New file created: pictar-only.txt"
  end
    
  # Targetscan Only Output
  if not $targetscan_only.empty?
    targetscan_only_file = File.new("targetscan-only.txt","w")
    $targetscan_only.each do |line|
      targetscan_only_file.puts line
    end
    puts "New file created: targetscan-only.txt"
  end

  # Miranda/Pictar Output
  if not $miranda_pictar.empty?
    miranda_pictar_file = File.new("miranda-pictar.txt","w")
    $miranda_pictar.each do |line|
      miranda_pictar_file.puts line
    end
    puts "New file created: miranda-pictar.txt"
  end

  # Miranda/Targetscan Output
  if not $miranda_targetscan.empty?
    miranda_targetscan_file = File.new("miranda-targetscan.txt","w")
    $miranda_targetscan.each do |line|
      miranda_targetscan_file.puts line
    end
    puts "New file created: miranda-targetscan.txt"
  end

# Pictar/Targetscan Output
  if not $pictar_targetscan.empty?
    pictar_targetscan_file = File.new("pictar-targetscan.txt","w")
    $pictar_targetscan.each do |line|
      pictar_targetscan_file.puts line
    end
    puts "New file created: pictar-targetscan.txt"
  end

# All Three Output
  if not $all.empty?
    all_three_file = File.new("all-three.txt","w")
    $all.each do |line|
      all_three_file.puts line
    end
    puts "New file created: all-three.txt"
  end
  
# print out the summary Table
  puts "[Summary Data for #{$mirna_title}]"
  puts "Miranda matches: #{$miranda_count}"
  puts "Pictar matches: #{$pictar_count}"
  puts "TargetScan matches: #{$targetscan_count}"
  puts "Miranda/Pictar matches: #{$miranda_and_pictar_count}"
  puts "Miranda/TargetScan matches: #{$miranda_and_targetscan_count}"
  puts "Pictar/TargetScan matches: #{$pictar_and_targetscan_count}"
  puts "Miranda/Pictar/TargetScan matches: #{$all_count}"