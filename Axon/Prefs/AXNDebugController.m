#import <AppList/AppList.h>
#import "AXNController.h"

@interface AXNDebugController : PSListController
@end

@implementation AXNDebugController
-(id)specifiers {
	if(_specifiers == nil)
	{
		NSMutableArray *specifiers = [[NSMutableArray alloc] init];

		[specifiers addObject:({
			PSSpecifier *specifier = [PSSpecifier preferenceSpecifierNamed:@"Debug Options" target:self set:nil get:nil detail:nil cell:PSGroupCell edit:nil];
			[specifier.properties setValue:@"The debug options can help you solve issue!.." forKey:@"footerText"];
			specifier;
		})];

    [specifiers addObject:({
			PSSpecifier *specifier = [PSSpecifier preferenceSpecifierNamed:@"Clear all notification" target:self set:nil get:nil detail:nil cell:PSButtonCell edit:nil];
	    specifier->action = @selector(clearAll);
			specifier;
		})];
    [specifiers addObject:({
			PSSpecifier *specifier = [PSSpecifier preferenceSpecifierNamed:@"Save notification list" target:self set:nil get:nil detail:nil cell:PSButtonCell edit:nil];
	    specifier->action = @selector(saveNotification);
			specifier;
		})];
    [specifiers addObject:({
			PSSpecifier *specifier = [PSSpecifier preferenceSpecifierNamed:@"Report Issue" target:self set:nil get:nil detail:nil cell:PSButtonCell edit:nil];
	    specifier->action = @selector(report);
			specifier;
		})];

		_specifiers = [specifiers copy];
	}

	return _specifiers;
}

-(void)clearAll {
  [[objc_getClass("NSDistributedNotificationCenter") defaultCenter] postNotificationName:@"me.nepeta.axon.clearAllNotification" object:nil];
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Debug" message:@"All notifications registered with Axon have been removed." preferredStyle:UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
  }]];
  return [self presentViewController:alert animated:YES completion:nil];
}
-(void)saveNotification {
  [[objc_getClass("NSDistributedNotificationCenter") defaultCenter] postNotificationName:@"me.nepeta.axon.saveNotification" object:nil];
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Debug" message:@"All notifications registered with Axon have been saved to /var/mobile/Documents/AxonDebug.txt" preferredStyle:UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
  }]];
  return [self presentViewController:alert animated:YES completion:nil];
}
-(void)report {
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://github.com/Baw-Appie/Axon/issues/new"] options:@{} completionHandler:nil];
}
@end
