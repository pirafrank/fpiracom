namespace :api do
  desc "Lint OpenAPI definitions"
  task :lint do
    sh "redocly lint --config redocly.yaml api/v1/openapi.yaml"
  end

  desc "Cleanup OpenAPI definitions"
  task :clean do
    sh <<~SHELL
      rm -rf api/docs/openapi/index.html
      rm -rf api/docs/openapi/.openapi-generator
      rm -rf api/docs/openapi/.openapi-generator-ignore
      rm -rf _temp_postman
    SHELL
  end

  desc "Generate OpenAPI documentation website"
  task :generate_html => 'api:clean' do
    sh "openapi-generator-cli generate -i api/v1/openapi.yaml -g html2 -o api/docs/openapi"
  end

  desc "Generate Postman collection"
  task :generate_postman => 'api:clean' do
    sh <<~SHELL
      openapi-generator-cli generate -i api/v1/openapi.yaml -g postman-collection -o _temp_postman
      mv _temp_postman/postman.json postman.json
      rm -rf _temp_postman
    SHELL
  end
end
