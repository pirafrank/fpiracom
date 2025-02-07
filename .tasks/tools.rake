namespace :tools do
  desc "Show size of all post images"
  task :sizes do
    sh 'find static/postimages -type f \( -iname "*.jpeg" -o -iname "*.jpg" -o -iname "*.png" \) -exec identify -format "%[fx:w]x%[fx:h] %[f]\n" {} \; | awk \'{print $1, $2}\' | sort -n | uniq'
  end

  desc "Check the oldest GLIBC version required by nokogiri"
  task :nokogiri do
    sh "objdump -T $(find $(dirname $(gem which nokogiri)) -type f -iname '*.so' | grep /nokogiri/$(ruby -v | cut -d ' ' -f2 | cut -d'.' -f1,2)) | grep GLIBC_ | sort -V | tail -n1"
  end
end
