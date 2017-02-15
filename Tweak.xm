#import "../CC.h"

static BOOL overrideInternal;

extern "C" BOOL MGGetBoolAnswer(CFStringRef);

%hookf(BOOL, MGGetBoolAnswer, CFStringRef key)
{
	#define k(key_) CFEqual(key, CFSTR(key_))
	if (overrideInternal && k("apple-internal-install"))
			return YES;
	return %orig;
}

// @Andywiik AndrewWiik 
%hook CCUIButtonStackPagingView


- (void)_organizeButtonsInPages 
{
	overrideInternal = YES;
	%orig;
	overrideInternal = NO;
}

-(void)setPagingAxis:(NSInteger)arg1 
{
	%orig(0);
}

-(NSInteger)pagingAxis 
{
	return 0;
}

%end

%hook CCUIRecordScreenShortcut


+ (bool)isSupported:(int)arg1
{
	return YES;
}

- (UIImage *)glyphImageForState:(UIControlState)state
{
	return [UIImage imageNamed:@"RecordVideo-OrbHW@2x.png" inBundle:[NSBundle bundleWithPath:@"/Applications/Camera.app/"]];
}


%end