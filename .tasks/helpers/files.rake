require 'find'

def get_files(label, files_path, regex)
  results = []
  puts "\n\nChecking #{label} files in '#{files_path}' for valid content\n\n"
  Find.find(files_path) do |path|
    if path =~ regex
      puts "Found #{label} file: #{path}"
      results << path
    end
  end
  puts "\nFound #{results.length} #{label} file#{results.length > 1 ? 's' : ''}\n\n"
  results
end

def process_files(files, callback, *callback_args)
  onError = 0
  files.each do |file|
    raw_content = File.read(file)
    begin
      send(callback, raw_content, *callback_args)
    rescue JSON::ParserError => e
      onError += 1
      puts "Invalid JSON content in file: #{file}"
      puts "#{e.message}\n\n"
    rescue StandardError => e
      onError += 1
      puts "Error processing file: #{file}"
      puts "#{e.message}\n\n"
    end
  end
  puts "\nFinished: Found #{onError} files with invalid content\n\n"
  onError
end
