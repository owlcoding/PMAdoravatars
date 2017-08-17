#import <Kiwi/Kiwi.h>
#import "AvatarsListInteractor.h"

SPEC_BEGIN(AvatarsListInteractorSpec)

    describe(@"AvatarListInteractor object", ^{
        AvatarsListInteractor *interactor = [[AvatarsListInteractor alloc] initWithNamesList:@[@"name1", @"name2"]];

        __block BOOL downloadHasStarted = NO;
        __block BOOL downloadHasFinished = NO;
        __block void (^downloadCompletionBlock)(NSData *data, NSURLResponse *response, NSError *error);

        id startedDataTask = [NSURLSessionDataTask mock];
        [startedDataTask stub:@selector(resume) withBlock:^id(NSArray *params) {
            downloadHasStarted = YES;
            return nil;
        }];

        [startedDataTask stub:@selector(error) andReturn:nil];

        id urlSessionMock = [NSURLSession mock];

        [urlSessionMock stub:@selector(dataTaskWithURL:completionHandler:) withBlock:^id(NSArray *params) {
            downloadCompletionBlock = params[1];
            return startedDataTask;
        }];

        interactor.urlSession = urlSessionMock;

        [[interactor should] beKindOfClass:[AvatarsListInteractor class]];
        [[interactor should] conformToProtocol:@protocol(AvatarsListInteractorInputProtocol)];

        context(@"was initialized with 2 names", ^{
            it(@"numberOfAvatars should be 2", ^{
                [[theValue([interactor numberOfAvatars]) should] equal:@(2)];
            });

            context(@"Avatar fetching flow", ^{
                [interactor fetchAvatarAtIndex:0];

                it(@"", ^{
                    [[[interactor avatarAtIndex:0] shouldNot] beNil];
                    [[[interactor avatarAtIndex:0].downloadTask shouldNot] beNil];
                    [[theValue([interactor avatarAtIndex:0].downloadStatus) should] equal:@(AvatarDownloadStatusDownloading)];
                    [[theValue(downloadHasStarted) should] beYes];

                    downloadCompletionBlock([NSData data], [NSURLResponse new], nil);

                    [[theValue([interactor avatarAtIndex:0].downloadStatus) should] equal:@(AvatarDownloadStatusSuccess)];

                    downloadCompletionBlock(nil, [NSURLResponse new], [NSError new]);
                    [[theValue([interactor avatarAtIndex:0].downloadStatus) should] equal:@(AvatarDownloadStatusError)];

                });
            });
        });

    });

SPEC_END
