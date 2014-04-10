
desc 'removes all files from public/uploads/'
task :dump_uploads do
  puts "Rails environment is currently in #{Rails.env}"

  unless Rails.env == 'development'
    puts "Aborted. Task is only available in development."
    exit!
  end

  path = Rails.root.join('public', 'uploads', '*')
  puts "Removing all files from #{path.to_s}..."
  exec "rm -fr #{path.to_s}"
end
