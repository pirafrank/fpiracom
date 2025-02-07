namespace :docker do

  desc "build a general purpose Jekyll Docker image to run the website"
  task :build do
    sh "docker build -t pirafrank/jekyll -f Dockerfile ."
  end

end
