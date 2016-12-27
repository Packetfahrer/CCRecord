#import "../CC.h"

%hook CCUIRecordScreenShortcut


+ (bool)isInternalButton
{
	return NO;
}

+ (bool)isSupported:(int)arg1
{
	return YES;
}

- (UIImage *)glyphImageForState:(UIControlState)state
{
	return [UIImage imageNamed:@"RecordVideo-OrbHW@2x.png" inBundle:[NSBundle bundleWithPath:@"/Applications/Camera.app/"]];
}


%end