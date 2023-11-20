# filename: rename_files_script.rb

require 'json'
require 'fileutils'
require 'byebug'

def rename_files(data, folder_path)
  issue_key = data['issue_key'].gsub("-","_")
  attachments = data['attachments'].reject {|a| a.include?("https://oferus.atlassian")}

  attachments.each_with_index do |attachment, index|
    old_path = File.join(folder_path, attachment)
    new_name = if attachments.length > 1
                 "#{issue_key}_#{index + 1}"
               else
                 issue_key
               end
    new_path = File.join(folder_path, new_name)

    rename_file(old_path, new_path)
  end
end

def rename_file(old_path, new_path)
  begin
    FileUtils.mv(old_path, new_path)
  rescue StandardError => e
    puts "Error renaming file #{old_path} to #{new_path}: #{e.message}"
  end
end

def rename_files_from_file(file_path, folder_path)
  data = JSON.parse(File.read(file_path))

  data.each do |entry|
    rename_files(entry, folder_path)
  end
end

if ARGV.length < 2
  puts "Usage: ruby rename_files_script.rb <data_file_path> <folder_path>"
  exit(1)
end

file_path = ARGV[0]
folder_path = ARGV[1]

rename_files_from_file(file_path, folder_path)
