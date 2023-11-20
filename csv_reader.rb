require "csv"
require "byebug"
require 'open-uri'
require 'nokogiri'
require 'json'

# Replace "file.csv" with the actual path to your CSV file
file_path = "/path/to/file.csv"
# Replace "https://some.url.com/" with the actual URL you want to check for
included_url = "https://some.url.com/"

extracted_rows = []
final_rows = []
quote_chars = %w(' " | ~ ^ & * ` : \ /)

csv_file = CSV.open(file_path, :headers => true, :force_quotes => true, :encoding => "bom|utf-8", :quote_char => quote_chars.shift)
loop do
  begin
    row = csv_file.shift
    break unless row

    key_value = row[0]
    id_value = row[1]
    attachment1_value = row[2].to_s
    attachment2_value = row[3].to_s
    attachment3_value = row[4].to_s
    attachment4_value = row[5].to_s
    attachment5_value = row[6].to_s
    attachment6_value = row[7].to_s
    attachment7_value = row[8].to_s
    attachment8_value = row[9].to_s
    attachment9_value = row[10].to_s

    next if attachment1_value.nil?

    extracted_rows << [
      key_value,
      id_value,
      attachment1_value.include?(included_url) ? attachment1_value.gsub('"', "") : "",
      attachment2_value.include?(included_url) ? attachment2_value.gsub('"', "") : "",
      attachment3_value ? attachment3_value.gsub('"', "") : "",
      attachment4_value.include?(included_url) ? attachment4_value.gsub('"', "") : "",
      attachment5_value.include?(included_url) ? attachment5_value.gsub('"', "") : "",
      attachment6_value.include?(included_url) ? attachment6_value.gsub('"', "") : "",
      attachment7_value ? attachment7_value.gsub('"', "") : "",
      attachment8_value.include?(included_url) ? attachment8_value.gsub('"', "") : "",
      attachment9_value.include?(included_url) ? attachment9_value.gsub('"', "") : "",
    ]
  rescue CSV::MalformedCSVError
    puts "skipping bad row"
  end
end

extracted_rows.each do |row|
  row = row.reject { |c| c.empty? }

  next if row.size == 2

  final_rows << {
    issue_key: row[0].gsub('"', ""),
    issue_id: row[1].gsub('"', ""),
    attachments: row[2..-1]
  }
end

puts JSON.dump(final_rows)
