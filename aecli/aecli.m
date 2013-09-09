#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "XMLParser.h"

int main (int argc, const char * argv[]) {
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  
  // Managed object model
  NSString *modelFile = @"/Users/steve/Development/AmateurExtra/aecli/build/Debug/questions.mom";
  NSURL *modelURL = [NSURL fileURLWithPath:modelFile];
  if (!modelURL) {
    NSLog(@"Can't create an URL from model file %@.", modelFile);
    return 1;
  }
  NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  if(mom == nil) {
    NSLog(@"Error creating object model.");
    return 1;
  }
  
  // Managed object context
  NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] init];
  NSPersistentStoreCoordinator *coordinator =
    [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
  [moc setPersistentStoreCoordinator: coordinator];
  NSString *STORE_TYPE = NSSQLiteStoreType; //NSXMLStoreType;
  NSError *error;
  NSURL *dataURL = [NSURL fileURLWithPath:@"/Users/steve/Development/AmateurExtra/aecli/questions.data"];
  NSPersistentStore *newStore =
    [coordinator
      addPersistentStoreWithType:STORE_TYPE
      configuration:nil
      URL:dataURL
      options:nil
      error:&error];
  if (newStore == nil) {
    NSLog(@"Store Configuration Failure\n%@",
          ([error localizedDescription] != nil) ?
          [error localizedDescription] : @"Unknown Error");
    return 1;
  }

  // Open XML Document with NSXMLParser
  NSString *file = @"/Users/steve/Development/AmateurExtra/aecli/questions.xml";
  NSURL *furl = [NSURL fileURLWithPath:file];
  if (!furl) {
    NSLog(@"Can't create an URL from file %@.", file);
    return 1;
  }
  NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:furl];
  XMLParser *parser = [[XMLParser alloc] initWithContext:moc];
  [xmlParser setDelegate:parser];
  [xmlParser setShouldResolveExternalEntities:YES];

  //Start parsing the XML file.
  BOOL success = [xmlParser parse];
  if(success)
    NSLog(@"No Errors");
  else
    NSLog(@"Error Error Error!!!");
  
  // Save data
  [moc save:&error];
  //NSLog(@"%@", error);
  
  [pool drain];
  return 0;
}
