//
//  google_admob.m
//  google_admob
//
//  Created by Sergey Minakov on 14.08.2020.
//  Copyright © 2020 Godot. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "core/project_settings.h"
#include "core/class_db.h"

#import "GoogleAdmob.h"
#import "AdmobRewarded.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

GoogleAdmob::GoogleAdmob() {
}

GoogleAdmob::~GoogleAdmob() {
}

void GoogleAdmob::_bind_methods() {
    ClassDB::bind_method(D_METHOD("init"), &GoogleAdmob::init);
    ClassDB::bind_method(D_METHOD("loadRewardedVideo"), &GoogleAdmob::loadRewardedVideo);
    ClassDB::bind_method(D_METHOD("showRewardedVideo"), &GoogleAdmob::showRewardedVideo);
}

void GoogleAdmob::init(int instanceId) {
    [[GADMobileAds sharedInstance] startWithCompletionHandler:nil];
    
    rewarded = [AdmobRewarded alloc];
    [rewarded initialize:instanceId];
}

void GoogleAdmob::loadRewardedVideo(String rewardedId) {
    NSString *idStr = [NSString stringWithCString:rewardedId.utf8().get_data() encoding: NSUTF8StringEncoding];
    [rewarded loadRewardedVideo:idStr];
}

void GoogleAdmob::showRewardedVideo(String rewardedId) {
    NSString *idStr = [NSString stringWithCString:rewardedId.utf8().get_data() encoding: NSUTF8StringEncoding];
    [rewarded showRewardedVideo:idStr];
}
