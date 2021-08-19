//
//  WZMChatUserModel.m
//  WZMChat
//
//  Created by WangZhaomeng on 2019/4/24.
//  Copyright © 2019 WangZhaomeng. All rights reserved.
//

#import "WZMChatUserModel.h"

@implementation WZMChatUserModel

///默认登录用户
+ (instancetype)shareInfo {
    static WZMChatUserModel *userInfo;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo = [[WZMChatUserModel alloc] init];
        userInfo.uid = @"00001";
        userInfo.name = @"ios dev";
        userInfo.avatar = [self randomicon];
    });
    return userInfo;
}

+(NSString *)randomicon {
    NSArray *list = @[
    @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn13%2F480%2Fw640h640%2F20180927%2F8a6a-hkmwytp4465696.jpg&refer=http%3A%2F%2Fn.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631972535&t=88e54fc7f5dc389f2e810b57f2e878f8",
    @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01a6f15c4d4dc2a801213f26f31b4a.jpg%402o.jpg&refer=http%3A%2F%2Fimg.zcool.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631972535&t=c1281a9090c4b5cde3f7c829aa682358",
    @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fitem%2F201912%2F21%2F20191221173509_wjdru.thumb.700_0.jpg&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631972535&t=84d3531fa6bdd3bc4d38cf1962bb0419",
    @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fitem%2F201711%2F14%2F20171114235359_xTrZ2.thumb.700_0.jpeg&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631972535&t=9211b5e3cf956b4a34cc7db352a7637a",
    @"xhttps://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201508%2F24%2F20150824161927_X8U23.jpeg&refer=http%3A%2F%2Fb-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631972535&t=3dc7d0bc26c8fda7369e3475a48a7af4",
    @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0183bc5c4d4db8a801203d22ce7303.jpg%401280w_1l_2o_100sh.jpg&refer=http%3A%2F%2Fimg.zcool.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631972535&t=ecd75c3b44adfa35a8e49522fec5420d"
    ];
    
    return list[arc4random() % list.count];
}

@end
