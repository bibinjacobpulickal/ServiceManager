Pod::Spec.new do |spec|

spec.name         = "ServiceManager"
spec.version      = "1.1.0"
spec.summary      = "Lightweight, Enumerated and Protocol Oriented Networking Module written in swift 5.0."

spec.description  = "Lightweight, Enumerated and Protocol Oriented Networking Module written in swift 5.0. ServiceManager helps reduce networking code in view controllers and presenters."

spec.homepage     = "https://github.com/bibinjacobpulickal/ServiceManager"

spec.license      = "MIT"

spec.author             = { "Bibin Jacob Pulickal" => "bibinjacob123@gmail.com" }
spec.social_media_url   = "https://github.com/bibinjacobpulickal"

spec.ios.deployment_target     = '9.0'
spec.osx.deployment_target     = '10.11'

spec.source       = { :git => "https://github.com/bibinjacobpulickal/ServiceManager.git", :tag => "1.1.0" }

spec.source_files  = "ServiceManager/**/*.{h,m,swift}"

spec.swift_version = ['3.0', '4.0', '4.2', '5.0']

end
