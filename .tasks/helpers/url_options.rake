require 'html-proofer'

def check_urls(content, disable_external_url_check = false)
  check_urls_options = {
    :allow_hash_href => true,
    :allow_missing_href => true,
    :ignore_empty_alt => true,
    :ignore_missing_alt => true,
    :assume_extension => '.html',
    :checks => ['Links', 'Images', 'Scripts'],
    :check_external_hash => true,
    :check_internal_hash => true,
    :directory_index_file => 'index.html',
    :enforce_https => true,
    :ignore_empty_mailto => true,  # because of sharing-buttons.html
    :ignore_files => [
      # skip very old blog posts
      %r{^_site\/blog\/201\d{1}\/.*\/index.html$},
      # version may point to something not yet pushed, failing the check
      "_site/version/index.html",
      "_site/api/docs/openapi/index.html",
    ],
    :ignore_urls => [
      %r{^https://matrix.to/.*$},
    ],
    :ignore_status_codes => [
      401,
      403,
      999
    ],
    :only_4xx => false,
    :hydra => {
      :max_concurrency => 50
    },
    :typhoeus => {
      :headers => {
        "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36"
      },
      :followlocation => true,
      :connecttimeout => 10,
      :timeout => 30,
      :ssl_verifyhost => 2,
      :ssl_verifypeer => true
    },
    :cache => {
      :timeframe => {
        :external => "2w",
        :internal => "1d"
      },
      :storage_dir => ".html_proofer_cache",
      :cache_file => "cache.json"
    }
  }

  options = check_urls_options
  options[:disable_external] = disable_external_url_check
  HTMLProofer.check_directory(content, options).run
end
