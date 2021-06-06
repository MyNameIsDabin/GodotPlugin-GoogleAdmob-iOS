#ifndef google_admob_h
#define google_admob_h

#include "core/object.h"

#ifdef __OBJC__
@class AdmobRewarded;
typedef AdmobRewarded *rewardedPtr;
#else
typedef void *rewardedPtr;
#endif

class GoogleAdmob : public Object {
    GDCLASS(GoogleAdmob, Object);
    
    static void _bind_methods();
    
    rewardedPtr rewarded;
public:
    
    void init(int instanceId);
    void loadRewardedVideo(String rewardedId);
    void showRewardedVideo(String rewardedId);
    
    GoogleAdmob();
    ~GoogleAdmob();
};

#endif
