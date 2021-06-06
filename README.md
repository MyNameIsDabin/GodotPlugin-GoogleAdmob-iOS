# GodotPlugin-GoogleAdmob-iOS
Godot 3.3+ Google Admob Plugin (SDK v8) for iOS

...Sorry, I only implement what I need, so only RewardedAds work.

Step 1. export setting -> [Plugins] Enable 'Google Admob'

Step 2. build your xcode project and Update [Info.plist](https://developers.google.com/admob/ios/quick-start?hl=ko#update_your_infoplist)

### Example (Only Reward Ads.. T.T)
```
extends Node

var admob = null

const RVIDEO_1: String = "ca-app-pub-XXXXXXXXXXXXXX/XXXXXXX1"
const RVIDEO_2: String = "ca-app-pub-XXXXXXXXXXXXXX/XXXXXXX2"
const RVIDEO_3: String = "ca-app-pub-XXXXXXXXXXXXXX/XXXXXXX3"

func _ready():
	if Engine.has_singleton("GoogleAdmob") and OS.get_name() == "iOS":
		admob = Engine.get_singleton("GoogleAdmob")
		admob.init(get_instance_id())
	
	loadRewardedVideos([RVIDEO_1, RVIDEO_2, RVIDEO_3])

# upport multiple rewards.
func loadRewardedVideos(adRewardedIds: PoolStringArray):
	for rewardedId in adRewardedIds:
		loadRewardedVideo(rewardedId)

func loadRewardedVideo(adRewardedId: String):
	if admob != null:
		admob.loadRewardedVideo(adRewardedId)

func showRewardedVideo(adRewardedId: String):
	if admob != null:
		admob.showRewardedVideo(adRewardedId)

func _on_rewarded_video_ad_failed_to_load():
	print("Rewarded loaded failure")

func _on_rewarded_video_ad_loaded():
	print("Rewarded loaded success")

func _on_rewarded_video_ad_dismiss():
	print("Rewarded Dismissed.")

func _on_rewarded(currency, amount, playedRewardedID):
	print("Reward: " + currency + ", " + str(amount) + ", " + playedRewardedID)
```
