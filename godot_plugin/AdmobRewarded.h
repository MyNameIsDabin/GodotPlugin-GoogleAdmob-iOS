#import "app_delegate.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <UIKit/UIKit.h>

@interface AdmobRewarded: NSObject <GADFullScreenContentDelegate> {
    int instanceId;
    NSMutableDictionary *rewardedIds;
    UIViewController *rootController;
}

- (void)initialize:(int)instance_id;
- (void)loadRewardedVideo:(NSString*)rewardedId;
- (void)showRewardedVideo:(NSString*)rewardedId;

@end
