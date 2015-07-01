platform :ios, '7.1'
inhibit_all_warnings!

source 'https://github.com/CocoaPods/Specs.git'

pod 'RestKit'
pod 'AFNetworking', '< 2.0'
pod 'SVProgressHUD'
pod 'MagicalRecord'
pod 'SDWebImage'

post_install do |installer|
    installer.project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ARCHS'] = "armv7 armv7s arm64 i386 x86_64"
            config.build_settings['ONLY_ACTIVE_ARCH'] = "NO"
        end
    end
end
