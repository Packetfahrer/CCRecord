#import <Flipswitch/FSSwitchDataSource.h>
#import <Flipswitch/FSSwitchPanel.h>

@interface CCUIButtonModule : NSObject
@end

@interface CCUIShortcutModule : CCUIButtonModule
@end

@interface CCUIRecordScreenShortcut : CCUIShortcutModule
+ (id)alloc;
- (void)_startRecording;
- (void)_stopRecording;
- (bool)_toggleState;
@end

@interface SBControlCenterController : NSObject
+ (SBControlCenterController *)sharedInstanceIfExists;
- (BOOL)isVisible;
- (void)dismissAnimated:(BOOL)animated completion:(void (^)())completionBlock;
@end


@interface ScreenRecordSwitch : NSObject <FSSwitchDataSource>
@end

static FSSwitchState state;

@implementation ScreenRecordSwitch

- (BOOL)isControlCenterVisible
{
	SBControlCenterController *controller = (SBControlCenterController *)[%c(SBControlCenterController) sharedInstanceIfExists];
	return [controller isVisible];
}

- (void)dismissControlCenterWithCompletion:(void (^)())completion
{
	SBControlCenterController *controller = (SBControlCenterController *)[%c(SBControlCenterController) sharedInstanceIfExists];
	[controller dismissAnimated:YES completion:^{
		if (completion)
			completion();
	}];
}


- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier
{
	return state;
}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier 
{
	CCUIRecordScreenShortcut *screenRecording = [[%c(CCUIRecordScreenShortcut) alloc] init];
	switch (newState) {
	case FSSwitchStateIndeterminate:
		break;
	case FSSwitchStateOn:
		state = FSSwitchStateOn;
		[self dismissControlCenterWithCompletion:^{
				[screenRecording _startRecording];
			}];
		break;
	case FSSwitchStateOff:
		state = FSSwitchStateOff;
		[self dismissControlCenterWithCompletion:^{
				[screenRecording _stopRecording];
			}];
		break;
	}
	return;
}

@end