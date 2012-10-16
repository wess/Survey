Pod::Spec.new do |s|
  s.name         = "Survey"
  s.version      = "0.0.1"
  s.summary      = "A short description of Survey."
  s.homepage     = "http://github.com/wess/Survey"
  s.license      = 'MIT'
  s.author       = { "Wess Cope" => "wcope@me.com" }
  s.source       = { :git => "https://github.com/wess/Survey.git", :tag => "0.0.1" }
  s.source_files = 'Classes', 'Classes/**/*.{h,m}'
end
