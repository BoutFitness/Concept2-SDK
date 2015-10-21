Pod::Spec.new do |s|
  s.name              = "Concept2-SDK"
  s.version           = "0.1.0"
  s.summary           = "Library for connecting to the Concept2 PM5 via Bluetooth."
  s.description       = <<-DESC
                         Library for connecting to the Concept2 PM5 via Bluetooth. The goal of this
                         library is to provide complete coverage of the bluetooth functionality.
                        DESC

  s.homepage          = "https://github.com/BoutFitness/Concept2-SDK"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license           = 'MIT'
  s.author            = { "jessecurry" => "jesse@jessecurry.net" }
  s.source            = { :git => "https://github.com/BoutFitness/Concept2-SDK.git", :tag => s.version.to_s }
  s.social_media_url  = 'https://twitter.com/boutfitness'

  s.platforms         = { :ios => '9.0', :osx => '10.10' }
  s.requires_arc      = true

  s.source_files      = 'Pod/Classes/**/*'
  # s.resource_bundles = {
  #   'Concept2-SDK' => ['Pod/Assets/*.png']
  # }

  s.module_name       = 'Concept2_SDK'
  s.frameworks        = 'CoreBluetooth'
  # s.dependency 'AFNetworking', '~> 2.3'
end
