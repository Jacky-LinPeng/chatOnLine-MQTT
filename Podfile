platform :ios, '9.0'

## ignore warning
inhibit_all_warnings!

target 'WZMChatUI' do
  
  # 网络请求工具
  pod 'AFNetworking'
  
  # AutoLayout
  pod 'Masonry'

  # 加载提示框
  pod 'MBProgressHUD'
  
  # 数据模型
  pod 'YYModel'

  # KVO
  pod 'KVOController'
  
  # 网络图片展示
  pod 'SDWebImage', '~> 5.6.0'
 
  
  # XPYKit
  pod 'XPYKit', :git => 'https://github.com/xiangxiaopenyou/XPYKit.git'
  
  # 环信MQTT
  pod 'MQTTClient'
  
  # 消除版本警告
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 9.0
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
        end
      end
    end
  end
end
