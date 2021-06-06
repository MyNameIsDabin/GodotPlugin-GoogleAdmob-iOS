#import "AdmobRewarded.h"
#include "reference.h"

@implementation AdmobRewarded

- (void)initialize:(int)instance_id {
    rewardedIds = [[NSMutableDictionary alloc]init];
    rootController = [UIApplication sharedApplication].keyWindow.rootViewController;
    instanceId = instance_id;
}

- (void)loadRewardedVideo:(NSString*) rewardedId {
    GADRequest *request = [GADRequest request];
    Object *obj = ObjectDB::get_instance(instanceId);
    NSMutableDictionary* _rewardedIds = rewardedIds;
    [GADRewardedAd loadWithAdUnitID:rewardedId
                            request:request
                  completionHandler:^(GADRewardedAd *ad, NSError *error) {
        if (error) {
            NSLog(@"Rewarded ad failed to load with error: %@", [error localizedDescription]);
            obj->call_deferred("_on_rewarded_video_ad_failed_to_load", (int)error.code);
            return;
            
        } else {
            NSLog(@"Loading Succeeded: %@", rewardedId);
            obj->call_deferred("_on_rewarded_video_ad_loaded");
            ad.fullScreenContentDelegate = self;
            [_rewardedIds setObject:ad forKey:rewardedId];
        }
    }];
}

- (void) showRewardedVideo:(NSString*) rewardedId {
    GADRewardedAd* rewardedAd = [rewardedIds objectForKey:rewardedId];
    Object *obj = ObjectDB::get_instance(instanceId);
    if (rewardedAd) {
        NSLog(@"Calling showRewardedVideo");
        [rewardedAd presentFromRootViewController:rootController
                         userDidEarnRewardHandler:^{
            GADAdReward *reward = rewardedAd.adReward;
            NSString *reqPlayedID = rewardedAd.adUnitID;
            NSString *rewardMessage = [NSString stringWithFormat:@"Reward received with currency %@ , amount %lf , id %@", reward.type, [reward.amount doubleValue], reqPlayedID];
            NSLog(@"%@", rewardMessage);
            obj->call_deferred("_on_rewarded", [reward.type UTF8String], reward.amount.doubleValue, [reqPlayedID UTF8String]);
        }];
    } else {
      NSLog(@"Ad wasn't ready");
    }
}

/// Tells the delegate that the ad failed to present full screen content.
- (void)ad:(nonnull id<GADFullScreenPresentingAd>)ad didFailToPresentFullScreenContentWithError:(nonnull NSError *)error {
    NSLog(@"Ad did fail to present full screen content.");
    Object *obj = ObjectDB::get_instance(instanceId);
    obj->call_deferred("_on_rewarded_video_ad_failed_to_load", (int)error.code);
}

/// Tells the delegate that the ad presented full screen content.
- (void)adDidPresentFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    NSLog(@"rewardedAdDidPresent");
}

/// Tells the delegate that the ad dismissed full screen content.
- (void)adDidDismissFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    NSLog(@"Ad did dismiss full screen content.");
    GADRewardedAd* _rewardedAd = (GADRewardedAd*)ad;
    [self loadRewardedVideo:_rewardedAd.adUnitID];
    Object *obj = ObjectDB::get_instance(instanceId);
    obj->call_deferred("_on_rewarded_video_ad_dismiss");
}
@end
