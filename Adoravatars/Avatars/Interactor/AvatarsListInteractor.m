//
//  AvatarsListInteractor.m
//  Adoravatars
//
//  Created by Pawel Maczewski on 27/07/2017.
//  Copyright © 2017 Pawel Maczewski. All rights reserved.
//

#import "AvatarsListInteractor.h"

static NSString *sUrlPattern = @"https://api.adorable.io/avatars/%d/%@.png";
int const kImageSize = 80;

NSString *const kNOTIF_DOWNLOAD_STATUS_CHANGED = @"kNOTIF_DOWNLOAD_STATUS_CHANGED";
NSString *const kNOTIF_DOWNLOAD_STATUS_CHANGED_USERINFO_AVATAR_INDEX = @"kNOTIF_DOWNLOAD_STATUS_CHANGED_USERINFO_AVATAR_INDEX";

@interface AvatarsListInteractor ()

@property(nonatomic, strong) NSMutableDictionary <NSString *, AvatarDownloadModel *> *avatarDownloadsMap;
@property(nonatomic, strong) NSArray <NSString *> *avatarNames;

@end

@implementation AvatarsListInteractor

- (instancetype)initWithNamesList:(NSArray<NSString *> *)names {
    self = [self init];
    if (self) {
        _avatarNames = names;
    }

    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _avatarNames = @[];
        _avatarDownloadsMap = [NSMutableDictionary dictionary];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _urlSession = [NSURLSession sessionWithConfiguration:configuration];
    }

    return self;
}

- (instancetype)initWithStarWarsNames {
    self = [self initWithNamesList:@[
            @"Luke Skywalker", @"C-3PO", @"R2-D2", @"Darth Vader", @"Leia Organa", @"Owen Lars", @"Beru Whitesun lars",
            @"R5-D4", @"Biggs Darklighter", @"Obi-Wan Kenobi", @"Anakin Skywalker", @"Wilhuff Tarkin", @"Chewbacca", @"Han Solo",
            @"Greedo", @"Jabba Desilijic Tiure", @"Wedge Antilles", @"Jek Tono Porkins", @"Yoda", @"Palpatine", @"Boba Fett",
            @"IG-88", @"Bossk", @"Lando Calrissian", @"Lobot", @"Ackbar", @"Mon Mothma", @"Arvel Crynyd", @"Wicket Systri Warrick",
            @"Nien Nunb", @"Qui-Gon Jinn", @"Nute Gunray", @"Finis Valorum", @"Jar Jar Binks", @"Roos Tarpals", @"Rugor Nass",
            @"Ric Olié", @"Watto", @"Sebulba", @"Quarsh Panaka", @"Shmi Skywalker", @"Darth Maul", @"Bib Fortuna", @"Ayla Secura",
            @"Dud Bolt", @"Gasgano", @"Ben Quadinaros", @"Mace Windu", @"Ki-Adi-Mundi", @"Kit Fisto", @"Eeth Koth", @"Adi Gallia",
            @"Saesee Tiin", @"Yarael Poof", @"Plo Koon", @"Mas Amedda", @"Gregar Typho", @"Cordé", @"Cliegg Lars", @"Poggle the Lesser",
            @"Luminara Unduli", @"Barriss Offee", @"Dormé", @"Dooku", @"Bail Prestor Organa", @"Jango Fett", @"Zam Wesell",
            @"Dexter Jettster", @"Lama Su", @"Taun We", @"Jocasta Nu", @"Ratts Tyerell", @"R4-P17", @"Wat Tambor", @"San Hill",
            @"Shaak Ti", @"Grievous", @"Tarfful", @"Raymus Antilles", @"Sly Moore", @"Tion Medon", @"Finn", @"Rey", @"Poe Dameron",
            @"BB8", @"Captain Phasma", @"Padmé Amidala"
    ]];

    return self;
}

#pragma mark - InteractorProtocol

#pragma mark - Protocol implementation

- (void)fetchAvatarAtIndex:(NSUInteger)index {
    AvatarDownloadModel *model = [self avatarAtIndex:index];
    if (!model.downloadTask) {
        [self startFetchingAvatar:model];
    }
}

- (void)stopFetchingAvatarAtIndex:(NSUInteger)index {
    AvatarDownloadModel *model = [self avatarAtIndex:index];
    if (model.downloadTask && model.downloadTask.state == NSURLSessionTaskStateRunning) {
        [model.downloadTask cancel];
        model.downloadTask = nil;
    }
}

- (NSUInteger)numberOfAvatars {
    return self.avatarNames.count;
}

- (AvatarDownloadModel *)avatarAtIndex:(NSUInteger)index {
    if (index >= self.avatarNames.count) {
        return nil;
    }

    AvatarDownloadModel *model = self.avatarDownloadsMap[self.avatarNames[index]];
    if (!model) {
        model = [AvatarDownloadModel modelWithName:self.avatarNames[index]];
        self.avatarDownloadsMap[self.avatarNames[index]] = model;
    }

    return model;
}

- (NSArray <AvatarDownloadModel *> *)avatarDownloads {
    return [self.avatarDownloadsMap allValues];
}

#pragma mark - Private methods

- (void)didChangeDownloadStatusForAvatarAtIndex:(NSUInteger)avatarIndex {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIF_DOWNLOAD_STATUS_CHANGED
                                                        object:nil
                                                      userInfo:@{kNOTIF_DOWNLOAD_STATUS_CHANGED_USERINFO_AVATAR_INDEX: @(avatarIndex)}];
}

- (NSURL *)urlForAvatarName:(NSString *)avatarName {
    return [NSURL URLWithString:[NSString stringWithFormat:sUrlPattern,
                                                           kImageSize,
                                                           [avatarName stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]
                                                           ]]];
}

- (void)startFetchingAvatar:(AvatarDownloadModel *)model {
    if (!model.downloadTask || model.downloadTask.error) {
        NSUInteger avatarIndex = [self.avatarNames indexOfObject:model.avatarName];
        model.downloadTask = [self.urlSession dataTaskWithURL:[self urlForAvatarName:model.avatarName]
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                model.avatarImageRawData = data;
//                                                if (error.code != NSURLErrorCancelled) {
                                                    model.error = error;
//                                                }
                                                [model statusWasUpdated];
                                                [self didChangeDownloadStatusForAvatarAtIndex:avatarIndex];
                                            }];

        [model.downloadTask resume];
        model.error = nil;
        [model statusWasUpdated];
        [self didChangeDownloadStatusForAvatarAtIndex:avatarIndex];
    }
}

@end
