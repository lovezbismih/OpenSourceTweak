#import "InstaNotAStalker.h"
#import <RemoteLog.h>

%hook IGFeedPhotoView

- (void)_onDoubleTap:(id)arg1 {
	
	IGFeedItemPhotoCell *cell = (IGFeedItemPhotoCell *)[[self superview] superview];
	NSString *username = [[[cell mediaCellFeedItem] user] username];
	NSString *title = [NSString stringWithFormat:@"Like %@'s Post?", username];
	NSDate *now = [NSDate date];
	NSDate *takenAtDate = [[[cell mediaCellFeedItem] takenAtDate] date];

	if (([now timeIntervalSinceDate:takenAtDate] > minimumTakenAtTime || alwaysAlert) && doubleTapModeEnabled) {

		UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:alertStyle];
		UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {%orig;}]; // Like photo
		UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDestructive handler:nil]; // Do not like photo
		[alert addAction:yesAction];
		[alert addAction:noAction];

		[[self viewController] presentViewController:alert animated:YES completion:nil];

	} else {

		%orig;

	}

}

%end



%hook IGFeedItemUFICell

- (void)UFIButtonBarDidTapOnLike:(id)arg1 {

	NSString *username = [[[[self delegate] feedItem] user] username];
	NSString *title = [NSString stringWithFormat:@"Like %@'s Post?", username];
	NSDate *now = [NSDate date];
	NSDate *takenAtDate = [[[[self delegate] feedItem] takenAtDate] date];
	BOOL hasLiked = [[[self delegate] feedItem] hasLiked];
	
	if ((!hasLiked) && ([now timeIntervalSinceDate:takenAtDate] > minimumTakenAtTime || alwaysAlert) && heartTapModeEnabled) {

		UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:alertStyle];
		UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {%orig;}]; // Like post
		UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDestructive handler:nil]; // Do not like post
		[alert addAction:yesAction];
		[alert addAction:noAction];

		[[self viewController] presentViewController:alert animated:YES completion:nil];

	} else {

		%orig;

	}

}

%end

%hook IGFollowController

- (void)_didPressFollowButton {

	NSString *username = [[self user] username];
	NSString *title = [NSString stringWithFormat:@"Follow %@?", username];
	BOOL isFollowedOrHasRequested = [[self followAccountButton] buttonState] != 2;
	/*			BUTTON STATE: 2 -> Not Followed | 3 -> Followed | 4 -> Requested 
		NOTE: [user followsCurrentUser] is updated only after reloading the profile page
	*/

	if ((!isFollowedOrHasRequested) && followModeEnabled) {

		UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:alertStyle];
		UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {%orig;}]; // Like post
		UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDestructive handler:nil]; // Do not like post
		[alert addAction:yesAction];
		[alert addAction:noAction];

		[[[self followAccountButton] viewController] presentViewController:alert animated:YES completion:nil];

	} else {

		%orig;

	}

}

%end

static void loadPrefs() {

	NSMutableDictionary *preferences = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.yulkytulky.instanotastalker.plist"];

	enabled = [preferences objectForKey:@"enabled"] ? [[preferences objectForKey:@"enabled"] boolValue] : YES; // Default: Enabled

	doubleTapModeEnabled = [preferences objectForKey:@"doubleTapModeEnabled"] ? [[preferences objectForKey:@"doubleTapModeEnabled"] boolValue] : YES;
	heartTapModeEnabled = [preferences objectForKey:@"heartTapModeEnabled"] ? [[preferences objectForKey:@"heartTapModeEnabled"] boolValue] : NO;
	followModeEnabled = [preferences objectForKey:@"followModeEnabled"] ? [[preferences objectForKey:@"followModeEnabled"] boolValue] : NO;

	alertStyle = [preferences objectForKey:@"alertStyle"] ? [[preferences objectForKey:@"alertStyle"] intValue] : 0;

	alwaysAlert = [preferences objectForKey:@"alwaysAlert"] ? [[preferences objectForKey:@"alwaysAlert"] boolValue] : NO;
	minimumTakenAtTime = [preferences objectForKey:@"minimumTakenAtTime"] ? [[preferences objectForKey:@"minimumTakenAtTime"] floatValue] : 604800.0f;
	timeMultiplier = [preferences objectForKey:@"timeMultiplier"] ? [[preferences objectForKey:@"timeMultiplier"] intValue] : 1;

	minimumTakenAtTime *= timeMultiplier; // Fully prepare time minimum

}

%ctor {

	RLog(@"ctor");

	// DEVELOPER'S NOTE: Hooking IGFeedItem did not work as the like would "half-happen" by then and crash Instagram

	loadPrefs(); // Load preferences into variables
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.yulkytulky.instanotastalker/saved"), NULL, CFNotificationSuspensionBehaviorCoalesce); // Listen for preference changes

	if (enabled) {
			%init;
	}

}
