
#run this file every hour
path = "/home/ec2-user/data/update"

current_date = Time.now.strftime("%d-%m-%Y-%H")

if File.exist?("#{path}/update-#{current_date}.xml")
  system "ruby cleanup_and_validate.rb #{path}/update-#{current_date}.xml"
  File.rename("#{path}/update-#{current_date}.xml", "#{path}/update-#{current_date}.xml")
  puts "Clean up Done!"

  if File.exist?("#{path}/update-#{current_date}-clean.xml")
    system "ruby run_mta.rb #{path}/update-#{current_date}-clean.xml"
    puts "MTA Done!"
    
    if File.exist?("#{path}/add-#{current_date}.json")
      system "ruby ingest.rb #{path}/add-#{current_date}.json"
      puts "Ingest Done!"
    end
  end    
end

