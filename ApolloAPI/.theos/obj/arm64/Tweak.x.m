#line 1 "Tweak.x"
#import "Tweak.h"

static void (*ApolloSettingsGeneralViewController_viewDidLoad_orig)(__unsafe_unretained UIViewController* const, SEL);
static void ApolloSettingsGeneralViewController_viewDidLoad_swizzle(__unsafe_unretained UIViewController* const self, SEL _cmd) {
	ApolloSettingsGeneralViewController_viewDidLoad_orig(self, _cmd);

	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithPrimaryAction:
		[UIAction actionWithTitle:@"Custom API" image:nil identifier:nil handler:^(UIAction * action) {
			UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[[CustomAPIViewController alloc] init]];
		    [self presentViewController:navController animated:YES completion:nil];
	}]];
}

static void (*ApolloProfileViewController_viewDidLoad_orig)(__unsafe_unretained UIViewController* const, SEL);
static void ApolloProfileViewController_viewDidLoad_swizzle(__unsafe_unretained UIViewController* const self, SEL _cmd) {
	ApolloProfileViewController_viewDidLoad_orig(self, _cmd);

	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithPrimaryAction:
        [UIAction actionWithTitle:@"User Agent" image:nil identifier:nil handler:^(UIAction * action) {

            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"User Agent" message:@"Enter a custom user agent" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textField.text = (__bridge_transfer NSString *) CFPreferencesCopyAppValue(CFSTR("userAgent"), CFSTR("com.ryannair05.apolloapi")) ?: @"iOS: com.christianselig.Apollo v1.15.12 (by /u/iamthatis)";
            }];
    
            UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                UITextField *textField = alertController.textFields.firstObject;
                if (textField.text.length > 0) {
                    CFPreferencesSetAppValue(CFSTR("userAgent"), (__bridge CFStringRef) textField.text, CFSTR("com.ryannair05.apolloapi"));
                }
                else {
                    CFPreferencesSetAppValue(CFSTR("userAgent"), CFSTR("iOS: com.christianselig.Apollo v1.15.12 (by /u/iamthatis)"), CFSTR("com.ryannair05.apolloapi"));
                }
            }];

            [alertController addAction:doneAction];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancelAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
	}]];
}

static void (*ApolloWallpaperAlertViewController_viewDidAppear_orig)(__unsafe_unretained UIViewController* const, SEL, BOOL animated);
static void ApolloWallpaperAlertViewController_viewDidAppear_swizzle(__unsafe_unretained UIViewController* const self, SEL _cmd, BOOL animated) {
	ApolloWallpaperAlertViewController_viewDidAppear_orig(self, _cmd, animated);

    UITabBarController *tabBarController = (UITabBarController *) [self presentingViewController];

    if ([tabBarController selectedIndex] == 0) {
        [tabBarController dismissViewControllerAnimated:NO completion:nil];
    }
    else {
        UIButton *wallpaperButton = self.view.subviews[3];
        UIButtonConfiguration *buttonConfig = [UIButtonConfiguration filledButtonConfiguration];
        buttonConfig.cornerStyle = UIButtonConfigurationCornerStyleLarge;
        buttonConfig.attributedTitle = [[NSAttributedString alloc] initWithString:@"Dismiss" attributes: @{NSFontAttributeName : [UIFont boldSystemFontOfSize:20.0]}];

        UIButton *dismissButton = [UIButton buttonWithConfiguration:buttonConfig primaryAction:
        [UIAction actionWithHandler:^(UIAction * action) {
            [tabBarController dismissViewControllerAnimated:YES completion:nil];
        }]];

        dismissButton.alpha = 0.0;
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
            dismissButton.alpha = 1.0;
        } completion:nil];

        [self.view addSubview:dismissButton];
        dismissButton.translatesAutoresizingMaskIntoConstraints = NO;

        [self.view addConstraints:@[  
            [NSLayoutConstraint constraintWithItem:dismissButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:wallpaperButton attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0],
            [NSLayoutConstraint constraintWithItem:dismissButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:wallpaperButton attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0],
            [NSLayoutConstraint constraintWithItem:dismissButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:wallpaperButton attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0],
            [NSLayoutConstraint constraintWithItem:dismissButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:wallpaperButton attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20]
        ]];
    }
}

static void (*ApolloTabBarController_viewDidAppear_orig)(__unsafe_unretained UIViewController* const, SEL, BOOL animated);
static void ApolloTabBarController_viewDidAppear_swizzle(__unsafe_unretained UIViewController* const self, SEL _cmd, BOOL animated) {
	ApolloTabBarController_viewDidAppear_orig(self, _cmd, animated);

	OBWelcomeController* welcomeController = [[objc_getClass("OBWelcomeController") alloc] initWithTitle:@"Apollo API" detailText:@"Apollo API allows you to enter a custom API key " icon:[UIImage systemImageNamed:@"character.cursor.ibeam"]];

    [welcomeController addBulletedListItemWithTitle:@"Settings" description:@"Go to Settings -> General and click \"Custom API\" on the navigation bar" image:[UIImage systemImageNamed:@"1.circle.fill"]];
    [welcomeController addBulletedListItemWithTitle:@"Make an API" description:@"Follow the directions to make an API Key on Reddit's website and insert the key into preferences" image:[UIImage systemImageNamed:@"2.circle.fill"]];
    [welcomeController addBulletedListItemWithTitle:@"Insert New API" description:@"Changes are applied immediately, but it may take logging in and out of accounts to take effect" image:[UIImage systemImageNamed:@"3.circle.fill"]];

    UIButton *continueButton = [UIButton buttonWithConfiguration:[UIButtonConfiguration filledButtonConfiguration] primaryAction:
        [UIAction actionWithTitle:@"Continue" image:nil identifier:nil handler:^(UIAction * action) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
        CFPreferencesSetAppValue(CFSTR("shownWelcomeController"), kCFBooleanTrue, CFSTR("com.ryannair05.apolloapi"));
        method_setImplementation(class_getInstanceMethod([self class], @selector(viewDidAppear:)), (IMP)ApolloTabBarController_viewDidAppear_orig);
    }]];

    [welcomeController.buttonTray addButton:continueButton];
     
    UIVisualEffectView *effectWelcomeView = [[UIVisualEffectView alloc] initWithFrame:welcomeController.viewIfLoaded.bounds];
     
    effectWelcomeView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemChromeMaterial];
     
    [welcomeController.viewIfLoaded insertSubview:effectWelcomeView atIndex:0];

    welcomeController.viewIfLoaded.backgroundColor = [UIColor clearColor];

    [welcomeController.buttonTray addCaptionText:@"Enjoy using Apollo!"];

    welcomeController.modalPresentationStyle = UIModalPresentationPageSheet;
    welcomeController.modalInPresentation = YES;
	[self presentViewController:welcomeController animated:YES completion:nil];
}


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

__asm__(".linker_option \"-framework\", \"CydiaSubstrate\"");

@class RDKClient; @class NSURLSession; @class RDKOAuthCredential; 
static NSString * (*_logos_orig$_ungrouped$RDKOAuthCredential$clientIdentifier)(_LOGOS_SELF_TYPE_NORMAL RDKOAuthCredential* _LOGOS_SELF_CONST, SEL); static NSString * _logos_method$_ungrouped$RDKOAuthCredential$clientIdentifier(_LOGOS_SELF_TYPE_NORMAL RDKOAuthCredential* _LOGOS_SELF_CONST, SEL); static NSString * (*_logos_orig$_ungrouped$RDKClient$userAgent)(_LOGOS_SELF_TYPE_NORMAL RDKClient* _LOGOS_SELF_CONST, SEL); static NSString * _logos_method$_ungrouped$RDKClient$userAgent(_LOGOS_SELF_TYPE_NORMAL RDKClient* _LOGOS_SELF_CONST, SEL); static NSURLSessionUploadTask* (*_logos_orig$_ungrouped$NSURLSession$uploadTaskWithRequest$fromData$completionHandler$)(_LOGOS_SELF_TYPE_NORMAL NSURLSession* _LOGOS_SELF_CONST, SEL, NSURLRequest*, NSData*, void (^)(NSData*, NSURLResponse*, NSError*)); static NSURLSessionUploadTask* _logos_method$_ungrouped$NSURLSession$uploadTaskWithRequest$fromData$completionHandler$(_LOGOS_SELF_TYPE_NORMAL NSURLSession* _LOGOS_SELF_CONST, SEL, NSURLRequest*, NSData*, void (^)(NSData*, NSURLResponse*, NSError*)); static NSURLSessionDataTask* (*_logos_orig$_ungrouped$NSURLSession$dataTaskWithRequest$completionHandler$)(_LOGOS_SELF_TYPE_NORMAL NSURLSession* _LOGOS_SELF_CONST, SEL, NSURLRequest*, void (^)(NSData*, NSURLResponse*, NSError*)); static NSURLSessionDataTask* _logos_method$_ungrouped$NSURLSession$dataTaskWithRequest$completionHandler$(_LOGOS_SELF_TYPE_NORMAL NSURLSession* _LOGOS_SELF_CONST, SEL, NSURLRequest*, void (^)(NSData*, NSURLResponse*, NSError*)); static NSURLSessionDataTask * (*_logos_orig$_ungrouped$NSURLSession$dataTaskWithURL$completionHandler$)(_LOGOS_SELF_TYPE_NORMAL NSURLSession* _LOGOS_SELF_CONST, SEL, NSURL *, void (^)(NSData *, NSURLResponse *, NSError *)); static NSURLSessionDataTask * _logos_method$_ungrouped$NSURLSession$dataTaskWithURL$completionHandler$(_LOGOS_SELF_TYPE_NORMAL NSURLSession* _LOGOS_SELF_CONST, SEL, NSURL *, void (^)(NSData *, NSURLResponse *, NSError *)); 

#line 117 "Tweak.x"

static NSString * _logos_method$_ungrouped$RDKOAuthCredential$clientIdentifier(_LOGOS_SELF_TYPE_NORMAL RDKOAuthCredential* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	return customIdentifier ?: _logos_orig$_ungrouped$RDKOAuthCredential$clientIdentifier(self, _cmd);
}



static NSString * _logos_method$_ungrouped$RDKClient$userAgent(_LOGOS_SELF_TYPE_NORMAL RDKClient* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    NSString *customUserAgent = (__bridge_transfer NSString *) CFPreferencesCopyAppValue(CFSTR("userAgent"), CFSTR("com.ryannair05.apolloapi"));
    return customUserAgent ?: _logos_orig$_ungrouped$RDKClient$userAgent(self, _cmd);
}



static NSURLSessionUploadTask* _logos_method$_ungrouped$NSURLSession$uploadTaskWithRequest$fromData$completionHandler$(_LOGOS_SELF_TYPE_NORMAL NSURLSession* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSURLRequest* request, NSData* bodyData, void (^completionHandler)(NSData*, NSURLResponse*, NSError*)) {
    if ([[[request URL] lastPathComponent] isEqualToString:@"image"]) {
        NSMutableURLRequest *modifiedRequest = [request mutableCopy];
        [modifiedRequest setURL:[NSURL URLWithString:[@"https://api.imgur.com/3/image?client_id=" stringByAppendingString:imgurAPIKey]]];
        return _logos_orig$_ungrouped$NSURLSession$uploadTaskWithRequest$fromData$completionHandler$(self, _cmd, [modifiedRequest copy], bodyData, completionHandler);
    }
    return _logos_orig$_ungrouped$NSURLSession$uploadTaskWithRequest$fromData$completionHandler$(self, _cmd, request, bodyData, completionHandler);
}

static NSURLSessionDataTask* _logos_method$_ungrouped$NSURLSession$dataTaskWithRequest$completionHandler$(_LOGOS_SELF_TYPE_NORMAL NSURLSession* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSURLRequest* request, void (^completionHandler)(NSData*, NSURLResponse*, NSError*)) {
    NSURL *urlRequest = [request URL];

    if ([[urlRequest host] compare:@"imgur-apiv3.p" options:NSLiteralSearch | NSAnchoredSearch range:NSMakeRange(0, 13)] == NSOrderedSame) {
        NSMutableURLRequest *modifiedRequest = [request mutableCopy];
        [modifiedRequest setURL:[NSURL URLWithString:[@"https://api.imgur.com/3/image" stringByAppendingPathComponent:[urlRequest lastPathComponent]]]];
        return _logos_orig$_ungrouped$NSURLSession$dataTaskWithRequest$completionHandler$(self, _cmd, [modifiedRequest copy], completionHandler);
    }
    return _logos_orig$_ungrouped$NSURLSession$dataTaskWithRequest$completionHandler$(self, _cmd, request, completionHandler);
}

static NSURLSessionDataTask * _logos_method$_ungrouped$NSURLSession$dataTaskWithURL$completionHandler$(_LOGOS_SELF_TYPE_NORMAL NSURLSession* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSURL * url, void (^completionHandler)(NSData *, NSURLResponse *, NSError *)) {
    if ([[url host] containsString:@"apollogur"]) {
        NSArray<NSString *> *apollogurComponents = url.pathComponents;
        NSString *endpointType = apollogurComponents[2];

        if ([endpointType isEqualToString:@"image"] || [endpointType isEqualToString:@"album"]) {
            NSURL *modifiedURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.imgur.com/3/%@/%@.json?client_id=%@", endpointType, apollogurComponents[3], imgurAPIKey]];
            return _logos_orig$_ungrouped$NSURLSession$dataTaskWithURL$completionHandler$(self, _cmd, modifiedURL, completionHandler);
        }
    }

    return _logos_orig$_ungrouped$NSURLSession$dataTaskWithURL$completionHandler$(self, _cmd, url, completionHandler);
}


static __attribute__((constructor)) void _logosLocalCtor_e328229b(int __unused argc, char __unused **argv, char __unused **envp) {
	{Class _logos_class$_ungrouped$RDKOAuthCredential = objc_getClass("RDKOAuthCredential"); { MSHookMessageEx(_logos_class$_ungrouped$RDKOAuthCredential, @selector(clientIdentifier), (IMP)&_logos_method$_ungrouped$RDKOAuthCredential$clientIdentifier, (IMP*)&_logos_orig$_ungrouped$RDKOAuthCredential$clientIdentifier);}Class _logos_class$_ungrouped$RDKClient = objc_getClass("RDKClient"); { MSHookMessageEx(_logos_class$_ungrouped$RDKClient, @selector(userAgent), (IMP)&_logos_method$_ungrouped$RDKClient$userAgent, (IMP*)&_logos_orig$_ungrouped$RDKClient$userAgent);}Class _logos_class$_ungrouped$NSURLSession = objc_getClass("NSURLSession"); { MSHookMessageEx(_logos_class$_ungrouped$NSURLSession, @selector(uploadTaskWithRequest:fromData:completionHandler:), (IMP)&_logos_method$_ungrouped$NSURLSession$uploadTaskWithRequest$fromData$completionHandler$, (IMP*)&_logos_orig$_ungrouped$NSURLSession$uploadTaskWithRequest$fromData$completionHandler$);}{ MSHookMessageEx(_logos_class$_ungrouped$NSURLSession, @selector(dataTaskWithRequest:completionHandler:), (IMP)&_logos_method$_ungrouped$NSURLSession$dataTaskWithRequest$completionHandler$, (IMP*)&_logos_orig$_ungrouped$NSURLSession$dataTaskWithRequest$completionHandler$);}{ MSHookMessageEx(_logos_class$_ungrouped$NSURLSession, @selector(dataTaskWithURL:completionHandler:), (IMP)&_logos_method$_ungrouped$NSURLSession$dataTaskWithURL$completionHandler$, (IMP*)&_logos_orig$_ungrouped$NSURLSession$dataTaskWithURL$completionHandler$);}}

	MSHookMessageEx(objc_getClass("Apollo.SettingsGeneralViewController"), @selector(viewDidLoad), (IMP)&ApolloSettingsGeneralViewController_viewDidLoad_swizzle, (IMP*)&ApolloSettingsGeneralViewController_viewDidLoad_orig);
    MSHookMessageEx(objc_getClass("Apollo.ProfileViewController"), @selector(viewDidLoad), (IMP)&ApolloProfileViewController_viewDidLoad_swizzle, (IMP*)&ApolloProfileViewController_viewDidLoad_orig);
    MSHookMessageEx(objc_getClass("_TtGC7SwiftUI19UIHostingControllerV6Apollo18WallpaperAlertView_"), @selector(viewDidAppear:), (IMP)&ApolloWallpaperAlertViewController_viewDidAppear_swizzle, (IMP*)&ApolloWallpaperAlertViewController_viewDidAppear_orig);
    customIdentifier = (__bridge_transfer NSString *) CFPreferencesCopyAppValue(CFSTR("customAPIKey"), CFSTR("com.ryannair05.apolloapi"));
    imgurAPIKey = (__bridge_transfer NSString *) CFPreferencesCopyAppValue(CFSTR("imgurAPIKey"), CFSTR("com.ryannair05.apolloapi"));

	if (!CFPreferencesGetAppBooleanValue(CFSTR("shownWelcomeController"), CFSTR("com.ryannair05.apolloapi"), NULL) && objc_getClass("OBWelcomeController")) {
        ApolloTabBarController_viewDidAppear_orig = (void (*)(UIViewController* const, SEL, BOOL)) method_setImplementation(class_getInstanceMethod(objc_getClass("Apollo.ApolloTabBarController"), @selector(viewDidAppear:)), (IMP)ApolloTabBarController_viewDidAppear_swizzle);
	}
}
