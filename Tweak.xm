#import "CC.h"
//#import <os/log.h>
#import "libstatusbar/LSStatusBarItem.h"

LSStatusBarItem *item;

static void updateIcon(BOOL state) {

	dlopen("/usr/lib/libstatusbar.dylib", RTLD_LAZY);
    Class lss = objc_getClass("LSStatusBarItem");


    if (lss) {

    	if (!item) {

    	item = [[%c(LSStatusBarItem) alloc] initWithIdentifier:@"com.cabralcole.ccrecord" alignment:StatusBarAlignmentRight];

    	}


    	if(state) {


    	// item = [[%c(LSStatusBarItem) alloc] initWithIdentifier:@"ibstatusbar.Play" alignment:StatusBarAlignmentRight];
		item.imageName = @"ScreenRecording";
		item.visible = YES;
		[item update];

    	


		} else {

		item.visible = NO;
		[item update];

		item = nil;


	}
}

}



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
	

	return [UIImage imageNamed:@"CR@2x.png" inBundle:[NSBundle bundleWithPath:@"/Library/Application Support/CCRecord/"]];
}


- (void)_startRecording{



	updateIcon(YES);


	%orig();

	

}

- (void)_stopRecording{

	updateIcon(NO);

	%orig();

}


%end