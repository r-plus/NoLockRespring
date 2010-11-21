#import <UIKit/UIKit.h>

#include <unistd.h>
#include <stdlib.h>
#include <ctype.h>
#include <notify.h>

// Determines if the device is capable of running on this platform. If your toggle is device specific like only for
// 3g you would check that here.
BOOL isCapable()
{
	return YES;
}

// This runs when iPhone springboard resets. This is on boot or respring.
BOOL isEnabled()
{
	NSDictionary *plistDictNlr = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/jp.r-plus.nlr.plist"];
	//NSDictionary *plistDictSB = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.apple.springboard.plist"];
	BOOL nlrEnabled = [[plistDictNlr objectForKey:@"Enabled"] boolValue];
	//BOOL sbEnabled = [[plistDictSB objectForKey:@"SBLanguageRestart"] boolValue];
	
	if (nlrEnabled){
			notify_post("jp.r-plus.nlron");
	}
	
	return nlrEnabled;
}


// This function is optional and should only be used if it is likely for the toggle to become out of sync
// with the state while the iPhone is running. It must be very fast or you will slow down the animated
// showing of the sbsettings window. Imagine 12 slow toggles trying to refresh tate on show.
BOOL getStateFast()
{
	return isEnabled();
}

// Pass in state to set. YES for enable, NO to disable.
void setState(BOOL Enable)
{

	NSDictionary *plistDictNlr = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/jp.r-plus.nlr.plist"];
	//NSDictionary *plistDictSB = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.apple.springboard.plist"];
	
	if (Enable == YES)
	{
		[plistDictNlr setValue:[NSNumber numberWithBool:YES] forKey:@"Enabled"];
		[plistDictNlr writeToFile:@"/var/mobile/Library/Preferences/jp.r-plus.nlr.plist" atomically: YES];
		notify_post("jp.r-plus.nlron");
		//[plistDictSB setValue:[NSNumber numberWithBool:YES] forKey:@"SBLanguageRestart"];
		//[plistDictSB writeToFile:@"/var/mobile/Library/Preferences/com.apple.springboard.plist" atomically: YES];
	}
	else if (Enable == NO) 
	{
		[plistDictNlr setValue:[NSNumber numberWithBool:NO] forKey:@"Enabled"];
		[plistDictNlr writeToFile:@"/var/mobile/Library/Preferences/jp.r-plus.nlr.plist" atomically: YES];
		notify_post("jp.r-plus.nlroff");
		//[plistDictSB setValue:[NSNumber numberWithBool:NO] forKey:@"SBLanguageRestart"];
		//[plistDictSB writeToFile:@"/var/mobile/Library/Preferences/com.apple.springboard.plist" atomically: YES];
	}

//	notify_post("com.apple.language.changed");
}

	
// Amount of time spinner should spin in seconds after the toggle is selected.
float getDelayTime()
{
	return 0.1f;
}
/*
 // Runs when the dylib is loaded. Only useful for debug. Function can be omitted.
 __attribute__((constructor)) 
 static void toggle_initializer() 
 { 
 NSLog(@"Initializing LServices Toggle\n"); 
 }
 */
// vim:ft=objc