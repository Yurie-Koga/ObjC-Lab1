//
//  main.m
//  Lab1
//
//  Created by Uji Saori on 2021-02-22.
//

// <>: file path. import: copy the contents of this file
#import <Foundation/Foundation.h>

/* functions should be written before get called */

// return NSString
NSString *getUserInput(int maxLength, NSString *prompt){
    // default
    if (maxLength < 1) {
        maxLength = 255;
    }
    NSLog(@"%@ ", prompt);
    char inputChars[maxLength];
    char *result = fgets(inputChars, maxLength, stdin);
    if (result != NULL) {
        // call class method: 'ClassName MethodName'
        NSString *objCString = [NSString stringWithUTF8String: inputChars];
        NSCharacterSet *whitespaces = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimmedInput = [objCString stringByTrimmingCharactersInSet: whitespaces];
        return trimmedInput;
    }
    return NULL;
}


// argc = argument count
// argv = argument value?
// * : pointer = stores memory address -> put '*' for reference type valuables
int main(int argc, const char * argv[]) {
    // always write code INSIDE @autoreleasepool
    @autoreleasepool {
        // options
        NSArray *options = @[@"Uppercase", @"Lowercase", @"Numberize", @"Canadianize", @"Respond", @"De-Space-It"];
        NSString *optionMSG = @"\nChoose one of the following options ('c' to quit):";
        for (int i = 0; i < [options count]; i++) {
            NSString *str = [[NSString alloc] initWithFormat: @"\n%d. %@", i+1, [options objectAtIndex: i]];
            optionMSG = [optionMSG stringByAppendingString: str];
        }
        
        // bool: YES/NO, TRUE/FALSE, 1/0
        while (YES) {
            NSString *strInput = getUserInput(255, @"\nEnter your string ('q' to quit): ");
            if ([[strInput lowercaseString] isEqualToString: @"q"]) { break; }
            
            while (YES) {
                NSString *option = getUserInput(10, optionMSG);
                if ([[option lowercaseString] isEqualToString: @"c"]) { break; }
                
                NSString *resultStr = @"";
                switch ([option integerValue]) {
                    case 1:     // Uppercase
                        resultStr = [strInput uppercaseString];
                        break;
                    case 2:     // Lowercase
                        resultStr = [strInput lowercaseString];
                        break;
                    case 3:     // Numberize
                        if ([strInput integerValue]) {
                            resultStr = [NSString stringWithFormat: @"%ld", [strInput integerValue]];
                        } else {
                            resultStr = @"unable to convert";
                        }
                        break;
                    case 4:     // Canadianize
                        resultStr = [strInput stringByAppendingString: @", eh?"];
                        break;
                    case 5:     // Respond
                        if ([strInput scriptingEndsWith: @"?"]) {
                            resultStr = @"I don't know.";
                        } else if ([strInput scriptingEndsWith: @"!"]) {
                            resultStr = @"Whoa, calm down!";
                        } else {
                            resultStr = @"guuuud";
                        }
                        break;
                    case 6:     // De-Space-It
                        resultStr = [strInput stringByReplacingOccurrencesOfString: @" " withString: @"-"];
                        break;
                    default:
                        NSLog(@"\n***** %s *****", "input was invalid.");
                        break;
                }
                
                if ([resultStr length] > 0) {
                    NSLog(@"\n===== Result: %@ =====", resultStr);
                }
            }
        }
    }
    return 0;
}


